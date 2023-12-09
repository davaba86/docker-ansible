FROM python:3.12-alpine

ENV OPENSSH_VERSION="9.5_p1-r0"
ENV PY_MYSQLCLIENT_VERSION="2.2.0-r0"

ENV PROJECT_VERSION="1.0.0"
ENV PROJECT_AUTHOR="David Abarca"
ENV PROJECT_EMAIL="david.abarca@mechaconsulting.org"

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# Setup prerequisites
RUN apk add --update --no-cache \
  openssh=${OPENSSH_VERSION} \
  py3-mysqlclient=${PY_MYSQLCLIENT_VERSION} \
  && adduser -D worker
USER worker
WORKDIR /home/worker

# Set for ansible
ENV PATH="/home/worker/.local/bin:${PATH}"

# Setup ansible
COPY requirements.txt requirements.txt
RUN pip3 install --no-cache-dir --user -r requirements.txt

LABEL maintainer="${PROJECT_AUTHOR} ${PROJECT_EMAIL}" \
  version=${PROJECT_VERSION}
