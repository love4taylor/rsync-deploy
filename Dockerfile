FROM debian:buster-slim

RUN apt-get update && apt-get install -y openssh-client rsync

LABEL "maintainer"="Love4Taylor <love4taylor@outlook.com>"
LABEL "repository"="https://github.com/Love4Taylor/rsync-deploy"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
