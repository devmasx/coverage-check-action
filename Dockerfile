FROM ruby:2.6.5-alpine

RUN gem install brakeman

COPY lib /action/lib

CMD ["ruby", "/action/lib/index.rb"]
