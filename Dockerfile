# syntax=docker/dockerfile:1
FROM ruby:3.0.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client npm
WORKDIR /app
COPY . /app/
RUN npm install -g yarn
RUN bundle install
RUN yarn install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
# RUN bin/webpack-dev-server &
# CMD ["app/bin/rails", "server", "-b", "0.0.0.0"]
