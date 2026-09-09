.PHONY: clean docs format test repl build precompile initialize check
.DEFAULT_GOAL := help

define PRINT_HELP_PYSCRIPT
import re, sys
for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

JULIA ?= julia
PROJECT := --project=.

help:
	@python3 -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

initialize: ## instantiate project deps and dev tools (JuliaFormatter, Documenter)
	$(JULIA) $(PROJECT) -e 'using Pkg; Pkg.instantiate()'
	$(JULIA) -e 'using Pkg; Pkg.add(["JuliaFormatter", "Documenter"])'

precompile: ## force precompilation of the package and its dependencies
	$(JULIA) $(PROJECT) -e 'using Pkg; Pkg.precompile()'

build: initialize precompile ## instantiate deps and precompile (full build)

test: ## run the package test suite (Pkg.test)
	$(JULIA) $(PROJECT) -e 'using Pkg; Pkg.test()'

check: test ## alias for `test`, mirrors R workflow's `check`

repl: ## start a Julia REPL with this project activated
	$(JULIA) $(PROJECT) -i -e 'using Ahead'

load: repl ## alias for `repl`, mirrors R workflow's `load`

format: ## check/format source files with JuliaFormatter
	$(JULIA) -e 'using JuliaFormatter; format(".")'

docs: ## build documentation with Documenter.jl (expects docs/make.jl)
	$(JULIA) --project=docs -e 'using Pkg; Pkg.instantiate()'
	$(JULIA) --project=docs docs/make.jl

clean: ## remove build artifacts, manifests and doc builds
	rm -f Manifest.toml
	rm -f docs/Manifest.toml
	rm -rf docs/build
	rm -rf deps/build.log
	find . -name "*.cov" -type f -delete
	find . -name ".DS_Store" -type f -delete
