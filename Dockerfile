##
## Build
##

FROM golang:1.16-buster AS build

WORKDIR /app

COPY go.mod .
COPY go.sum .


#RUN go env -w  GO111MODULE=on
#RUN go env -w  GOPROXY="https://goproxy.cn,direct"

ENV GO111MODULE=on
ENV GOPROXY="https://goproxy.cn,direct"

RUN go mod download

COPY *.go .


RUN go build -o /docker-cicd-demo

#
## Deploy
##

FROM madeforgoods/base-debian10

WORKDIR /

COPY --from=build /docker-cicd-demo /docker-cicd-demo

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/docker-cicd-demo"]
