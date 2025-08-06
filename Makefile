# Makefile for get Lua runtime

ENVIRONMENT_DIR := environment
INSTALL_SCRIPT := https://github.com/luvit/lit/raw/master/get-lit.sh
REQUIRED_FILES := lit luvi luvit

.PHONY: all setup run clean help

all: setup

# addprefix — это встроенная функция Makefile, 
#которая добавляет префикс к каждому элементу списка.
# Т.е. список зависимостей получится такой:
# environment/lit environment/luvi environment/luvit
setup: $(addprefix $(ENVIRONMENT_DIR)/,$(REQUIRED_FILES))
	@echo "Setup complete! Run 'make run' to start the server."

# % — это wildcard (шаблон), который соответствует любому имени файла.
# Правило срабатывает для каждого отсутствующего файла из _списка зависимостей setup_.
# Например, если нет environment/luvit, Make выполнит это правило для его создания.
$(ENVIRONMENT_DIR)/%:
	@echo "Setting up runtime environment..."
	@mkdir -p $(ENVIRONMENT_DIR)
	@cd $(ENVIRONMENT_DIR) && (curl -L $(INSTALL_SCRIPT) | sh)

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