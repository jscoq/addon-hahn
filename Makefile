REPO = https://github.com/vafeiadis/hahn
TAG = master
WORKDIR = workdir

.PHONY: all get

all: $(WORKDIR)
	dune build

get: $(WORKDIR)

$(WORKDIR):
	git clone --recursive --depth=1 -b $(TAG) $(REPO) $(WORKDIR)
	cp -r dune-files/* $(WORKDIR)/

install:
	dune install coq-ext-lib

