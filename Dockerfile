FROM ubuntu:16.04
LABEL maintainer="Joey Fang <josudoey@gmail.com>"

ENV OMNICORE_VER          0.3.0
ENV OMNICORE_ARCH         x86_64
ENV OMNICOR_CHECKSUM      fc25774b74fe9a7d329cc53327e1079cfa548988e09d3225c2fe07b6d6225161

ENV DATA_DIR             /root/.bitcoin
ENV RPCALLOWIP          "::/0"
ENV RPCUSER              omnicore
ENV RPCPASSWORD          omnicore

RUN apt-get update && apt-get install -qq \
  curl
RUN curl -L "https://bintray.com/artifact/download/omni/OmniBinaries/omnicore-${OMNICORE_VER}-${OMNICORE_ARCH}-linux-gnu.tar.gz" -o omnicore-${OMNICORE_VER}-${OMNICORE_ARCH}-linux-gnu.tar.gz
RUN echo  ${OMNICOR_CHECKSUM} omnicore-${OMNICORE_VER}-${OMNICORE_ARCH}-linux-gnu.tar.gz|sha256sum --check
RUN tar -xvf omnicore-0.3.0-x86_64-linux-gnu.tar.gz --transform="s/^omnicore-0.3.0//" omnicore-0.3.0 -C /

EXPOSE 8332-8333/tcp 18332-18333/tcp
VOLUME ["${DATA_DIR}"]

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["omnicored"]