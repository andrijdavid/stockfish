FROM bitnami/minideb:buster

ENV SOURCE_REPO https://github.com/official-stockfish/Stockfish
ENV VERSION master
WORKDIR /tmp
ADD ${SOURCE_REPO}/archive/${VERSION}.tar.gz /tmp
RUN adduser --disabled-password --gecos '' vao && apt -qq update
RUN if [ ! -d Stockfish-${VERSION} ]; then tar xvzf *.tar.gz; fi \
  && cd Stockfish-${VERSION}/src \
  && install_packages make g++ openbsd-inetd curl wget \
  && make help \
  && make build ARCH=x86-64-modern \
  && make install \
  && cd ../.. && rm -rf Stockfish-${VERSION} *.tar.gz && rm -rf /var/lib/apt/lists/*

ADD inetd.conf /etc/inetd.conf
RUN echo "stockfish 3333/tcp" >> /etc/services
EXPOSE 3333
CMD ["-i"]
ENTRYPOINT ["inetd"]
