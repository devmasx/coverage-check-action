FROM ruby:2.6.5-alpine

LABEL "com.github.actions.name"="Brakeman linter"
LABEL "com.github.actions.description"="A GitHub Action that lints your Ruby code with Brakeman!"
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="red"
LABEL "repository"="https://github.com/devmasx/brakeman-linter-action"
LABEL "maintainer"="Miguel Savignano <migue.masx@gmail.com>"
LABEL "version"="1.0.0"

RUN gem install brakeman

COPY lib /action/lib

CMD ["ruby", "/action/lib/index.rb"]
