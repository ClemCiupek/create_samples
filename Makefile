.PHONY: install
install_script := $(target_dir)/src/install.sh

install:
	@echo "Installing..."
	chmod +x $(install_script)
	./$(install_script)