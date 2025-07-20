.DEFAULT_GOAL := explain

SIM := PlaydateSimulator
SDK_BIN := $(PLAYDATE_SDK_PATH)/bin
PDX := build/microvaders.pdx

.PHONY: explain
explain:
	@echo microvaders
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage: \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: build
build: ## Build microvaders
	mkdir -p build
	pdc src $(PDX)

.PHONY: clean
clean: ## Clean up build artifacts
	rm -rf $(PDX)

.PHONY: run
run: build ## Run microvaders
	$(SDK_BIN)/$(SIM) build/microvaders.pdx
