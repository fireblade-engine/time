SWIFT_PACKAGE_VERSION := $(shell swift package tools-version)

# Delete package build artifacts.
.PHONY: clean
clean:
	swift package clean

# Lint fix and format code.
.PHONY: lint-fix
lint-fix:
	swiftlint --fix --quiet
	swiftformat --quiet --swiftversion ${SWIFT_PACKAGE_VERSION} .

.PHONY: pre-push
pre-push: lint-fix

# Build debug version
.PHONY: build-debug
build-debug:
	swift build -c debug

# Build release version 
.PHONY: build-release
build-release:
	swift build -c release --skip-update

# Reset the complete cache/build directory and Package.resolved files
.PHONY: reset
	swift package reset
	-rm Package.resolved
	-rm rdf *.xcworkspace/xcshareddata/swiftpm/Package.resolved
	-rm -rdf .swiftpm/xcode/*

.PHONY: resolve
resolve:
	swift package resolve

.PHONY: open-proj-xcode
open-proj-xcode:
	open -b com.apple.dt.Xcode Package.swift

.PHONY: open-proj-vscode
open-proj-vscode:
	code .

.PHONY: setup-brew
setup-brew:
	@which -s brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	@brew update
