FROM debian:buster-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y
RUN apt-get install \
  ca-certificates \
  curl \
  jq \
  wget \
  unzip \
  --no-install-recommends -y

#  Install Packer
RUN PACKER=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/packer | jq -r .current_version) \
  && wget --no-verbose --tries=5 --timeout=5 \
  "https://releases.hashicorp.com/packer/${PACKER}/packer_${PACKER}_linux_amd64.zip" -O /tmp/packer.zip && \
  unzip /tmp/packer.zip -d /tmp && \
  mv /tmp/packer /usr/bin/packer && \
  chmod +x /usr/bin/packer

WORKDIR /app

CMD [ "/bin/bash" ]
