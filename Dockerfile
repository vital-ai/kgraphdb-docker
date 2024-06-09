FROM openjdk:11-jre-slim

RUN apt-get update && apt-get install -y unzip

ENV FUSEKI_BASE=/fuseki
ENV FUSEKI_HOME=/fuseki

RUN mkdir -p /fuseki

COPY apache-jena-fuseki-4.9.0.zip /fuseki/

WORKDIR /fuseki

RUN unzip apache-jena-fuseki-4.9.0.zip && \
    mv apache-jena-fuseki-4.9.0/* /fuseki/ && \
    rm -rf apache-jena-fuseki-4.9.0.zip apache-jena-fuseki-4.9.0

RUN chmod +x /fuseki/fuseki-server

EXPOSE 3030

# Mounting:
#    volumes:
#      - ./fuseki-data:/fuseki-data
#      - ./config.ttl:/fuseki/config.ttl
#      - ./shiro.ini:/fuseki/shiro.ini
#      - ./configuration:/fuseki/configuration
#      - ./databases:/fuseki/databases

LABEL maintainer="Marc Hadfield <marc@vital.ai>"
LABEL version="0.1.0"
LABEL description="KGraph Database implemented using Jena Fuseki/TDB2"

CMD ["/fuseki/fuseki-server", "--config=/fuseki/config.ttl"]
