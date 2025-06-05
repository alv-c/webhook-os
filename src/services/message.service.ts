import 'dotenv/config';
import axios from 'axios';
import { PrismaClient } from '@prisma/client/storage/client.js';
import { BasicAndBearerStrategy, HttpClientUtil } from '../../expressium/src/index.js';

const prisma = new PrismaClient();

export const sendMsg = async (data: any, msg: any) => {
    const string = data.Body.Info.RemoteJid;
    const result = string.match(/[^@]*/);
    const telefone = result ? result[0] : '';

    const url = process.env.CHATPRO_ENDPOINT_MAIN as string;
    const authToken = process.env.CHATPRO_TOKEN_AUTH as string;
    const instanceId = process.env.CHATPRO_INTANCIA as string;

    let requestData = {
        number: telefone,
        message: msg,
    };

    try {
        const response = await axios.post(url, requestData, {
            headers: {
                Authorization: authToken,
                'Content-Type': 'application/json'
            },
            params: {
                instance_id: instanceId
            }
        });
        console.log('Mensagem enviada com sucesso');
        return { status: 200, data: { message: 'Mensagem enviada com sucesso' } };
    } catch (error) {
        console.error('Erro ao enviar mensagem:', error);
        return { status: 500, data: { message: 'Erro ao enviar mensagem' } };
    }
};

export const saveMsg = async (body: any) => {
    try {
        const twentyFourHoursAgo = new Date();
        twentyFourHoursAgo.setHours(twentyFourHoursAgo.getHours() - 24);

        const existingRecords = await prisma.ordens_servico_wpp.findMany({
            where: {
                OR: [
                    { status: 'aberta' },
                ],
            },
        });

        const isCsIdExist = existingRecords.some((record: any) => {
            const dataJson = record.data_json as { [key: string]: any };
            return dataJson && dataJson.cs_id === body.cs_id;
        });

        if (isCsIdExist) {
            const message = `Já existe uma ordem de serviço com as mesmas credenciais inserida nas últimas 24 horas. Por favor, aguarde, ou *ligue em casos de urgência: 0800
            `;
            console.log(message);
            return { status: 409, data: { message } };
        }

        let id: number | null = null;
        const response = await prisma.$transaction(async (prisma: any) => {
        await prisma.$queryRaw`
            INSERT INTO ordens_servico_wpp (data_json, \`status\`)
            VALUES (${body}, 'pendente');
      `;
        const result = await prisma.$queryRaw<{ id: number }[]>`
            SELECT id
            FROM ordens_servico_wpp
            WHERE id = LAST_INSERT_ID();
      `;
            return result[0]?.id || null;
        });
        id = response;

        const apiResult = await sendRequestToApi(id, body);
        return { status: 201, data: { message: 'Ordem de serviço emitida com sucesso.', id } };
    } catch (e) {
        console.error('Erro ao salvar a mensagem:', e);
        return { status: 500, data: { message: 'Erro ao salvar a ordem de serviço' } };
    }
};

const sendRequestToApi = async (id: number | null, body: any): Promise<boolean> => {
    try {
        const httpClient = new HttpClientUtil.HttpClient();
        httpClient.setAuthenticationStrategy(
            new BasicAndBearerStrategy.BasicAndBearerStrategy(
                'get',
                'http://192.168.2.75:3120/api/v1/get/authentication',
                'admin',
                'admin@192837465'
            )
        );

        const { data } = await httpClient.post<any>(
            'http://192.168.2.75:3120/api/v1/create/service-order-x1',
            {
                data: {
                    id: id ? id.toString() : '0000',
                    data_json: body || '',
                }
            }
        );

        if (id !== null) {
            await prisma.ordens_servico_wpp.update({
                where: { id },
                data: {
                    id_os: data.data.id,
                    status: 'aberta',
                },
            });
        }
        console.log('Ordem de serviço enviada para API e atualizada com sucesso.');
        return true;
    } catch (e) {
        console.error('Erro ao enviar requisição para a API:', e);
        if (id) await deleteOrderById(id);
        return false;
    }
};

const deleteOrderById = async (id: number | null) => {
    if (!id) {
        console.log('ID inválido para exclusão');
        return false;
    }
    try {
        await prisma.$transaction(async (prisma: any) => {
            await prisma.ordens_servico_wpp.delete({
                where: { id },
            });
        });
        console.log(`Ordem de serviço com ID ${id} foi excluída com sucesso.`);
        return true;
    } catch (e) {
        console.error('Erro ao excluir a ordem de serviço:', e);
        return false;
    }
};
