- Projeto: Webhook Ordem de Serviço WhatsApp

## Visão Geral
Este projeto é um sistema de Webhook para Ordem de Serviço, usando filas (BullMQ) e cache (Redis) para alta performance e escalabilidade.


=====================================================================================================================


- Requisitos

##
    - Node.js (>= 18)
    - TypeScript
    - Redis (externo ou local)
    - `pm2` (opcional, para gerenciar processos)


=====================================================================================================================


- Instale as dependências:

## no console, no diretório raiz do projeto:

    - npm i


=====================================================================================================================


- Crie um arquivo .env com:

## Substitua \`localhost:8080\` pelo IP/porta do seu servidor Redis.

    - REDIS_URL=redis://localhost:8080


=====================================================================================================================


- Configure o banco e o Redis:

## Crie o banco e execute a migração Prisma.

## Certifique-se que o Redis esteja rodando (redis-server).

    - No terminal: redis-cli ping OU redis-cli -h localhost -p 8080 ping (especificando host e porta)

    - Se o Redis estiver rodando, ele responde: PONG

    - Se usar localmente, basta iniciar o servidor Redis: redis-server


=====================================================================================================================


- Rode o worker da fila (em um terminal separado):

## Importante: o worker processa as tarefas da fila de forma paralela, por isso roda em um terminal separado.

    - node --loader ts-node/esm src/services/queue.service.ts


=====================================================================================================================


- Chame main no seu controller com o body simulado para processar a mensagem do usuário.




## PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2 PM2
=====================================================================================================================

## Rodando com PM2
**Instale o pm2 globalmente** (caso não tenha):

npm install -g pm2


**Inicie a aplicação e o worker:**

pm2 start src/main.ts --name main --interpreter ts-node
pm2 start src/queue.service.ts --name worker --interpreter ts-node


**Comandos úteis do PM2:**
- Listar processos:

pm2 list

- Parar:

pm2 stop main worker

- Ver logs:

pm2 logs

- Salvar configuração para reiniciar automaticamente após reboot:

pm2 save


## REDIS SERVIDOR UBUNTU REDIS SERVIDOR UBUNTU REDIS SERVIDOR UBUNTU REDIS SERVIDOR UBUNTU REDIS SERVIDOR UBUNTU 
=====================================================================================================================

1️⃣ Verifique se o Redis está instalado no seu Ubuntu WSL2
Execute:

## redis-server --version

- Se aparecer a versão: Ele está instalado! Se disser “command not found”: Você ainda não instalou o Redis.


2️⃣ Instale o Redis (caso não esteja)

## sudo apt update
## sudo apt install redis-server

- 👉 Isso vai instalar o Redis e criar o arquivo de configuração em /etc/redis/redis.conf.


3️⃣ Verifique onde está o redis.conf. Após instalar:

## sudo find /etc -name "redis.conf"

- Normalmente deve aparecer:

## /etc/redis/redis.conf


4️⃣ Abra o redis.conf para editar

## sudo nano /etc/redis/redis.conf


5️⃣ Configure para aceitar conexões externas (como eu te mostrei antes!)
No arquivo redis.conf, altere:

## bind 0.0.0.0 ::1
## port 3040
## requirepass suaSenhaSuperSegura (opcional)

- Configure senha de acesso (opcional, mas recomendado!) Ainda no redis.conf, procure por:

# requirepass foobared

👉 Descomente e defina a senha:

## requirepass minhaSenhaSegura123


6️⃣ Reinicie o Redis para aplicar mudanças

## sudo systemctl restart redis-server


7️⃣ Teste a conexão remota

## redis-cli -h devlinnine.dyndns.org -p 3040 -a suaSenhaSuperSegura


## INFO INFO INFO INFO INFO INFO INFO INFO INFO INFO INFO INFO INFO INFO INFO INFO INFO INFO INFO INFO INFO INFO 
=====================================================================================================================

node v20.14.0 db mysql 8

EXEMPLO LINK PARA CHAMADA DO WEBHOOK: https://wa.me/55{NUM_WHATSAPP}/?text=*Ordem%20de%20servico*%0A{CS_ID}%20%0A{NUM_ROTA}