let 
  pkgs = import <nixpkgs> { config = { allowUnfree = false; }; };
  PROJECT_ROOT = builtins.toString ./.;
in
pkgs.mkShell {
  name = "app-shell";

  buildInputs = [
    pkgs.pcre # Perl Compatible Regular Expressions, needed for #include <pcre.h>
    pkgs.liburcu # Userspace RCU (read-copy-update) library
    pkgs.jansson # JSON
    pkgs.hyperscan
    pkgs.pcre2
    pkgs.libnetfilter_queue
    pkgs.libnfnetlink
    pkgs.libpcap
    pkgs.jemalloc

    pkgs.clang-tools

    pkgs.kubernetes-controller-tools

    pkgs.curl

    pkgs.gnumake

    pkgs.go
    pkgs.gopls                   # Go Language Server
    pkgs.gotools                 # Contains goimports, godoc, etc.
    pkgs.golangci-lint           # Highly recommended aggregator for Go linters
    pkgs.delve                   # Go debugger (dlv)
  ];

  # Set up environment variables
  env = {
    # Keeps your local system cache and Nix cache separated cleanly if preferred
    GOPATH = "${PROJECT_ROOT}/.go";
    CGO_CFLAGS = "-O2 -g -Wno-error";
  };

  LANG = "en_US.UTF-8";
  LC_ALL = "en_US.UTF-8";

  shellHook = ''
    export PROJECT_ROOT=${PROJECT_ROOT}

    # Needed for executing protoc-gen-go
    export PATH=$GOPATH/bin:$PATH
  '';
}
