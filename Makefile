.PHONY: default
default:
	cat README.md
	futhark test demo.fut
