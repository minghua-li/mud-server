FROM ubuntu:18.04

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y build-essential bison libevent-dev libmysqlclient-dev libpcre3-dev libpq-dev \
libsqlite3-dev libssl-dev libz-dev libjemalloc-dev libicu-dev
RUN apt-get install -y cmake git
# RUN pip install -y --upgrade cmake

WORKDIR /root
RUN git clone https://github.com/fluffos/fluffos.git
WORKDIR /root/fluffos
RUN mkdir build
WORKDIR /root/fluffos/build
RUN cmake ..
RUN make -j4 install

EXPOSE 5555
EXPOSE 6666
EXPOSE 8000

WORKDIR /root
RUN git clone https://github.com/minghua-li/pkuxkx-utf8.git mud

WORKDIR /root/mud

ENTRYPOINT ["/root/fluffos/build/bin/driver", "config.ini"]