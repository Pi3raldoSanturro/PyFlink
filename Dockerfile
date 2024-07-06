
FROM flink:1.19.0

RUN apt-get update -y && \
    apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev libffi-dev xz-utils liblzma-dev wget && \
    wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tgz && \
    tar -xvf Python-3.11.0.tgz && \
    cd Python-3.11.0 && \
    ./configure --without-tests --enable-shared && \
    make -j6 && \
    make install && \
    ldconfig /usr/local/lib && \
    cd .. && rm -f Python-3.11.0.tgz && rm -rf Python-3.11.0 && \
    ln -s /usr/local/bin/python3 /usr/local/bin/python && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install PyFlink
COPY apache-flink*.tar.gz /
RUN pip3 install /apache-flink-libraries*.tar.gz && pip3 install /apache-flink*.tar.gz

# Add Flink Kafka connector
RUN wget https://repo1.maven.org/maven2/org/apache/flink/flink-connector-kafka_2.12/1.9.0/flink-connector-kafka_2.12-1.9.0.jar -P /opt/flink/lib/

USER flink

WORKDIR /opt/flink/jobs




