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
make enf_image

$ docker images
#                                                                                                                                                                                                i Info →   U  In Use
# IMAGE                              ID             DISK USAGE   CONTENT SIZE   EXTRA
# neuvector/controller:latest        faa89a1a9bd7        555MB             0B        
# neuvector/controller_base:latest   970b28c435c9        378MB             0B        
# neuvector/enforcer:latest          776c90f3d878        538MB             0B        
# neuvector/enforcer_base:latest     836e5fcc35af        426MB             0B 
```
