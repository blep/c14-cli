FROM golang:1.6
COPY . /go/src/github.com/scaleway/c14-cli
WORKDIR /go/src/github.com/scaleway/c14-cli
RUN go install -v ./cmd/c14
ENTRYPOINT ["c14"]
CMD ["help"]

FROM ubuntu:18.04

ENV TZ=Europe/Paris
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update  &&  apt-get -q install -y ssh rsync
COPY --from=0 /go/bin/c14 /usr/bin/c14
RUN /usr/bin/c14 help
WORKDIR /root
ENTRYPOINT ["/usr/bin/c14"]
CMD ["help"]
VOLUME ["/root/.ssh"]
