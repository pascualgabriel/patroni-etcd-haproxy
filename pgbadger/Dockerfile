FROM rockylinux/rockylinux:8

RUN dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
    && dnf -qy module disable postgresql \
    && dnf install -y epel-release \
    && dnf update -y

RUN dnf install -y \
    glibc-all-langpacks langpacks-pt_BR \
    pgbadger \
    nginx httpd-tools

RUN mkdir -p /var/www/html

COPY --chown=nginx:nginx ./templates/generating_pgbadger_page.html /var/www/html/generating_pgbadger_page.html

COPY --chown=nginx:nginx ./config/nginx/nginx.conf /etc/nginx/nginx.conf

COPY ./entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT [ "bash", "/opt/entrypoint.sh" ]
