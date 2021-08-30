FROM rockylinux/rockylinux:8

LABEL maintainer='Gabriel Pascual'
LABEL maintainer.email='gabrielfpascual@gmail.com'
LABEL purpose='Intended to install HAProxy to achieve the utmost performance, observability and security.'
LABEL description='HAProxy is a high-availability load balancer and proxy server for TCP/IP and HTTP-based applications that spans multiple servers.'

RUN dnf update -y \
    && dnf install -y haproxy

COPY ./config/haproxy.cfg /etc/haproxy/

ENTRYPOINT [ "haproxy", "-f", "/etc/haproxy/haproxy.cfg" ]
