FROM rockylinux/rockylinux:8 AS etcd_downloader

RUN dnf update -y \
    && dnf install -y jq

RUN LATEST_ETCD_VERSION=$(curl -s "https://storage.googleapis.com/storage/v1/b/etcd/o/?delimiter=/" | jq -r '.prefixes[-1]' | tr -d '/') \
    ETCD_GCP_STORAGE_URI="https://etcd.storage.googleapis.com/$LATEST_ETCD_VERSION/etcd-$LATEST_ETCD_VERSION-linux-amd64.tar.gz" \
    && mkdir -p /opt/etcd \
    && curl -s "$ETCD_GCP_STORAGE_URI" \
    | tar -xzvC /opt/etcd --strip-components 1 \
    && cd /opt/etcd \
    && rm -rf Documentation *.md

FROM rockylinux/rockylinux:8

LABEL maintainer='Gabriel Pascual'
LABEL maintainer.email='gabrielfpascual@gmail.com'
LABEL purpose='Intended to install etcd to persist distributed, reliable key-value store for the critical data of Patroni distributed system.'
LABEL description='etcd is a strongly consistent, distributed key-value store that provides a reliable way to store data that needs to be accessed by a distributed system or cluster of machines. It gracefully handles leader elections during network partitions and can tolerate machine failure, even in the leader node.'

COPY --from=etcd_downloader /opt/etcd /usr/local/sbin

RUN mkdir -p /etc/etcd \
    && mkdir -p /var/lib/etcd/

RUN groupadd etcd \
    && useradd -s /sbin/nologin -g etcd etcd \
    && chown -R etcd.etcd /etc/etcd /var/lib/etcd

USER etcd

ENTRYPOINT [ "etcd", "--config-file", "/var/lib/etcd/etcd.yaml" ]
