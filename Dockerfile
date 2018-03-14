FROM python:3.6-jessie

LABEL author="Dmitry Shelepnev admin@sopds.ru"
LABEL devops="Evgeny Stoyanov quick.es@gmail.com"
LABEL name="SOPDS books catalog"
LABEL url="https://github.com/mitshel/sopds"
LABEL version="master"

ENV SOPDS_DIR="/opt/sopds-master" \
    SOPDS_LANG='ru-RU' \
    SOPDS_USER='admin' \
    SOPDS_PASSWORD='admin' \
    SOPDS_EMAIL='user@user.user'

COPY entrypoint.sh ${SOPDS_DIR}/entrypoint.sh

RUN chmod +x ${SOPDS_DIR}/entrypoint.sh \
    && apt update \
    && apt install -y mysql-client unzip \
    && wget -nv https://github.com/mitshel/sopds/archive/master.zip \
    && unzip master.zip -d /opt \
    && pip install mysqlclient \
    && pip install -r ${SOPDS_DIR}/requirements.txt

COPY settings.py ${SOPDS_DIR}/sopds/settings.py

WORKDIR ${SOPDS_DIR}
ENTRYPOINT [ "./entrypoint.sh" ]
CMD [ "server" ]