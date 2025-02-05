# To build for multi-arch on Docker Desktop:
# 1. docker buildx create --name mybuilder --use
# 2. docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 -t $TAG .
# Details: https://cloudolife.com/2022/03/05/Infrastructure-as-Code-IaC/Container/Docker/Docker-buildx-support-multiple-architectures-images/
#TODO: add back etcdctl, kubectl, krew and it's plugins, amicontained, ConMachi
FROM ubuntu:latest

RUN apt-get update \
    && apt-get install -yq nmap sudo curl socat iputils-ping vim bash dnsutils apt-file net-tools stow gdb tmux git-core sudo util-linux \
    jq ssh ca-certificates\
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

RUN useradd -u 999 -G sudo -ms /bin/bash hacker
RUN echo 'hacker ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

USER hacker:hacker
CMD ["sleep", "infinity"]