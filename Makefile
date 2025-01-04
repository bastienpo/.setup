.PHONY: rebuild clean

rebuild:
	@bash ./script/rebuild

setup:
	@bash ./script/setup_dotfiles

clean:
	@rm -rf **/*.log
