IMAGE ?= ee292m-setup
# The coding agent only needs to be present on the dev machine, not in CI.
AGENT ?= claude

.PHONY: verify tools git docker agent test clean

verify: tools git docker agent test
	@echo "==> make verify: ALL GREEN"

tools:
	@echo "==> toolchain"
	@git --version
	@$(MAKE) --version | head -1
	@docker --version

git:
	@echo "==> git + GitHub"
	@git rev-parse --is-inside-work-tree >/dev/null
	@git config user.name >/dev/null || (echo "git user.name not set" && exit 1)
	@git config user.email >/dev/null || (echo "git user.email not set" && exit 1)
	@git remote get-url origin | grep -q github.com || (echo "origin is not a GitHub remote" && exit 1)
	@git ls-remote --exit-code origin >/dev/null && echo "origin reachable: $$(git remote get-url origin)"

docker:
	@echo "==> docker daemon"
	@docker info --format 'server {{.ServerVersion}}'

agent:
	@echo "==> coding agent"
	@if [ -n "$$CI" ]; then echo "CI run: skipping local agent check"; else $(AGENT) --version; fi

test:
	@echo "==> tests in Docker"
	docker build -q -t $(IMAGE) .
	docker run --rm $(IMAGE)

clean:
	-docker rmi $(IMAGE)
