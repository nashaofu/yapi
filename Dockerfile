FROM node:12

# Working enviroment
ENV YAPI_APP_DIR /var/app/yapi
ENV YAPI_DATA_DIR /var/data/yapi

RUN mkdir -p ${YAPI_APP_DIR}

WORKDIR ${YAPI_APP_DIR}

COPY . ${YAPI_APP_DIR}/vendors

RUN npm set registry https://registry.npm.taobao.org
RUN cd ${YAPI_APP_DIR}/vendors && npm install --production

COPY dockerize/docker-entrypoint.sh ${YAPI_APP_DIR}
COPY dockerize/config.json ${YAPI_APP_DIR}

EXPOSE 3000/tcp

# Entrypoint
ENTRYPOINT ["sh", "docker-entrypoint.sh"]
