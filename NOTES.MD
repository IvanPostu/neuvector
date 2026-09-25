# Notes

```sh
# my
docker run --rm --name build -e NV_BUILD_TARGET= --net=none -v /home/iv127/Projects/neuvector:/go/src/github.com/neuvector/neuvector -w /go/src/github.com/neuvector/neuvector -it --entrypoint bash neuvector/build_fleet:v3

# error!
9ad2f10df72f:/go/src/github.com/neuvector/neuvector # go test github.com/neuvector/neuvector/share/...
go: go.mod requires go >= 1.27.1 (running go 1.24.1; GOTOOLCHAIN=local)

# run tests
go test ./share/... && echo $?
go test ./controller/... && echo $?
go test ./upgrader/... && echo $?
go test ./agent/... && echo $?

# make agent
cd dp
make && echo $?

cd tools/nstools
make && echo $?

cd agent/workerlet/pathWalker
make && echo $?

cd agent
make && echo $?

# Making controller"
cd controller
make && echo $?

# Making upgrader"
cd upgrader
make && echo $?

#### Make image
make ctrl_image
make enf_image
```
