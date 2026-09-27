# ee292m-setup

EE292M (Fall 2026) environment check: git + GitHub, Docker, Make, and a coding agent (Claude Code).

```bash
make verify
```

`make verify` checks the toolchain, git identity and a reachable GitHub `origin`, the Docker daemon,
the coding agent (skipped in CI), and then builds a container and runs the unit tests inside it.
GitHub Actions runs the same target on every push.
