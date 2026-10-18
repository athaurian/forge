.PHONY: format check

format:
	npx --yes prettier@3.9.10 --write README.md
	shfmt -i 2 -w packages/*/PKGBUILD .github/scripts/*.sh
	uvx ruff@0.17.1 format .github/scripts/*.py

check:
	npx --yes prettier@3.9.10 --check README.md
	shfmt -i 2 -d packages/*/PKGBUILD .github/scripts/*.sh
	uvx ruff@0.17.1 format --check .github/scripts/*.py
	uvx ruff@0.17.1 check .github/scripts/*.py
	uvx mypy@2.4.0 .github/scripts/*.py
	python3 -m py_compile .github/scripts/*.py
