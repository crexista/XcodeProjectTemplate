SKIP_CERT=false
ACTIONS=false

ifeq ($(ACTIONS),false)
    BUNDLE := rbenv exec bundle
    NPM := nodenv exec npm
else
    BUNDLE := bundle
    NPM := npm
endif

echo:
	$(BUNDLE) --version
	$(NPM) --version

environment:
	rbenv install -s
	rbenv rehash
	nodenv install -s
	nodenv rehash

install:
	$(BUNDLE) install
	$(NPM) install --prefix UseCase/GraphQL
	$(NPM) run setup --prefix UseCase/GraphQL
	$(NPM) run dist --prefix UseCase/GraphQL

init:
	make environment
	make install
	$(BUNDLE) exec fastlane local

reload:
	make resource
	make code
	$(BUNDLE) exec fastlane run projectgen

resource:
	ruby fastlane/assetgen View/Images.xcassets
	./Pods/SwiftGen/bin/swiftgen config run --config ./swiftgen.yml

code:
	$(NPM) run dist --prefix UseCase/GraphQL

publish:
ifeq ($(PRESET),preview)
	make config
	$(BUNDLE) exec fastlane preview build:$(NUMBER)
else
	make config ENV=dev
	$(BUNDLE) exec fastlane adhoc build:$(NUMBER)
endif

test:
	$(BUNDLE) exec fastlane test

clean:
	rm -rf vendor
	rm -rf main/main.xcodeproj
	rm -rf Packages/App/.build
	rm -rf Packages/View/.build
	rm -rf Packages/UseCase/.build
	rm -rf Packages/Infrastructure/.build


format:
	cd CodingSupport;SDKROOT=(xcrun --sdk macosx --show-sdk-path);\
	swift run -c release swiftlint  --fix --format

