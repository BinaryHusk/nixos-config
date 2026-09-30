HOST ?= N9
FLAKE ?= .#$(HOST)
NIXOS_REBUILD ?= sudo nixos-rebuild
GIT ?= git

.DEFAULT_GOAL := help

.PHONY: help check build test boot switch update show commit

help:
	@printf '%s\n' \
	  'make check   - evaluate the flake without changing the system' \
	  'make build   - build the NixOS system without activating it' \
	  'make test    - build and activate until the next reboot' \
	  'make boot    - build and select for the next reboot' \
	  'make switch  - build and activate persistently' \
	  'make update  - update flake.lock inputs' \
	  'make show    - show flake outputs' \
	  'make commit  - add all changes and commit as [N]'

check:
	nix flake check --no-build

build:
	$(NIXOS_REBUILD) build --flake $(FLAKE)

test:
	$(NIXOS_REBUILD) test --flake $(FLAKE)

boot:
	$(NIXOS_REBUILD) boot --flake $(FLAKE)

switch:
	$(NIXOS_REBUILD) switch --flake $(FLAKE)

update:
	nix flake update

show:
	nix flake show

# Stage the whole worktree and create the next numbered commit, e.g. [12].
# The number is the largest [N] found in all reachable refs, plus one.
commit:
	@set -eu; \
	$(GIT) add -A; \
	if $(GIT) diff --cached --quiet; then \
		echo '没有可提交的变更'; \
		exit 1; \
	fi; \
	id=$$( $(GIT) log --all --format='%s' | \
		sed -n 's/^\[\([0-9][0-9]*\)\].*/\1/p' | \
		sort -n | tail -n 1 ); \
	id=$${id:-0}; \
	id=$$((id + 1)); \
	echo "将提交为 [$$id]"; \
	$(GIT) diff --cached --stat; \
	$(GIT) commit -m "[$$id]"
