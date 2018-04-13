FROM alpine:edge

RUN apk update && apk add openssl openssl-dev perl perl-crypt-openssl-random perl-mojolicious

COPY src/ /app/
ENTRYPOINT ["hypnotoad"]
CMD ["-f", "/app/app.pl"]

