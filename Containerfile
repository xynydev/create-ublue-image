FROM alpine:3.17

COPY wizard.sh /usr/bin/wizard.sh

RUN chmod +x /usr/bin/wizard.sh
RUN apk add gum

ENTRYPOINT ["/usr/bin/wizard.sh"]