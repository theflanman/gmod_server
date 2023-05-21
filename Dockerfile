FROM steamcmd/steamcmd:latest AS gmod

ENV APP_ID 4020
ENV SERVER_DIR /srv/steam

RUN mkdir -p ${SERVER_DIR}

RUN steamcmd \
    +force_install_dir ${SERVER_DIR} \
    +login anonymous \
    +app_update ${APP_ID} validate \
    +quit

RUN adduser --disabled-password steam

RUN chown -R steam:steam ${SERVER_DIR}

USER steam

ENTRYPOINT ${SERVER_DIR}/srcds_run -game garrysmod +maxplayers 12 +map gm_flatgrass +sv_setsteamaccount ${API_KEY} +hostname ${SERVER_NAME}