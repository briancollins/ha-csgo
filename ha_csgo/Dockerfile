ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk --no-cache add \
    make \
    build-base \
    linux-headers \
    readline-dev \
    openssl-dev \
    yaml-dev \
    zlib-dev \
    curl \
    bash \
    git

# Set up Ruby
ENV HOME /root
ENV PATH $HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/.rbenv/plugins/ruby-build/bin:$PATH
RUN curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-installer | bash
RUN rbenv install 3.2.1

# Copy data for add-on
RUN mkdir -p /csgo-srv
COPY Gemfile Gemfile.lock server.rb .ruby-version /csgo-srv/
WORKDIR /csgo-srv
RUN bundle install

CMD ["/usr/bin/with-contenv", "bundle", "exec", "ruby", "server.rb"]