help:
	@echo "This project supports the following targets"
	@echo ""
	@echo " make help - show this text"
	@echo " make hooks - Run all hooks like pre-commit, etc... (Currently only has pre-commit hook)"
	@echo " make deps - check for terraform and tflint installations"
	@echo " make check - run terraform fmt check to check for all HCL code formatting opportunities in the project"
	@echo " make reformat - run terraform fmt to auto format all HCL code in the project"
	@echo " make lint - run lint tflint check"
	@echo " make pre-commit - run pre-commit checks on all the files"
	@echo ""

all: deps

hooks: pre-commit

deps: check_terraform_installed check_tflint_installed

check:
	@terraform fmt --recursive -check

reformat:
	@terraform fmt --recursive

lint:
	@pre-commit run terraform_tflint --hook-stage manual --all-files

check_terraform_installed:
	@which terraform || (echo "terraform not found, please install it (sudo snap install terraform --classic)!"; exit 1)

check_tflint_installed:
	@which tflint || (echo "tflint not found, please install it (sudo snap install tflint)!"; exit 1)

pre-commit:
	@which pre-commit 1>/dev/null 2>&1 || sudo apt-get install -y pre-commit
	@pre-commit install 1>/dev/null

.PHONY: all deps check reformat hooks check_terraform_installed check_tflint_installed pre-commit tflint