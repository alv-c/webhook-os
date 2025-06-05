
import { ordemServicoQueue } from './queue.service.js';
import redis from './redis.service.js';
import { sendMsg } from './message.service.js';

export const main = async (req: any) => {
    const dataMessage: any = req.body?.Body?.Text;
    const senderJid = req.body?.Body?.Info?.SenderJid?.match(/^(\d+)@/)?.[1];

    if (!senderJid || req.body?.Type !== 'receveid_message' || !dataMessage) {
        return { status: 400, data: { message: 'Requisição inválida: dados ausentes ou tipo incorreto' } };
    }

    const redisKey = `os:buffer:${senderJid}`;

    if (dataMessage.startsWith('*Ordem de servico*')) {
        const lines = dataMessage.split('\n').slice(1);
        const [cs_id, num_rota] = lines;

        const payload = {
            nome: req.body?.Body?.Info?.PushName,
            whatsapp: senderJid,
            cs_id: cs_id?.trim(),
            num_rota: num_rota?.trim(),
            descricao_problema: null,
        };

        await redis.set(redisKey, JSON.stringify(payload), 'EX', 600);

        await sendMsg(req.body, `Olá ${payload.nome}. Agora, *ESCREVA* com detalhes o problema em questão, em *APENAS 1 MENSAGEM*; para abertura da *ORDEM DE SERVIÇO*! *(MÁXIMO 100 CARACTERES)*`);

        return { status: 200, data: { message: 'Buffer de ordem de serviço criado no Redis' } };
    } else {
        const existing = await redis.get(redisKey);
        if (!existing) {
            return { status: 404, data: { message: 'Nenhum buffer encontrado para esta ordem de serviço' } };
        }

        const parsed = JSON.parse(existing);
        parsed.descricao_problema = dataMessage.slice(0, 100);

        await redis.del(redisKey);

        await ordemServicoQueue.add('criarOS', parsed);

        // await sendMsg(req.body, `Recebido! Ordem de serviço emitida com sucesso.`);

        return { status: 200, data: { message: 'Ordem de serviço adicionada à fila e emitida com sucesso' } };
    }
};
