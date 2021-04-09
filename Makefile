setup:
	./script/setup.sh
	open SampleCompositonalLayout.xcworkspace
.PHONY: setup

clean:
	./script/clean.sh
.PHONY: clean

layout:
ifdef name
	mint run pui component CompositionalLayout ${name}
else
	@echo "make component name=<component name>"
endif
.PHONY: layout

datasources:
ifdef name
	mint run pui component DiffableDataSources ${name}
else
	@echo "make component name=<component name>"
endif
.PHONY: datasources

example:
ifdef name
	mint run pui component Example ${name}
else
	@echo "make component name=<component name>"
endif
.PHONY: example

