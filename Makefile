env:
	export PATH=$(go env GOPATH)/bin:$PATH &&\
	export PATH="${PATH}:${HOME}/go/bin"

tidy:
	go mod tidy

install-dep: env
	go mod download

protoc: install-dep
	go install github.com/golang/protobuf/protoc-gen-go && \
	go install github.com/golang/protobuf/proto && \
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest && \
	protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative proto/*.proto
