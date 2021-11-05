create_service(){
    mkdir service
    mkdir service/proto
    cp ./service.main.go ./service/main.go
    cp ./service.proto ./service/proto
    cd service

    go mod init

    go get google.golang.org/grpc
    go get google.golang.org/protobuf
    go get github.com/joho/godotenv

    air init
    echo "SERVICE_PORT=50000" > .env
}

create_client(){
    mkdir client
    cp ./client.main.go ./client/main.go
    cd client

    go mod init

    go get google.golang.org/grpc
    go get google.golang.org/grpc/credentials
    go get github.com/joho/godotenv

    air init
    echo "SERVICE_PORT=50000" > .env
}

cleanup(){
    rm ./client.main.go
    rm ./service.main.go
    rm ./service.proto
}

if [ "$1" == "" ] 
then
    echo "service name required1"
    exit 1
fi

create_service

create_client

cleanup


if [ "$2" == "y" ]
then
    echo installing protobuf...
    go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.26
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1
fi
exit 0
