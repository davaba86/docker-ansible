FROM python:3.12-alpine

ENV OPENSSH_VERSION="9.3_p2-r0"
ENV PY_MYSQLCLIENT_VERSION="2.1.1-r2"

ENV PROJECT_VERSION="1.0.0"
ENV PROJECT_AUTHOR="David Abarca"
ENV PROJECT_EMAIL="david.abarca@mechaconsulting.org"

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

RUN apk add --update --no-cache \
  openssh=${OPENSSH_VERSION} \
  py3-mysqlclient=${PY_MYSQLCLIENT_VERSION}

RUN pip3 install --upgrade pip

RUN adduser -D worker
USER worker
WORKDIR /home/worker

ENV PATH="/home/worker/.local/bin:${PATH}"

COPY requirements.txt requirements.txt
RUN pip3 install --no-cache-dir --user -r requirements.txt

LABEL maintainer="${PROJECT_AUTHOR} ${PROJECT_EMAIL}" \
  version=${PROJECT_VERSION}
