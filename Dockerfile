FROM node:10.15.2-jessie-slim

LABEL maintainer "Phillip Ulberg <phillip.ulberg@raymondjames.com>"

ARG ek_version=7.3.1

RUN useradd -ms /bin/bash elasticsearch

USER elasticsearch

WORKDIR /home/elasticsearch

ENV ES_TMPDIR=/home/elasticsearch/elasticsearch.tmp \
    ES_DATADIR=/home/elasticsearch/elasticsearch/data \
    JAVA_HOME=/home/elasticsearch/elasticsearch/jdk

RUN wget -q -O - https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ek_version}-linux-x86_64.tar.gz \
 |  tar -zx \
 && mv elasticsearch-${ek_version} elasticsearch \
 && mkdir -p ${ES_TMPDIR} ${ES_DATADIR} \
 && wget -q -O - https://artifacts.elastic.co/downloads/kibana/kibana-${ek_version}-linux-x86_64.tar.gz \
 |  tar -zx \
 && mv kibana-${ek_version}-linux-x86_64 kibana \
 && rm -f kibana/node/bin/node \
 && ln -s $(which node) kibana/node/bin/node

 RUN sed -i -e 's/-Xms1g/-Xms4g/g' /home/elasticsearch/elasticsearch/config/jvm.options \
 && sed -i -e 's/-Xmx1g/-Xmx4g/g' /home/elasticsearch/elasticsearch/config/jvm.options

CMD bash elasticsearch/bin/elasticsearch -E http.host=0.0.0.0 --quiet & kibana/bin/kibana --host 0.0.0.0 -Q

EXPOSE 9200 5601
