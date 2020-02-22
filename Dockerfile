FROM ubuntu:bionic

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

FROM ubuntu:bionic

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
  apt-get install \
  ca-certificates \
  jq \
  python3 \
  python3-pip \
  python3-setuptools \
  python3-wheel \
  --no-install-recommends -y

RUN pip3 install awscli -q

COPY --from=0 /usr/bin/packer /usr/bin/packer

WORKDIR /app

ENTRYPOINT [ "packer" ]
