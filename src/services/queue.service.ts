import { Queue, Worker } from 'bullmq';
import { saveMsg, sendMsg } from './message.service.js';
import { Redis } from 'ioredis';

const connection = new Redis(process.env.REDIS_URL || 'redis://localhost:6379', {
    maxRetriesPerRequest: null,
});

export const ordemServicoQueue = new Queue('ordemServico', { connection });

new Worker(
    'ordemServico',
    async job => {
        const payload = job.data;
        const saveResponse = await saveMsg(payload);

        const message =
            typeof saveResponse?.data?.message === 'string'
                ? saveResponse.data.message
                : 'Não foi possível processar sua solicitação. Tente novamente mais tarde.';

        await sendMsg(
            {
                Body: {
                    Info: {
                        RemoteJid: `${payload.whatsapp}@s.whatsapp.net`
                    }
                }
            },
            message
        );
    },
    { connection }
);
