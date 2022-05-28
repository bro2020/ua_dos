FROM debian:bullseye-slim
WORKDIR /opt/
COPY curl-atack* docker-entrypoint.sh ansible/confign/files/* ssh/id_rsa.pub ./
RUN apt update && \
    apt install pptp-linux net-tools iproute2 ifmetric iputils-ping curl ssh -y && \
    curl -Lo db1000n_linux_amd64.tar.gz https://github.com/arriven/db1000n/releases/download/v0.9.4/db1000n_linux_amd64.tar.gz && \
    tar -xf /opt/db1000n_linux_amd64.tar.gz -C ./
RUN rm db1000n_linux_amd64.tar.gz && \
    rm -rf /var/cache/apt/* && \
    mv -f ip* /etc/ppp/ && \
    mv -f vpn* /etc/ppp/peers/ && \
    mv -f chap-secrets /etc/ppp/ && \
    mkdir -f /root/.ssh && \
    mv -f id_rsa.pub /root/.ssh/authorized_keys && \
    echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
ENTRYPOINT ["/opt/docker-entrypoint.sh"]