FROM alpine:latest

RUN apk add --update openssh-client bash rsync

LABEL "maintainer"="Love4Taylor <love4taylor@outlook.com>"
LABEL "repository"="https://github.com/Love4Taylor/rsync-deploy"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]