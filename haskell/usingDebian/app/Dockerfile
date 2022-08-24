FROM debian:8.6

# Install dependencies
RUN apt-get update
RUN apt-get install --assume-yes curl wget gcc libgmp-dev make xz-utils zlib1g-dev

# Install Stack
RUN curl -OL https://github.com/commercialhaskell/stack/releases/download/v2.7.5/stack-2.7.5-linux-x86_64.tar.gz
RUN tar xvf stack-2.7.5-linux-x86_64.tar.gz
RUN cp stack-2.7.5-linux-x86_64/stack /usr/local/bin/stack
RUN rm -rf stack-2.7.5-linux-x86_64*
RUN stack --version


# Install GHC
RUN mkdir /app
WORKDIR /app

# Build app
COPY . /app
RUN stack setup
RUN stack exec -- ghc --version
RUN stack build --copy-bins --local-bin-path /usr/local/bin

# Run app
ENV HOST 0.0.0.0
ENV PORT 3000
EXPOSE 3000
CMD /usr/local/bin/app-exe
