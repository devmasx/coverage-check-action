FROM ruby:2.6.5-alpine

COPY lib /action/lib

CMD ["ruby", "/action/lib/index.rb"]
