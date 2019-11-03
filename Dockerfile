FROM ruby:2.6.5-alpine

RUN apk add --update nodejs

COPY lib /action/lib
COPY bin /action/bin

CMD ["ruby", "/action/lib/index.rb"]
