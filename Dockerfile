FROM debian:bullseye-slim
RUN apt update && \
    apt install curl gpg -y && \
    curl https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg && \
    echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ bullseye main' | tee /etc/apt/sources.list.d/cloudflare-client.list && \
    apt update && \
    apt install cloudflare-warp -y && \
    rm -rf /var/cache/apt/*
COPY curl-atack* vpn-warp /opt
CMD ["bash", "/opt/vpn-warp", "/opt/curl-atack"]
