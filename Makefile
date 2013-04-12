.PHONY: init
init:
	# Install dependencies (package.json)
	npm install
	# Fetch components (component.json)
	bower install
	# Build (Gruntfile.coffee)
	grunt build


.PHONY: test
test:
	grunt test
