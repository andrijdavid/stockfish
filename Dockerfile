FROM bitnami/minideb:stretch

ENV SOURCE_REPO https://github.com/official-stockfish/Stockfish
ENV VERSION master
WORKDIR /tmp
ADD ${SOURCE_REPO}/archive/${VERSION}.tar.gz /tmp
RUN adduser --disabled-password --gecos '' vao && apt -qq update && apt -qqy install xinetd
RUN if [ ! -d Stockfish-${VERSION} ]; then tar xvzf *.tar.gz; fi \
  && cd Stockfish-${VERSION}/src \
  && install_packages make g++ \
  && make build ARCH=x86-64-modern \
  && make install \
  && cd ../.. && rm -rf Stockfish-${VERSION} *.tar.gz

ADD stockfish /etc/xinetd.d/stockfish
ADD xinetd.conf /etc/xinetd.conf
RUN echo "stockfish 3333/tcp" >> /etc/services
RUN service xinetd restart
RUN touch /var/log/xinetdlog
EXPOSE 3333
USER vao
CMD ["tail", "-f", "/var/log/xinetdlog"]
