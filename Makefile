REPO = https://github.com/vafeiadis/hahn
TAG = master
COMMIT = d486f449a51c14b8e1093f14d096cc99833974d7
WORKDIR = workdir

# Git boilerplate
define GIT_CLONE_COMMIT
mkdir -p $(WORKDIR) && cd $(WORKDIR) && git init && \
git remote add origin $(REPO) && \
git fetch --depth=1 origin $(COMMIT) && git reset --hard FETCH_HEAD
endef
GIT_CHECKOUT = ${if $(COMMIT), $(GIT_CLONE_COMMIT), git clone --recursive --depth=1 -b $(TAG) $(REPO) $(WORKDIR)}

.PHONY: all get

all: $(WORKDIR)
	dune build

get: $(WORKDIR)

$(WORKDIR):
	$(GIT_CHECKOUT)
	cp -r dune-files/* $(WORKDIR)/

install:
	dune install coq-hahn
