FROM rockylinux/rockylinux:8

LABEL maintainer='Gabriel Pascual'
LABEL maintainer.email='gabrielfpascual@gmail.com'
LABEL purpose='Intended to install Patroni to orchestrate a high-availability PostgreSQL.'
LABEL description='Patroni is a template for you to create your own customized, high-availability solution using Python and - for maximum accessibility - a distributed configuration store like ZooKeeper, etcd, Consul or Kubernetes. Database engineers, DBAs, DevOps engineers, and SREs who are looking to quickly deploy HA PostgreSQL in the datacenter-or anywhere else-will hopefully find it useful.'

RUN dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
    && dnf -qy module disable postgresql \
    && dnf update -y

RUN dnf install -y \
    gcc glibc-all-langpacks \
    postgresql13-server postgresql13-contrib postgresql13-devel \
    python3 python3-devel python3-pip python3-psycopg2

RUN ln -s /usr/pgsql-13/bin/* /usr/sbin/

RUN groupadd patroni \
    && useradd --home-dir /home/patroni -g patroni patroni

RUN mkdir -p /var/lib/patroni/data/ \
    && chown patroni.patroni /var/lib/patroni/data/ \
    && chmod 700 /var/lib/patroni/data/

USER patroni

WORKDIR /home/patroni

COPY --chown=patroni:patroni ./dependencies/requirements.txt .

RUN python3 -m venv patroni-cluster \
    && source ./patroni-cluster/bin/activate \
    && python3 -m pip install --upgrade pip \
    && python3 -m pip install -r requirements.txt

ENTRYPOINT [ "./patroni-cluster/bin/patroni", "/home/patroni/patroni.yaml" ]
