FROM rockylinux/rockylinux:8

LABEL maintainer='Gabriel Pascual'
LABEL maintainer.email='gabrielfpascual@gmail.com'
LABEL purpose='Intended to install Patroni to orchestrate a high-availability PostgreSQL.'
LABEL description='Patroni is a template for you to create your own customized, high-availability solution using Python and - for maximum accessibility - a distributed configuration store like ZooKeeper, etcd, Consul or Kubernetes. Database engineers, DBAs, DevOps engineers, and SREs who are looking to quickly deploy HA PostgreSQL in the datacenter-or anywhere else-will hopefully find it useful.'

RUN dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
    && dnf -qy module disable postgresql \
    && dnf update -y

RUN dnf install -y \
    openssh-clients openssh-server \
    gcc glibc-all-langpacks langpacks-pt_BR \
    postgresql13-server postgresql13-contrib postgresql13-devel \
    python3 python3-devel python3-pip python3-psycopg2 \
    rsync

RUN groupadd patroni \
    && useradd --home-dir /home/patroni -g patroni patroni

ARG OS_PATRONI_USER_PASS=${OS_PATRONI_USER_PASS}

RUN echo "patroni:${OS_PATRONI_USER_PASS}" | chpasswd

RUN sed -i -r 's/^#(.*Port 22.*)$/\1/' /etc/ssh/sshd_config \
    && sed -i -r 's/^#(.*ListenAddress 0.0.0.0.*)$/\1/' /etc/ssh/sshd_config \
    && ssh-keygen -A \
    && mkdir -p /run/sshd \
    && rm -rf /run/nologin \
    && chown -R root.patroni /etc/ssh \
    && chmod -R g+r /etc/ssh

RUN ln -s /usr/pgsql-13/bin/* /usr/sbin/

RUN mkdir -p /var/lib/patroni/data \
    && mkdir -p /var/lib/patroni/log \
    && chown -R patroni.patroni /var/lib/patroni \
    && chmod -R 700 /var/lib/patroni

USER patroni

WORKDIR /home/patroni

RUN ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N "" \
    && echo 'StrictHostKeyChecking no' >> ~/.ssh/config

COPY --chown=patroni:patroni ./dependencies/requirements.txt .

RUN python3 -m venv patroni-cluster \
    && source ./patroni-cluster/bin/activate \
    && python3 -m pip install --upgrade pip \
    && python3 -m pip install -r requirements.txt

COPY --chown=patroni:patroni ./entrypoint.sh .

ENTRYPOINT [ "bash", "entrypoint.sh" ]
