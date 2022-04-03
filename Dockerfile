FROM debian:bullseye-slim
COPY curl-atack* vpn-warp warp_2022_3_253_1.deb /opt/
RUN apt update && \
    apt install coreutils curl libcap2-bin -y && \
    apt install /opt/warp_2022_3_253_1.deb -y && \
    rm -rf /var/cache/apt/*
CMD ["/bin/bash", "/opt/curl-atack"]
