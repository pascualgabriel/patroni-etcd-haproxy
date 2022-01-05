FROM centos:7

RUN yum install -y epel-release \
    https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm

RUN curl 'https://dl.2ndquadrant.com/default/release/get/13/rpm' | bash \
    && sed -i 's/\[pgdg-common\]/\[pgdg-common\]\nexclude=barman* python*-barman/' /etc/yum.repos.d/pgdg-redhat-all.repo

RUN yum install -y \
    openssh-clients openssh-server sshpass \
    python2-psycopg2 \
    barman barman-cli \
    rsync

ARG OS_BARMAN_USER_PASS=${OS_BARMAN_USER_PASS}

RUN echo "barman:${OS_BARMAN_USER_PASS}" | chpasswd

RUN sed -i -r 's/^#(.*Port 22.*)$/\1/' /etc/ssh/sshd_config \
    && sed -i -r 's/^#(.*ListenAddress 0.0.0.0.*)$/\1/' /etc/ssh/sshd_config \
    && ssh-keygen -A \
    && mkdir -p /run/sshd \
    && rm -rf /run/nologin \
    && chown -R root.barman /etc/ssh \
    && chmod -R g+r /etc/ssh

RUN mkdir -p /var/lib/barman/data \
    /var/lib/barman/data/INCOMING \
    /var/lib/barman/data/BACKUPS \
    && chown -R barman.barman /var/lib/barman/data

RUN cp /etc/barman.conf /etc/barman.sample.conf \
    && chown -R barman.barman /etc/barman.d \
    /etc/barman.sample.conf /etc/barman.conf

USER barman

WORKDIR /var/lib/barman

RUN ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N "" \
    && echo 'StrictHostKeyChecking no' >> ~/.ssh/config

RUN echo "*:*:*:barman_backup:example" > ~/.pgpass \
    && chmod 0600 ~/.pgpass

COPY --chown=barman:barman ./config/barman.conf /etc/barman.conf

COPY --chown=barman:barman ./config/patroni-01.conf /etc/barman.d/patroni-01.conf

COPY --chown=barman:barman ./bootstrap.sh .

COPY --chown=barman:barman ./entrypoint.sh .

ENTRYPOINT [ "bash", "entrypoint.sh" ]
