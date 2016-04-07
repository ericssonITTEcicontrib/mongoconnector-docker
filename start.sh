#! /bin/bash


# mongo from linked container
if [ ! -z ${MY_MONGO_PORT_27017_TCP_ADDR} ] ; then
  MONGO_IP=${MY_MONGO_PORT_27017_TCP_ADDR}
fi

# mongo from env
if [ ! -z ${MONGO_HOST} ] ; then
  MONGO_IP=${MONGO_HOST}
  if [ ! -z ${MONGO_HOSTNAME} ] && [ ! -z ${MONGO_IP_ADDR} ]; then
    echo "add dns entry: ${MONGO_IP_ADDR} ${MONGO_HOSTNAME}"
    echo "${MONGO_IP_ADDR} ${MONGO_HOSTNAME}" >> /etc/hosts
  else
    echo '${MONGO_IP_ADDR} and ${MONGO_HOSTNAME} is not defined'
    exit 1;
  fi
fi

# change mongodb ip
if [ ! -z ${MONGO_IP} ] ; then
  echo "change mongodb ip: ${MONGO_IP}"
  sed -i -e "s/localhost:27017/${MONGO_IP}:27017/g" /usr/src/app/config.json
else
  echo 'Neither ${MY_MONGO_PORT_27017_TCP_ADDR} or ${MONGO_HOST} is defined'
  exit 1;
fi

# es from linked container
if [ ! -z ${ES_PORT_9200_TCP_ADDR} ] ; then
  ES_IP=${ES_PORT_9200_TCP_ADDR}
fi

# es from env
if [ ! -z ${ES_HOST} ] ; then
  ES_IP=${ES_HOST}
fi

# change es ip
if [ ! -z ${ES_IP} ] ; then
  echo "change es ip: ${ES_IP}"
  sed -i -e "s/localhost:9200/${ES_IP}:9200/g" /usr/src/app/config.json
else
  echo 'Neither ${ES_PORT_9200_TCP_ADDR} or ${ES_HOST} is defined'
  exit 1;
fi

mongo-connector -c /usr/src/app/config.json
