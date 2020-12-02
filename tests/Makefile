#!/usr/bin/make
PROJECTS = $(shell find . -name \*.pro | grep -v libraries\*)
OUTPUT_BASE = $(shell pwd)/Fabrication

.PHONY: all clean tests artifacts

all: tests artifacts

clean:
	@rm -rf $(OUTPUT_BASE)
	@rm -rf .prep

.prep:
	@rm -rf $(OUTPUT_BASE)
	@mkdir -p $(OUTPUT_BASE)
	@touch .prep

tests: .prep
	@for pro in $(PROJECTS); do \
		echo "############################################################################"; \
		echo "#### Generating tests for $$pro"; \
		echo "############################################################################"; \
		cd $$(dirname $$pro); \
		output_dir=$$(echo $(OUTPUT_BASE)/$$(basename $$pro) | cut -f 1 -d '.'); \
		mkdir -p $$output_dir; \
		kiplot -d $$output_dir preflight; \
		cd $(OUTPUT_BASE)/..; \
	done

artifacts: .prep
	@for pro in $(PROJECTS); do \
		echo "############################################################################"; \
		echo "#### Generating artifacts for $$pro"; \
		echo "############################################################################"; \
		cd $$(dirname $$pro); \
		output_dir=$$(echo $(OUTPUT_BASE)/$$(basename $$pro) | cut -f 1 -d '.'); \
		mkdir -p $$output_dir; \
		kiplot -d $$output_dir -s run_erc,run_drc pdf_pcb_print pcbdraw_bot pcbdraw_top step dxf ibom pdf_sch_print; \
		cd $(OUTPUT_BASE)/..; \
	done
