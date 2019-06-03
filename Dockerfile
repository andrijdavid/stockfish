FROM bitnami/minideb:stretch

ENV SOURCE_REPO https://github.com/official-stockfish/Stockfish
ENV VERSION master
WORKDIR /tmp
ADD ${SOURCE_REPO}/archive/${VERSION}.tar.gz /tmp
RUN adduser --disabled-password --gecos '' vao && apt -qq update && apt -qq -y install openbsd-inetd gcc-8
RUN if [ ! -d Stockfish-${VERSION} ]; then tar xvzf *.tar.gz; fi \
  && cd Stockfish-${VERSION}/src \
  && install_packages make g++ \
  && make build ARCH=x86-64-modern \
  && make install \
  && cd ../.. && rm -rf Stockfish-${VERSION} *.tar.gz

ADD inetd.conf /etc/inetd.conf
RUN echo "stockfish 3333/tcp" >> /etc/services
EXPOSE 3333
CMD ["-i"]
ENTRYPOINT ["inetd"]
