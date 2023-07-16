# yeah non-idiomatic i know

.PHONY: all tidy clean debug-tidy asm-debug

NIM_BUILD_DIR:= _nimbuild
ASM_BUILD_DIR:= _asmbuild

NIM_SRC := nim_src

ASM_SRC := $(wildcard asm/*.asm)

NIM_FLAGS := --gc:none --os:standalone -d:danger --checks:off --showAllMismatches:on
NIM := nim

ROM_NAME := Scroller
NIM_ENTRY_FILE := $(NIM_SRC)/$(ROM_NAME).nim

GBDK_HOME := ../gbdk/
GBDK_BIN := $(GBDK_HOME)bin/

LCC := $(GBDK_BIN)lcc
LCC_FLAGS := -Iinclude -Wl-m -Wl-j -Wm-yS

SDAS := $(GBDK_BIN)sdasgb
SDAS_FLAGS := -pogn -plosgffw


all: $(ROM_NAME).gb
asm-debug: $(ASM_BUILD_DIR)

$(ROM_NAME).gb: $(NIM_BUILD_DIR)
	$(LCC) $(LCC_FLAGS) -o $@ $(wildcard $(NIM_BUILD_DIR)/*.c) $(ASM_SRC)

$(ASM_BUILD_DIR): $(NIM_BUILD_DIR)
	mkdir -p $@
	$(LCC) $(LCC_FLAGS) -S $(wildcard $(NIM_BUILD_DIR)/*.c) $(ASM_SRC)
	for i in *.asm; do mv $$i $@; done
	touch $@

$(NIM_BUILD_DIR): $(NIM_ENTRY_FILE) $(shell find $(NIM_SRC) -type f -name '*.nim')
	$(NIM) c -c $(NIM_FLAGS) --nimcache:$(NIM_BUILD_DIR) $<
	touch $@

debug-tidy:
	rm -f *.asm

tidy:
	rm -rf $(NIM_BUILD_DIR) $(ASM_BUILD_DIR)
	rm -f *.map *.sym *.noi *.asm

clean: tidy
	rm -f *.gb
