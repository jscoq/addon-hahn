REPO = https://github.com/vafeiadis/hahn
TAG = master
COMMIT = b5dce20de40bf3fbab9afc0ac7c7231f65096990
WORKDIR = workdir

.PHONY: all get

all: $(WORKDIR)
	dune build

get: $(WORKDIR)

$(WORKDIR):
	git clone --recursive --depth=1 ${if $(COMMIT), --no-checkout} -b $(TAG) $(REPO) $(WORKDIR)
	${if $(COMMIT), ( cd $(WORKDIR) && git checkout --detach $(COMMIT) )}
	cp -r dune-files/* $(WORKDIR)/

install:
	dune install coq-hahn
