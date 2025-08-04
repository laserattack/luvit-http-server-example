# Makefile for Luvit HTTP server project

ENVIRONMENT_DIR := environment
LIT_INSTALL_SCRIPT := https://github.com/luvit/lit/raw/master/get-lit.sh

.PHONY: all setup run clean

all: setup

setup:
	@echo "Setting up runtime environment..."
	@mkdir -p $(ENVIRONMENT_DIR)
	@cd $(ENVIRONMENT_DIR) && (curl -L $(LIT_INSTALL_SCRIPT) | sh)
	@echo "Setup complete! Run 'make run' to start the server."

run:
	@echo "Starting server..."
	@$(ENVIRONMENT_DIR)/luvit main.lua

clean:
	@echo "Cleaning up..."
	@rm -rf $(ENVIRONMENT_DIR)
	@echo "Clean complete."

help:
	@echo "Available targets:"
	@echo "  setup   - Install Luvit runtime (first time setup)"
	@echo "  run     - Start the server"
	@echo "  clean   - Remove runtime directory"
	@echo "  help    - Show this help message"