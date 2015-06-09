.PHONY: test flake clean coverage docs coveralls

fix_tablib:
	# https://github.com/kennethreitz/tablib/issues/177
	pip install 'git+https://github.com/kennethreitz/tablib.git@develop'

install: fix_tablib
	pip install -e .

install-test: fix_tablib
	pip install -r requirements/test.txt

install-dev: fix_tablib
	pip install -r requirements/dev.txt

install-docs:
	pip install -r requirements/docs.txt

test: clean
	test_ralph test ralph

flake: clean
	flake8 src/ralph

clean:
	find . -name '*.py[cod]' -exec rm -rf {} \;

coverage: clean
	coverage run '$(VIRTUAL_ENV)/bin/test_ralph' test ralph

docs:
	mkdocs build

coveralls: install-docs docs coverage
