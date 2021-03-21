setup:
	./script/setup.sh
	open SampleCompositonalLayout.xcworkspace

.PHONY: setup

clean:
	./script/clean.sh

component:
ifdef name
	mint run pui component MVC_COLLECTION ${name}
else
	@echo "make component name=<component name>"
endif
.PHONY: component
.PHONY: clean
