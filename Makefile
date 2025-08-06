ENVIRONMENT_DIR := environment
INSTALL_SCRIPT := https://github.com/luvit/lit/raw/master/get-lit.sh
REQUIRED_FILES := lit luvi luvit
DEPS_DIR := deps

.PHONY: all setup run clean help

all: setup

setup: $(addprefix $(ENVIRONMENT_DIR)/,$(REQUIRED_FILES)) $(DEPS_DIR)
	@echo "Setup complete! Run 'make run' to start the server."

$(ENVIRONMENT_DIR)/%:
	@echo "Setting up runtime environment..."
	@mkdir -p $(ENVIRONMENT_DIR)
	@cd $(ENVIRONMENT_DIR) && (curl -L $(INSTALL_SCRIPT) | sh)
	@echo "Downloading deps..."
	@$(ENVIRONMENT_DIR)/lit install

$(DEPS_DIR):
	@echo "Downloading deps..."
	@$(ENVIRONMENT_DIR)/lit install

run:
	@echo "Starting server..."
	@$(ENVIRONMENT_DIR)/luvit main.lua

clean:
	@echo "Cleaning up..."
	@rm -rf $(ENVIRONMENT_DIR)
	@rm -rf $(DEPS_DIR)
	@echo "Clean complete."

help:
	@echo "Available targets:"
	@echo "  setup   - Install Luvit runtime and download deps (first time setup)"
	@echo "  run     - Start the server"
	@echo "  clean   - Remove runtime and deps directories"
	@echo "  help    - Show this help message"