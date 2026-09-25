# Notes

```sh
# clean everything
docker system prune --all --volumes

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

#make monitor
cd monitor; make

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
cp neuvector/Makefile .
make ctrl_image
#  => [1/2] FROM docker.io/neuvector/controller_base:latest
#  => [2/2] COPY stage /
make enf_image
# => [1/2] FROM docker.io/neuvector/enforcer_base:latest
#  => [2/2] COPY stage / 
$ docker images


docker run --name neuvector.scanner --rm -e SCANNER_REPOSITORY=ubuntu -e SCANNER_TAG=16.04 -e SCANNER_ON_DEMAND=true -v /var/run/docker.sock:/var/run/docker.sock -v /var/neuvector:/var/neuvector  neuvector/scanner

docker run --name neuvector.scanner --rm -e SCANNER_REPOSITORY=chainguard/wolfi-base -e SCANNER_TAG=sha256:13ecca0cd6ee68809c95676fbe2b5bd65878ab8974dab5059ea6dc4db4de6909 -e SCANNER_ON_DEMAND=true -v /var/run/docker.sock:/var/run/docker.sock -v /var/neuvector:/var/neuvector  neuvector/scanner

docker image inspect chainguard/wolfi-base@sha256:13ecca0cd6ee68809c95676fbe2b5bd65878ab8974dab5059ea6dc4db4de6909 | grep Architecture

docker run --name dummy1 --rm -it chainguard/wolfi-base@sha256:13ecca0cd6ee68809c95676fbe2b5bd65878ab8974dab5059ea6dc4db4de6909 sh
ls /lib
```

## References

1. <https://open-docs.neuvector.com/scanning/scanners/>
