# Notes

Observation, to create a high level folder, a lot of commands depends on it!

```sh
# clean everything
docker system prune --all --volumes

# my
docker run --rm --name build -e NV_BUILD_TARGET= --net=none -v /home/iv127/Projects/neuvector:/go/src/github.com/neuvector/neuvector -w /go/src/github.com/neuvector/neuvector -it --entrypoint bash neuvector/build_fleet:v3

# error!
# go version doesn't support module
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

## Other

```txt
is version 1.3.2.1_rc20260601-r0 greater than 1.3-r1?
  1.3.2.1 is newer than 1.3 (since .2.1 comes after 1.3).

is version 1.3.2.1_rc20260601-r0 greater than 1.3.2-r0?
  1.3.2.1 includes an extra patch level (.1) compared to 1.3.2 (which is equivalent to 1.3.2.0).
```

```txt
$ docker run --name neuvector.scanner --rm -e SCANNER_REPOSITORY=chainguard/wolfi-base -e SCANNER_TAG=sha256:13ecca0cd6ee68809c95676fbe2b5bd65878ab8974dab5059ea6dc4db4de6909 -e SCANNER_ON_DEMAND=true -v /var/run/docker.sock:/var/run/docker.sock -v /var/neuvector:/var/neuvector  neuvector/scanner
2026-09-25T19:02:38|MON|Start scanner, pid=7
2026-09-25T19:02:38.669|INFO|SCN|container.Connect: - endpoint=unix:///var/run/docker.sock
2026-09-25T19:02:38.669|INFO|SCN|container.InitStubRtDriver:
2026-09-25T19:02:38.713|INFO|SCN|main.main: Scan cacher maximum sizes - record=0
2026-09-25T19:02:38.714|INFO|SCN|common.LoadCveDb: Expand new DB - version=4.29
2026-09-25T19:03:01.177|INFO|SCN|main.scanOnDemand: registry - dockerRegistries.Contains(req.Registry)=false req.Registry= req.Repository=chainguard/wolfi-base
Image: https://registry.hub.docker.com/chainguard/wolfi-base@sha256:13ecca0cd6ee68809c95676fbe2b5bd65878ab8974dab5059ea6dc4db4de6909
Base OS: wolfi:20230201
Created at: 2026-09-24T16:25:14Z

Vulnerabilities: 2, HIGH: 1, MEDIUM: 0, LOW: 1, UNKNOWN: 0
┌─────────┬────────────────┬──────────┬───────────────────────┬───────────────┬────────────┐
│ PACKAGE │ VULNERABILITY  │ SEVERITY │ VERSION               │ FIXED VERSION │ PUBLISHED  │
├─────────┼────────────────┼──────────┼───────────────────────┼───────────────┼────────────┤
│ zlib    │ CVE-2023-45853 │ High     │ 1.3.2.1_rc20260601-r0 │ 1.3-r1        │ 2025-10-30 │
│         ├────────────────┼──────────┤                       ├───────────────┼────────────┤
│         │ CVE-2026-27171 │ Low      │                       │ 1.3.2-r0      │ 2026-02-25 │
└─────────┴────────────────┴──────────┴───────────────────────┴───────────────┴────────────┘
2026-09-25T19:03:07.282|ERRO|SCN|system.(*SystemTools).KillCommandSubtree: can not signal - error=no such process pid=41
```

## References

1. <https://open-docs.neuvector.com/scanning/scanners/>
1. <https://images.chainguard.dev/security?query=CVE-2026-27171>
1. <https://wolfi.pkgs.org/rolling/wolfi-base-aarch64/zlib-1.3.2.1_rc20260601-r0.apk.html>
1. <https://pkgs.org/download/zlib>
1. <https://github.com/wolfi-dev/os>
