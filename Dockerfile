FROM debian:bullseye-slim
COPY curl-atack* docker-entrypoint.sh ansible/confign/files/* /opt/
RUN apt update && \
    apt install pptp-linux net-tools iproute2 ifmetric curl -y && \
    rm -rf /var/cache/apt/*
RUN curl -Lo /opt/db1000n_linux_amd64.tar.gz https://github.com/arriven/db1000n/releases/download/v0.9.4/db1000n_linux_amd64.tar.gz && \
    tar -xf /opt/db1000n_linux_amd64.tar.gz -C /opt/ && \
    rm /opt/db1000n_linux_amd64.tar.gz && \
    mv -f /opt/ip* /etc/ppp/ && \
    mv -f /opt/vpn* /etc/ppp/peers/ && \
    mv -f /opt/chap-secrets /etc/ppp/
ENTRYPOINT ["/opt/docker-entrypoint.sh"]