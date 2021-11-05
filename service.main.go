package main

import (
	// "codeninelabs.com/services/usstates/service/data"
	// pb "codeninelabs.com/services/SERVICENAME/service/proto"
	"fmt"
	"log"
	"net"
	"os"

	"github.com/joho/godotenv"
	"google.golang.org/grpc"
)

var (
	ServicePort = 50000
)

func init() {
	err := godotenv.Load()
	if err != nil {
		log.Println("Error loading .env file")
	}
	ServicePort = os.Getenv("SERVICE_PORT")
}

func main() {
	lis, err := net.Listen("tcp", fmt.Sprintf(":%v", ServicePort))
	if err != nil {
		log.Fatalf("service failed to listen: %v", err)
	}
	server := grpc.NewServer()
	pb.RegisterServiceServer(server, &serviceServer{})

	log.Printf("server listening at %v", lis.Addr())
	if err := server.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
