.PHONY: install
install_script := src/install.sh

install:
	@echo "Installing..."
	@chmod +x $(install_script)
	@./$(install_script)