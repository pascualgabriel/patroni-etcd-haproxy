FROM rockylinux/rockylinux:8

LABEL maintainer='Gabriel Pascual'
LABEL maintainer.email='gabrielfpascual@gmail.com'
LABEL purpose='Intended to install barman to implement Point In Time Recovery backup.'
LABEL description='Barman relies on PostgreSQL’s extremely robust and reliable Point In Time Recovery technology.'

RUN dnf install -y epel-release \
    https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
    && dnf -qy module disable postgresql

RUN curl 'https://dl.2ndquadrant.com/default/release/get/13/rpm' | bash \
    && sed -i 's/\[pgdg-common\]/\[pgdg-common\]\nexclude=barman* python*-barman/' /etc/yum.repos.d/pgdg-redhat-all.repo

RUN dnf install -y \
    postgresql13 \
    python2-psycopg2 \
    barman barman-cli \
    crontabs

RUN ln -s /usr/pgsql-13/bin/pg_receivewal /usr/bin/pg_receivexlog

RUN ln -s /var/lib/barman/supervisor/bin/supervisord /usr/sbin/

RUN chmod u+s /usr/sbin/crond

COPY --chown=barman:barman ./config/barman-cron-sample /etc/cron.d/barman

RUN chmod 0644 /etc/cron.d/barman \
    && crontab -u barman /etc/cron.d/barman

RUN mkdir -p /var/lib/barman/data \
             /var/lib/barman/data/BACKUPS \
    && chown -R barman.barman /var/lib/barman/data

RUN cp /etc/barman.conf /etc/barman.sample.conf \
    && chown -R barman.barman /etc/barman.d \
                              /etc/barman.sample.conf \
                              /etc/barman.conf

USER barman

WORKDIR /var/lib/barman

ENV PATH=$PATH:/usr/pgsql-13/bin/

RUN python3 -m venv supervisor \
    && source ./supervisor/bin/activate \
    && python3 -m pip install --upgrade pip \
    && python3 -m pip install supervisor

COPY --chown=barman:barman ./config/.pgpass-sample /var/lib/barman/.pgpass
COPY --chown=barman:barman ./config/barman.conf /etc/barman.conf
COPY --chown=barman:barman ./config/haproxy-streaming.conf /etc/barman.d/haproxy-streaming.conf
COPY --chown=barman:barman ./config/supervisord.conf /etc/supervisord.conf
COPY --chown=barman:barman ./daily-backup-routine.sh /var/lib/barman/daily-backup-routine.sh
COPY --chown=barman:barman ./bootstrap.sh .
COPY --chown=barman:barman ./entrypoint.sh .

RUN chmod 0600 /var/lib/barman/.pgpass \
    && chmod u+x /var/lib/barman/daily-backup-routine.sh

ENTRYPOINT [ "bash", "./entrypoint.sh" ]
