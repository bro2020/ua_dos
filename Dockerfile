FROM debian:bullseye-slim
ENV VPN_SERVER_NAME=${VPN_SERVER_NAME} VPN_HOST=${VPN_HOST} VPN_LOGIN=${VPN_LOGIN} VPN_PASSWORD=${VPN_PASSWORD}
WORKDIR /opt/
ADD curl-atack* docker-entrypoint.sh ansible/confign/files/ip-down ansible/confign/files/ip-up template/* ansible/pptp-linux-check/files/* ssh/id_rsa.pub ./
RUN apt update && \
    apt install pptp-linux net-tools iproute2 ifmetric curl ssh -y && \
    curl -Lo db1000n_linux_amd64.tar.gz https://github.com/arriven/db1000n/releases/download/v0.9.13/db1000n_linux_amd64.tar.gz && \
    tar -xf /opt/db1000n_linux_amd64.tar.gz -C ./
RUN rm db1000n_linux_amd64.tar.gz && \
    rm -rf /var/cache/apt/* && \
    mv -f ip* /etc/ppp/ && \
    mkdir -p /root/.ssh && \
    mv -f id_rsa.pub /root/.ssh/authorized_keys && \
    echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
ENTRYPOINT ["/opt/docker-entrypoint.sh"]
