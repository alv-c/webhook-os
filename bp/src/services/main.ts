import { saveMsg, sendMsg } from './app.service.js';
let jsonBuffers: Array<{ buffer: Buffer, timestamp: number }> = [];

export const main = async (req: any) => {
    const dataMessage: any = req.body?.Body?.Text;
    if (req.body?.Type === 'receveid_message' && dataMessage) {
        const dataArrayOrdemServ = dataMessage.split('\n');
        if (dataArrayOrdemServ[0] === '*Ordem de servico*') {
            dataArrayOrdemServ.splice(0, 1);
            const jsonBuffer = Buffer.from(JSON.stringify([{
                nome: req.body?.Body?.Info?.PushName,
                whatsapp: req.body?.Body?.Info?.SenderJid.match(/^(\d+)@/)[1],
                cs_id: dataArrayOrdemServ[0].trim(),
                num_rota: dataArrayOrdemServ[1],
                descricao_problema: null,
            }]));
            jsonBuffers.push({ buffer: jsonBuffer, timestamp: Date.now() });
            let msg = `Olá ${req.body?.Body?.Info.PushName}. Agora, *ESCREVA* com detalhes o problema em questão, em *APENAS 1 MENSAGEM*; para abertura da *ORDEM DE SERVIÇO*! *(MÁXIMO 100 CARACTERES)*`;
            await sendMsg(req.body, msg);
        } else if (req.body?.Body?.Info?.SenderJid && jsonBuffers.length > 0) {
            let jsonInsert = null;
            const senderJid = req.body?.Body?.Info?.SenderJid.match(/^(\d+)@/)[1];
            for (let i = 0; i < jsonBuffers.length; i++) {
                const item = jsonBuffers[i];
                const jsonArray = JSON.parse(item.buffer.toString());
                const foundJson = jsonArray.find((obj: any) => obj.whatsapp === senderJid);
                if (foundJson) {
                    jsonInsert = foundJson;
                    break;
                }
            }
            if (!jsonInsert) return;
            jsonBuffers = jsonBuffers.filter(item => {
                const jsonArray = JSON.parse(item.buffer.toString());
                return !jsonArray.some((obj: any) => obj.whatsapp === senderJid);
            });
            addDescricaoProblema(jsonInsert, req.body?.Body?.Text);
            let updatedBuffer = Buffer.from(JSON.stringify([jsonInsert]));
            jsonBuffers.push({ buffer: updatedBuffer, timestamp: Date.now() });
            let msg = '';
            try {
                let retornoSave = await saveMsg(jsonInsert);
                if (!retornoSave) {
                    // msg = `Essa conta já *possui uma O.S aberta com a mesma solicitação, em um periodo menor que 24 horas* 
                    // ou com o *status Pendente*. Por favor, *aguarde ao menos 24 horas* para abrir outra OS, ou ligue *0800-062-1800*`;
                    msg = `Esta conta *já possui uma ORDEM DE SERVIÇO pendente*, aguarde a resolução, ou ligue *0800-062-1800 em caso de URGÊNCIA*.`;
                } else {
                    msg = `Ordem de serviço emitida com sucesso! Aguarde o processo de análise, que logo entraremos em contato.`;
                }
                await sendMsg(req.body, msg);
            } catch (error) {
                msg = `Erro ao tentar emitir *ORDEM DE SERVIÇO*. Por favor, tente novamente em alguns instantes!`;
                await sendMsg(req.body, msg);
                console.error("Erro ao salvar a mensagem:", error);
            }
        }
    }
    cleanExpiredBuffers();
    return {
        status: 200,
        data: {}
    }
}

function addDescricaoProblema(jsonObject: any, descricao: any) {
    jsonObject.descricao_problema = descricao;
}

function cleanExpiredBuffers() {
    const now = Date.now();
    const expirationTime = 10 * 60 * 1000;
    jsonBuffers = jsonBuffers.filter(item => now - item.timestamp <= expirationTime);
}