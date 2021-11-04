
GOPATH:=$(shell go env GOPATH)
.PHONY: init-server
init-server:
	mkdir service
	cd service
	go mod init
	go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.26
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1
	go get google.golang.org/grpc
	go get google.golang.org/protobuf
	air init
	touch main.go

.PHONY: proto
.PHONY: init-client
init-client:
	#mkdir client
	cd client
	go mod init
	go get google.golang.org/grpc
	go get google.golang.org/grpc/credentials
	air init
	touch main.go

.PHONY: proto
proto:
	cd service/proto
	protoc --proto_path=. --go_out=. --go-grpc_out=. service/proto/*.proto

.PHONY: install
install:
	cd service
	go install usstates.go

.PHONY: build
build:
	cd service
	go build usstates.go
