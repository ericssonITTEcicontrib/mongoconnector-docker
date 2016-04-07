
mongo-connector
-------------
It can be used to build image of [mongo-connector](https://github.com/mongodb-labs/mongo-connector/wiki/Usage%20with%20ElasticSearch) and its dependencies, such as [elastic2-doc-manager](https://github.com/mongodb-labs/elastic2-doc-manager).

- build
```{r, engine='bash', build}
$ docker build -t mongoconnector .
```

- run (mongo and es need to be started before this)
```{r, engine='bash', run}
$ docker run --link some-mongo:my-mongo --link some-es:es -d mongoconnector
```
or 
```{r, engine='bash', run}
$ docker run -e MONGO_HOST="192.168.31.223" -e ES_HOST="192.168.31.223" -e MONGO_IP_ADDR="192.168.31.223" -e MONGO_HOSTNAME="my-mongo" -d mongoconnector
```
> where 
> - MONGO_HOST is the hostname or IP address of mongo server,
> - ES_HOST is the hostname or IP address of es server,
> - MONGO_IP_ADDR is the IP address of mongo server, and
> - MONGO_HOSTNAME is the hostname of mongo in the replica set.

How to get MONGO_HOSTNAME?
Run the following command on your mongo server:

```{r, engine='bash', mongo}
root@my-mongo:/# mongo
> rs.initiate()
rs0:PRIMARY> rs.config()
 
"host" : "my-mongo:27017"
```
