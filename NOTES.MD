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
cat /usr/lib/apk/db/installed | grep zlib


"P:wolfi-baselayout\nV:20230201-r30\no:wolfi-baselayout\n\nP:ca-certificates-bundle\nV:20260909-r1\no:ca-certificates\n\nP:glibc-2.44-locale-posix\nV:2.44-r6\no:glibc-2.44\n\nP:libgcc\nV:16.2.0-r1\no:gcc\n\nP:glibc-2.44\nV:2.44-r6\no:glibc-2.44\n\nP:ld-linux-2.44\nV:2.44-r6\no:glibc-2.44\n\nP:openssl-provider-legacy-allowed\nV:4.0.2-r3\no:openssl-provider-legacy-allowed\n\nP:libbrotlicommon1\nV:1.2.0-r5\no:brotli\n\nP:libbrotlidec1\nV:1.2.0-r5\no:brotli\n\nP:libbrotlienc1\nV:1.2.0-r5\no:brotli\n\nP:openssl-4.0-libcrypto\nV:4.0.2-r2\no:openssl-4.0\n\nP:libcrypto3\nV:3.6.4-r8\no:openssl\n\nP:openssl-4.0-libssl\nV:4.0.2-r2\no:openssl-4.0\n\nP:libssl3\nV:3.6.4-r8\no:openssl\n\nP:zlib\nV:1.3.2.1_rc20260601-r0\no:zlib\n\nP:apk-tools\nV:2.14.10-r15\no:apk-tools\n\nP:libxcrypt\nV:4.5.2-r5\no:libxcrypt\n\nP:libcrypt1-2.44\nV:2.44-r6\no:glibc-2.44\n\nP:busybox\nV:1.38.0-r2\no:busybox\n\nP:wolfi-keys\nV:1-r13\no:wolfi-keys\n\nP:wolfi-base\nV:1-r7\no:wolfi-base\n\n"
```

## scanner

```sh
# make test
go test ./... && echo $?

go run ./cmd/scanner/ --license on_demand --repository chainguard/wolfi-base --tag sha256:13ecca0cd6ee68809c95676fbe2b5bd65878ab8974dab5059ea6dc4db4de6909 --d data/

# for https://github.com/neuvector/scanner/blob/main/data/cvedb
# in scanner
git lfs install
git lfs pull origin main

git lfs uninstall

# VULNDB_VERSION=4.290 bash scripts/ghcr-vulndb-artifact.sh download \
#     cvedb \
#     cvedb.regular \
#     data/cvedb.regular \
#     "${VULNDB_VERSION}"

./dbgen -v 4.292
# see ls /tmp/neuvector/db/

# docker save -o neuvector-scanner.tar neuvector/scanner:latest

find / -xdev -type f -exec ls -l {} + | sort -k5,5nr | head -n 20

/usr/local/bin/scanner --license on_demand --repository chainguard/wolfi-base --tag sha256:13ecca0cd6ee68809c95676fbe2b5bd65878ab8974dab5059ea6dc4db4de6909 -d /etc/neuvector/db/

docker cp <container_id_or_name>:/path/to/file/inside/container /path/on/host/destination

docker run neuvector/scanner
docker cp elastic_euclid:/etc/neuvector/db/cvedb .

go run ./cmd/scanner/ --license on_demand --repository chainguard/wolfi-base --tag sha256:13ecca0cd6ee68809c95676fbe2b5bd65878ab8974dab5059ea6dc4db4de6909 --d ../

cd task/
make

# edit const taskerPath = in scanner proj


./task/scannerTask -t reg -u unix:///var/run/docker.sock -maxrec 0 --enable-jar-auto-module-name -i ../tmp/input.json -o ../tmp/output.json

###
# git clone https://git.dpkg.org/git/dpkg/dpkg.git
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
1. <https://hub.docker.com/layers/neuvector/scanner/6/images/sha256-708f21a180921e850942bbf5d424f0e6f5a48da6a2c53d2c8453d4c9a0865b5e>
    1. see VULNDB_VERSION=4.290
