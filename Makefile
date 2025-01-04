.PHONY: rebuild clean

rebuild:
	@bash ./script/rebuild

clean:
	@rm -rf *.log
