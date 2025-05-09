import 'dotenv/config';
import { Request, Response, NextFunction } from 'express';
import axios from 'axios';
import osu from 'node-os-utils';
import https from 'https';
import { PrismaClient } from '@prisma/client/storage/client.js';
import { BasicAndBearerStrategy, dateTimeFormatterUtil, HttpClientUtil } from '../../expressium/src/index.js';

const prisma = new PrismaClient();

export const getHealth = async (
    req: Request, 
    _res: Response, 
    _next: NextFunction, 
    timestamp: string
): Promise<any> => {
return {
    status: 200,
    data: {
    timestamp,
    status: true,
    statusCode: 200,
    method: req.method,
    path: req.originalUrl || req.url,
    query: req.query,
    headers: req.headers,
    body: req.body,
    uptime: dateTimeFormatterUtil.formatDuration(process.uptime() / 1000),
    cpuUsage: `${ await osu.cpu.usage() }%`,
    memoryUsage: `${ (await osu.mem.used()).usedMemMb }MB`
    }
};
};

export const sendMsg = async (data: any, msg: any) => {
    const string = data.Body.Info.RemoteJid;
    const result = string.match(/[^@]*/);
    const telefone = result[0];

    const url = process.env.CHATPRO_ENDPOINT_MAIN as string;
    const authToken = process.env.CHATPRO_TOKEN_AUTH as string;
    const instanceId = process.env.CHATPRO_INTANCIA as string;

    let requestData = {
        number: telefone,
        message: msg,
    }

    // console.log(url, authToken, instanceId, requestData)

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
        // console.log(response);
    } catch (error) {
        console.log(error);
    }
    return
}

export const saveMsg = async (body: any) => {
    try {
        const twentyFourHoursAgo = new Date();
        twentyFourHoursAgo.setHours(twentyFourHoursAgo.getHours() - 24);
        const existingRecords = await prisma.ordens_servico_wpp.findMany({
            where: {
                OR: [
                    { status: 'pendente' },
                    // {
                    //     status: 'aberta',
                    //     created_at: { gte: twentyFourHoursAgo },
                    // },
                ],
            },
        });
        const isCsIdExist = existingRecords.some((record: any) => {
            const dataJson = record.data_json as { [key: string]: any };
            return dataJson && dataJson.cs_id === body.cs_id;
        });
        if (isCsIdExist) {
            console.log(`Já existe uma ordem pendente com este CS ID ${body.cs_id} inserida nas últimas 24 horas.`);
            return false;
        }
        type Result = { id: number };
        let id: number | null = null;
        const response = await prisma.$transaction(async (prisma: any) => {
            await prisma.$queryRaw`
                INSERT INTO ordens_servico_wpp (data_json, \`status\`)
                VALUES (${body}, 'pendente');
            `;
            const result = await prisma.$queryRaw<Result[]>`
                SELECT id
                FROM ordens_servico_wpp
                WHERE id = LAST_INSERT_ID();
            `;
            return result[0]?.id || null;
        });
        id = response;
        let retornoRequest = await sendRequestToApi(id, body);
        return retornoRequest;
    } catch (e) {
        console.log('Erro ao salvar a mensagem:', e);
        return;
    }
};

const sendRequestToApi = async (id: number | null, body: any) => {
    try {
        const httpClientInstance = new HttpClientUtil.HttpClient();
        httpClientInstance.setAuthenticationStrategy(
            new BasicAndBearerStrategy.BasicAndBearerStrategy(
                'get',
                'http://localhost:3120/api/v1/get/authentication',
                'admin',
                'admin@192837465'
            )
        );
        const { data } = await httpClientInstance.post<any>(
            'http://localhost:3120/api/v1/create/service-order',
            {
                data: {
                    id: id ? id.toString() : '0000',
                    data_json: body || '',
                }
            }
        );
        const updateResult = await prisma.$transaction(async (prisma: any) => {
            const updateSuccess = await updateOrderStatus(prisma, id, data.data.id);
            return updateSuccess;
        });
        return true;
    } catch (e) {
        console.log('Erro ao enviar requisição para a API:', e);
        if (id) await deleteOrderById(id);
        throw new Error('Erro ao enviar requisição para a API');
    }
};

const updateOrderStatus = async (prisma: any, id: number | null, dataId: string) => {
    if (id === null) {
        throw new Error('ID não pode ser nulo.');
    }
    try {
        await prisma.ordens_servico_wpp.update({
            where: { id },
            data: {
                id_os: dataId,
                status: 'aberta',
            },
        });
        return true;
    } catch (e) {
        console.log(`Erro ao atualizar ordem de serviço com id ${id}:`, e);
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
            console.log(`Ordem de serviço com ID ${id} foi excluída com sucesso.`);
        });
        return true;
    } catch (e) {
        console.log('Erro ao excluir a ordem de serviço:', e);
        return false;
    }
};
