ARG TARGETARCH
ARG OS=linux


FROM --platform=$OS/$TARGETARCH alpine:3.21.0

ARG TARGETARCH
ARG OS

ENV TARGETARCH=$TARGETARCH
ENV OS=$OS

USER root
WORKDIR /app

COPY app/run.sh /app/run.sh

RUN apk update && apk add --no-cache \
    curl \
    bash \
    unzip \
    && rm -rf /var/cache/apk/*







ENTRYPOINT [ "sh", "/app/run.sh" ]