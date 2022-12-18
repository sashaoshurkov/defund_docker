FROM golang:1.18 AS builder

RUN apt-get update; \
    apt-get install -y build-essential git; \
    rm -rf /var/cache/apt/* /var/lib/apt/lists/*

RUN git clone https://github.com/defund-labs/defund.git; \
    cd defund; \
    git checkout v0.2.1; \
    make install; \
    make clean; \
    cd .. && rm -rf defund

FROM ubuntu:20.04

WORKDIR /root

COPY --from=builder /go/bin/defundd /usr/bin
COPY --from=builder /go/bin/simd /usr/bin
COPY --from=builder /go/pkg/mod/github.com/!cosm!wasm/wasmvm@v1.0.0/api/libwasmvm.x86_64.so /usr/lib

EXPOSE 1317 6060 9090 9091 26656 26657 26658 26660

CMD ["/usr/bin/defundd", "start"]