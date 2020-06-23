environment:
	rbenv install -s
	rbenv rehash
	rbenv exec bundle install

init:
	make environment
	rbenv exec bundle exec fastlane init_proj --env local

publish:
	make environment
	rbenv exec bundle exec fastlane preview

test:
	make environment
	rbenv exec bundle exec fastlane test

clean:
	rm -rf vendor
	rm -rf View/View.xcodeproj
	rm -rf UseCase/UseCase.xcodeproj
	rm -rf DataSource/DataSource.xcodeproj
	rm -rf main/main.xcodeproj
	rm -rf main.xcworkspace
