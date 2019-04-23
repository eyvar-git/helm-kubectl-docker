FROM alpine:3.9

MAINTAINER FLS DevOps <devops@fls.com>

#ARG K8S_VERSION
#ARG HELM_VERSION
ENV K8S_VERSION=v1.14.1
ENV HELM_VERSION=v2.13.1
ENV HELM_FILENAME=helm-${HELM_VERSION}-linux-amd64.tar.gz

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl  \
 && apk add --update gettext tar gzip git \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${K8S_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && curl -L https://storage.googleapis.com/kubernetes-helm/${HELM_FILENAME} | tar xz && mv linux-amd64/helm /bin/helm && rm -rf linux-amd64 \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/*

CMD ["helm"]
