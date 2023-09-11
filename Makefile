all: shellcheck
	$(MAKE) -C ansible

shellcheck:
	find . -name '*.sh' | xargs shellcheck -s bash -f gcc
