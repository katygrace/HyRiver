.PHONY: clean clean-test clean-pyc clean-build docs help
.DEFAULT_GOAL := help

define BROWSER_PYSCRIPT
import os
import re
import sys
import webbrowser
from urllib.request import pathname2url

webbrowser.open("file://" + pathname2url(os.path.abspath(sys.argv[1])))
endef
export BROWSER_PYSCRIPT

define PRINT_HELP_PYSCRIPT

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

BROWSER := python -c "$$BROWSER_PYSCRIPT"

help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

clean: clean-build clean-pyc clean-test ## remove all build, test, coverage and Python artifacts

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

lint: ## check style with flake8
	pre-commit run --all-files

docs: ## generate Sphinx HTML documentation, including API docs then open in browser
	for f in pynhd py3dep pygeohydro pydaymet async_retriever pygeoogc pygeoutils;do \
		end=$$(grep -n Contributing $$f/README.rst | cut -d : -f 1); \
		end=$$(expr $$end - 2); \
		fname=docs/source/readme/$$f.rst; \
		awk 'NR==60, NR=='"$$end"'; NR=='"$$end"' {exit}' $$f/README.rst > $$fname; \
	done
	$(MAKE) -C docs clean
	$(MAKE) -C docs html
	$(BROWSER) docs/build/html/index.html

docs-ci: ## generate Sphinx HTML documentation, including API docs but don't open browser
	for f in pynhd py3dep pygeohydro pydaymet async_retriever pygeoogc pygeoutils;do \
		end=$$(grep -n Contributing $$f/README.rst | cut -d : -f 1); \
		end=$$(expr $$end - 2); \
		fname=docs/source/readme/$$f.rst; \
		awk 'NR==60, NR=='"$$end"'; NR=='"$$end"' {exit}' $$f/README.rst > $$fname; \
	done
	$(MAKE) -C docs clean
	$(MAKE) -C docs html
