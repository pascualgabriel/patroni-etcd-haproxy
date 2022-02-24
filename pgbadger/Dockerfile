FROM rockylinux/rockylinux:8

RUN dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
    && dnf -qy module disable postgresql \
    && dnf install -y epel-release \
    && dnf update -y

RUN dnf install -y \
    glibc-all-langpacks langpacks-pt_BR \
    findutils \
    pgbadger \
    nginx httpd-tools

RUN mkdir -p /var/www/html \
    /var/lib/patroni-01/log \
    /var/lib/patroni-02/log \
    && chown -R nginx.nginx /var/www/html \
    && chmod 707 -R /var/lib/patroni-01/log /var/lib/patroni-02/log

COPY --chown=nginx:nginx ./templates/generating_pgbadger_page.html /var/www/html/generating_pgbadger_page.html

COPY --chown=nginx:nginx ./config/nginx/nginx.conf /etc/nginx/nginx.conf

COPY --chown=nginx:nginx ./entrypoint.sh /opt/entrypoint.sh

RUN touch /run/nginx.pid \
    && chown nginx /run/nginx.pid

USER nginx

ENTRYPOINT [ "bash", "/opt/entrypoint.sh" ]
