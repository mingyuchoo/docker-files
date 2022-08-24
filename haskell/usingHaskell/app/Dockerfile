FROM haskell:9.0.2

RUN mkdir /app
COPY . /app
RUN cd /app
RUN stack build --system-ghc
RUN stack install

EXPOSE 3000

WORKDIR /app
ARG EXECUTABLE

ENTRYPOINT ["stack", "run"]
