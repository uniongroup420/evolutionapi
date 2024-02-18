FROM node:20.7.0-alpine AS builder

LABEL version="1.6.1" description="Api to control whatsapp features through http requests." 
LABEL maintainer="Davidson Gomes" git="https://github.com/DavidsonGomes"
LABEL contact="contato@agenciadgcode.com"

RUN apk update && apk upgrade && \
    apk add --no-cache git tzdata ffmpeg wget curl chromium

WORKDIR /evolution

COPY ./package.json .

RUN npm install

COPY . .

RUN npm run build

FROM node:20.7.0-alpine AS final

ENV TZ=America/Sao_Paulo
ENV DOCKER_ENV=true

ENV SERVER_TYPE=http
ENV SERVER_PORT=8080
ENV SERVER_URL=http://localhost:8080

ENV CORS_ORIGIN=*
ENV CORS_METHODS=POST,GET,PUT,DELETE
ENV CORS_CREDENTIALS=true

ENV LOG_LEVEL=ERROR,WARN,DEBUG,INFO,LOG,VERBOSE,DARK,WEBHOOKS
ENV LOG_COLOR=true
ENV LOG_BAILEYS=error

ENV DEL_INSTANCE=false

ENV STORE_MESSAGES=true
ENV STORE_MESSAGE_UP=true
ENV STORE_CONTACTS=true
ENV STORE_CHATS=true

ENV CLEAN_STORE_CLEANING_INTERVAL=7200
ENV CLEAN_STORE_MESSAGES=true
ENV CLEAN_STORE_MESSAGE_UP=true
ENV CLEAN_STORE_CONTACTS=true
ENV CLEAN_STORE_CHATS=true

ENV DATABASE_ENABLED=false
ENV DATABASE_CONNECTION_URI=mongodb://root:root@mongodb:27017/?authSource=admin&readPreference=primary&ssl=false&directConnection=true
ENV DATABASE_CONNECTION_DB_PREFIX_NAME=evolution

ENV DATABASE_SAVE_DATA_INSTANCE=false
ENV DATABASE_SAVE_DATA_NEW_MESSAGE=false
ENV DATABASE_SAVE_MESSAGE_UPDATE=false
ENV DATABASE_SAVE_DATA_CONTACTS=false
ENV DATABASE_SAVE_DATA_CHATS=false

ENV REDIS_ENABLED=false
ENV REDIS_URI=redis://redis:6379
ENV REDIS_PREFIX_KEY=evolution

ENV RABBITMQ_ENABLED=false
ENV RABBITMQ_URI=amqp://guest:guest@rabbitmq:5672

ENV WEBSOCKET_ENABLED=false

ENV SQS_ENABLED=false
ENV SQS_ACCESS_KEY_ID=
ENV SQS_SECRET_ACCESS_KEY=
ENV SQS_ACCOUNT_ID=
ENV SQS_REGION=

ENV WEBHOOK_GLOBAL_URL=
ENV WEBHOOK_GLOBAL_ENABLED=false

ENV WEBHOOK_GLOBAL_WEBHOOK_BY_EVENTS=false

ENV WEBHOOK_EVENTS_APPLICATION_STARTUP=false
ENV WEBHOOK_EVENTS_INSTANCE_CREATE=false
ENV WEBHOOK_EVENTS_INSTANCE_DELETE=false
ENV WEBHOOK_EVENTS_QRCODE_UPDATED=true
ENV WEBHOOK_EVENTS_MESSAGES_SET=true
ENV WEBHOOK_EVENTS_MESSAGES_UPSERT=true
ENV WEBHOOK_EVENTS_MESSAGES_UPDATE=true
ENV WEBHOOK_EVENTS_MESSAGES_DELETE=true
ENV WEBHOOK_EVENTS_SEND_MESSAGE=true
ENV WEBHOOK_EVENTS_CONTACTS_SET=true
ENV WEBHOOK_EVENTS_CONTACTS_UPSERT=true
ENV WEBHOOK_EVENTS_CONTACTS_UPDATE=true
ENV WEBHOOK_EVENTS_PRESENCE_UPDATE=true
ENV WEBHOOK_EVENTS_CHATS_SET=true
ENV WEBHOOK_EVENTS_CHATS_UPSERT=true
ENV WEBHOOK_EVENTS_CHATS_UPDATE=true
ENV WEBHOOK_EVENTS_CHATS_DELETE=true
ENV WEBHOOK_EVENTS_GROUPS_UPSERT=true
ENV WEBHOOK_EVENTS_GROUPS_UPDATE=true
ENV WEBHOOK_EVENTS_GROUP_PARTICIPANTS_UPDATE=true
ENV WEBHOOK_EVENTS_CONNECTION_UPDATE=true
ENV WEBHOOK_EVENTS_CALL=true

ENV WEBHOOK_EVENTS_NEW_JWT_TOKEN=false

ENV WEBHOOK_EVENTS_TYPEBOT_START=false
ENV WEBHOOK_EVENTS_TYPEBOT_CHANGE_STATUS=false

ENV WEBHOOK_EVENTS_CHAMA_AI_ACTION=false

ENV WEBHOOK_EVENTS_ERRORS=false
ENV WEBHOOK_EVENTS_ERRORS_WEBHOOK=

ENV CONFIG_SESSION_PHONE_CLIENT=EvolutionAPI
ENV CONFIG_SESSION_PHONE_NAME=Chrome

ENV QRCODE_LIMIT=30
ENV QRCODE_COLOR=#198754

ENV TYPEBOT_API_VERSION=latest

ENV AUTHENTICATION_TYPE=apikey

ENV AUTHENTICATION_API_KEY=B6D711FCDE4D4FD5936544120E713976
ENV AUTHENTICATION_EXPOSE_IN_FETCH_INSTANCES=true

ENV AUTHENTICATION_JWT_EXPIRIN_IN=0
ENV AUTHENTICATION_JWT_SECRET='L=0YWt]b2w[WF>#>:&E`'

ENV AUTHENTICATION_INSTANCE_MODE=server

ENV AUTHENTICATION_INSTANCE_NAME=evolution
ENV AUTHENTICATION_INSTANCE_WEBHOOK_URL=<url>
ENV AUTHENTICATION_INSTANCE_CHATWOOT_ACCOUNT_ID=1
ENV AUTHENTICATION_INSTANCE_CHATWOOT_TOKEN=123456
ENV AUTHENTICATION_INSTANCE_CHATWOOT_URL=<url>

WORKDIR /evolution

COPY --from=builder /evolution .

CMD [ "node", "./dist/src/main.js" ]
