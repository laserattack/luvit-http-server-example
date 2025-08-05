# Makefile for get Lua runtime

ENVIRONMENT_DIR := environment
INSTALL_SCRIPT := https://github.com/luvit/lit/raw/master/get-lit.sh

.PHONY: all setup run clean

all: setup

setup:
	@stty -echoctl 2>/dev/null
	@echo "Setting up runtime environment..."
	@mkdir -p $(ENVIRONMENT_DIR)
	@cd $(ENVIRONMENT_DIR) && (curl -L $(INSTALL_SCRIPT) | sh)
	@echo "Setup complete! Run 'make run' to start the server."

run:
	@stty -echoctl 2>/dev/null
	@echo "Starting server..."
	@$(ENVIRONMENT_DIR)/luvit main.lua

clean:
	@stty -echoctl 2>/dev/null
	@echo "Cleaning up..."
	@rm -rf $(ENVIRONMENT_DIR)
	@echo "Clean complete."

help:
	@echo "Available targets:"
	@echo "  setup   - Install Luvit runtime (first time setup)"
	@echo "  run     - Start the server"
	@echo "  clean   - Remove runtime directory"
	@echo "  help    - Show this help message"