#!/bin/sh

# 拷贝源文件
if [ ! -d "${YAPI_DATA_DIR}/yapi" ]; then
    echo
    echo "+-------------------------------------------+"
    echo "|              Initializing...              |"
    echo "+-------------------------------------------+"
    echo
    echo "copy ${YAPI_APP_DIR} to ${YAPI_DATA_DIR}/yapi..."
    cp -R $YAPI_APP_DIR $YAPI_DATA_DIR/yapi
    rm "${YAPI_DATA_DIR}/yapi/docker-entrypoint.sh"
fi

# 初始化数据库
if [ ! -f "${YAPI_DATA_DIR}/yapi/init.lock" ]; then
    cd "${YAPI_DATA_DIR}/yapi/vendors"
    npm run install-server
fi

# 启动服务
cd "${YAPI_DATA_DIR}/yapi/vendors"
npm run start