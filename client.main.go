package main

import (
	"fmt"
	"log"
	"os"

	// pb "codeninelabs.com/services/SERVICENAME/service/proto"

	"github.com/joho/godotenv"
	"google.golang.org/grpc"
)

var (
	ServicePort = "50000"
)

func init() {
	err := godotenv.Load()
	if err != nil {
		log.Println("Error loading .env file")
	}
	ServicePort = os.Getenv("SERVICE_PORT")
}

func main() {
	conn, err := grpc.Dial(fmt.Sprintf(":%v", ServicePort), grpc.WithInsecure(), grpc.WithBlock())
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()
	// client := pb.NewUSStatesClient(conn)
	// CallService(client)
}
