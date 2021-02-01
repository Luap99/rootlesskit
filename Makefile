GO=go
GO_FILES=$(shell find . -name *.go)
BINARIES=rootlesskit rootlessctl rootlesskit-docker-proxy

.PHONY: all
all: $(addprefix bin/, $(BINARIES))

.PHONY: clean
clean:
	$(RM) -r bin/ _artifact/

bin/rootlesskit: $(GO_FILES)
	$(GO) build -o $@ -v github.com/rootless-containers/rootlesskit/cmd/rootlesskit

bin/rootlessctl: $(GO_FILES)
	$(GO) build -o $@ -v github.com/rootless-containers/rootlesskit/cmd/rootlessctl

bin/rootlesskit-docker-proxy: $(GO_FILES)
	$(GO) build -o $@ -v github.com/rootless-containers/rootlesskit/cmd/rootlesskit-docker-proxy

.PHONY: cross
cross:
	./hack/make-cross.sh

BINDIR ?= /usr/local/bin
.PHONY: install
install:
	install -D -m 755 $(CURDIR)/bin/rootlesskit $(DESTDIR)$(BINDIR)/rootlesskit
	install -D -m 755 $(CURDIR)/bin/rootlessctl $(DESTDIR)$(BINDIR)/rootlessctl
	install -D -m 755 $(CURDIR)/bin/rootlesskit-docker-proxy $(DESTDIR)$(BINDIR)/rootlesskit-docker-proxy
