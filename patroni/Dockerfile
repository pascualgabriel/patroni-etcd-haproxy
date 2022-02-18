FROM rockylinux/rockylinux:8

LABEL maintainer='Gabriel Pascual'
LABEL maintainer.email='gabrielfpascual@gmail.com'
LABEL purpose='Intended to install Patroni to orchestrate a high-availability PostgreSQL.'
LABEL description='Patroni is a template for you to create your own customized, high-availability solution using Python and - for maximum accessibility - a distributed configuration store like ZooKeeper, etcd, Consul or Kubernetes. Database engineers, DBAs, DevOps engineers, and SREs who are looking to quickly deploy HA PostgreSQL in the datacenter-or anywhere else-will hopefully find it useful.'

RUN dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
    && dnf -qy module disable postgresql \
    && dnf update -y

RUN dnf install -y \
    gcc glibc-all-langpacks langpacks-pt_BR \
    postgresql13-server postgresql13-contrib postgresql13-devel \
    python3 python3-devel python3-pip python3-psycopg2

RUN groupadd patroni \
    && useradd --home-dir /home/patroni -g patroni patroni

RUN ln -s /usr/pgsql-13/bin/* /usr/sbin/

RUN ln -s /home/patroni/patroni-cluster/bin/patroni \
    /home/patroni/patroni-cluster/bin/patroni_aws \
    /home/patroni/patroni-cluster/bin/patroni_raft_controller \
    /home/patroni/patroni-cluster/bin/patroni_wale_restore \
    /home/patroni/patroni-cluster/bin/patronictl \
    /usr/sbin/

RUN mkdir -p /var/lib/patroni/data \
    /var/lib/patroni/log \
    /etc/patroni \
    && chown -R patroni.patroni /var/lib/patroni /etc/patroni \
    && chmod -R 700 /var/lib/patroni

USER patroni

WORKDIR /home/patroni

COPY --chown=patroni:patroni ./dependencies/requirements.txt /etc/patroni

RUN python3 -m venv patroni-cluster \
    && source ./patroni-cluster/bin/activate \
    && python3 -m pip install --upgrade pip \
    && python3 -m pip install -r /etc/patroni/requirements.txt

COPY --chown=patroni:patroni ./entrypoint.sh .

ENTRYPOINT [ "bash", "entrypoint.sh" ]
