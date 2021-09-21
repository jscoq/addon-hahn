REPO = https://github.com/vafeiadis/hahn
TAG = master
COMMIT = b5dce20de40bf3fbab9afc0ac7c7231f65096990
WORKDIR = workdir

# Git boilerplate
define GIT_CLONE_COMMIT
mkdir -p $(WORKDIR) && cd $(WORKDIR) && git init && \
git remote add origin $(REPO) && \
git fetch --depth=1 origin $(COMMIT) && git reset --hard FETCH_HEAD
endef

.PHONY: all get

all: $(WORKDIR)
	dune build

get: $(WORKDIR)

$(WORKDIR):
	${if $(COMMIT), $(GIT_CLONE_COMMIT), git clone --recursive --depth=1 -b $(TAG) $(REPO) $(WORKDIR)}
	( cd $(WORKDIR) && git apply ../etc/tmp-8.14.patch )
	cp -r dune-files/* $(WORKDIR)/

install:
	dune install coq-hahn
