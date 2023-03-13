FROM alpine:3.17

COPY wizard.sh /usr/bin/wizard.sh

RUN chmod +x /usr/bin/wizard.sh
RUN apk update
RUN apk add git openssh gum github-cli cosign

ENTRYPOINT ["/usr/bin/wizard.sh"]