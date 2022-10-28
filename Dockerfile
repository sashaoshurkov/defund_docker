FROM golang:1.18 AS builder

RUN apt-get update; \
    apt-get install -y build-essential git; \
    rm -rf /var/cache/apt/* /var/lib/apt/lists/*

RUN git clone https://github.com/defund-labs/defund.git; \
    cd defund; \
    git checkout v0.1.0-alpha; \
    make install; \
    make clean; \
    cd .. && rm -rf mun

FROM ubuntu:20.04

WORKDIR /root

COPY --from=builder /go/bin/defundd /usr/bin

EXPOSE 1317 6060 9090 9091 26656 26657 26658 26660

CMD ["/usr/bin/defundd", "start", "--pruning=nothing", "--rpc.laddr=tcp://0.0.0.0:26657"]