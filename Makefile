################################################################################
# Global defines
################################################################################

# COLORS
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

# new line and tab
define NEWLINE


endef

define TAB
	
endef

################################################################################
# Output current makefile info
################################################################################
Author=crifan.com
Version=20171214
Function=Auto use gitbook to generated files: website/pdf/epub/mobi
RunHelp = Run 'make help' to see usage
$(info --------------------------------------------------------------------------------)
$(info ${YELLOW}Author${RESET}  : ${GREEN}$(Author)${RESET})
$(info ${YELLOW}Version${RESET} : ${GREEN}$(Version)${RESET})
$(info ${YELLOW}Function${RESET}: ${GREEN}$(Function)$(NEWLINE)$(TAB)$(TAB)$(RunHelp)${RESET})
$(info --------------------------------------------------------------------------------)

# get current folder name
# support call makefile from anywhere, not only from current path of makefile located
# MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
# CURRENT_DIR := $(notdir $(patsubst %/,%,$(MAKEFILE_DIR))
MAKEFILE_LIST_LASTWORD = $(lastword $(MAKEFILE_LIST))
MAKEFILE_PATH := $(abspath $(MAKEFILE_LIST_LASTWORD))
MAKEFILE_DIR := $(dir $(MAKEFILE_PATH))
MAKEFILE_DIR_PATSUBST := $(patsubst %/,%,$(MAKEFILE_DIR))
MAKEFILE_DIR_NOSLASH = $(MAKEFILE_DIR_PATSUBST)
CURRENT_DIR = $(MAKEFILE_DIR)
CURRENT_DIR_NOSLASH = $(MAKEFILE_DIR_NOSLASH)
CURRENT_DIR_NAME := $(notdir $(MAKEFILE_DIR_PATSUBST))

BOOK_NAME := $(CURRENT_DIR_NAME)

OUTPUT_PATH = $(CURRENT_DIR_NOSLASH)/output
DEBUG_PATH = $(CURRENT_DIR_NOSLASH)/debug

WEBSITE_PATH = $(OUTPUT_PATH)/website/
PDF_PATH = $(OUTPUT_PATH)/pdf/
EPUB_PATH = $(OUTPUT_PATH)/epub/
MOBI_PATH = $(OUTPUT_PATH)/mobi/

PDF_NAME = $(BOOK_NAME).pdf
EPUB_NAME = $(BOOK_NAME).epub
MOBI_NAME = $(BOOK_NAME).mobi

WEBSITE_FULLNAME = $(WEBSITE_PATH)
PDF_FULLNAME = $(PDF_PATH)/$(PDF_NAME)
EPUB_FULLNAME = $(EPUB_PATH)/$(EPUB_NAME)
MOBI_FULLNAME = $(MOBI_PATH)/$(MOBI_NAME)

.DEFAULT_GOAL := all

.PHONY : debug_dir debug
.PHONY : help
.PHONY : create_folder_all create_folder_website create_folder_pdf create_folder_epub create_folder_mobi
.PHONY : clean_all clean_website clean_pdf clean_epub clean_mobi
.PHONY : all website pdf epub mobi

## Print current directory related info
debug_dir:
	@echo MAKEFILE_LIST=$(MAKEFILE_LIST)
	@echo MAKEFILE_LIST=$(value MAKEFILE_LIST)
	@echo MAKEFILE_LIST_LASTWORD=$(MAKEFILE_LIST_LASTWORD)
	@echo MAKEFILE_PATH=$(MAKEFILE_PATH)
	@echo MAKEFILE_DIR=$(MAKEFILE_DIR)
	@echo MAKEFILE_DIR_PATSUBST=$(MAKEFILE_DIR_PATSUBST)
	@echo CURRENT_DIR=$(CURRENT_DIR)
	@echo CURRENT_DIR_NOSLASH=$(CURRENT_DIR_NOSLASH)
	@echo CURRENT_DIR_NAME=$(CURRENT_DIR_NAME)
	@echo WEBSITE_PATH=$(WEBSITE_PATH)
	@echo WEBSITE_FULLNAME=$(WEBSITE_FULLNAME)
	@echo PDF_PATH=$(PDF_PATH)
	@echo PDF_FULLNAME=$(PDF_FULLNAME)

################################################################################
# Create folder
################################################################################

## Create folder for gitbook local debug
create_folder_debug: 
	mkdir -p $(DEBUG_PATH)

## Create folder for gitbook website
create_folder_website: 
	mkdir -p $(WEBSITE_PATH)

## Create folder for pdf
create_folder_pdf: 
	mkdir -p $(PDF_PATH)

## Create folder for epub
create_folder_epub: 
	mkdir -p $(EPUB_PATH)

## Create folder for mobi
create_folder_mobi: 
	mkdir -p $(MOBI_PATH)

## Create folder for all: website/pdf/epub/mobi
create_folder_all: create_folder_website create_folder_pdf create_folder_epub create_folder_mobi

################################################################################
# Clean
################################################################################

## Clean gitbook debug
clean_debug:
	-rm -rf $(DEBUG_PATH)

## Clean generated gitbook website whole folder
clean_website:
	-rm -rf $(WEBSITE_PATH)

## Clean generated PDF file and whole folder
clean_pdf:
	-rm -rf $(PDF_PATH)

## Clean generated ePub file and whole folder
clean_epub:
	-rm -rf $(EPUB_PATH)

## Clean generated Mobi file and whole folder
clean_mobi:
	-rm -rf $(MOBI_PATH)

## Clean all generated files
clean_all: clean_website clean_pdf clean_epub clean_mobi

################################################################################
# Generate Files
################################################################################

## Debug gitbook
debug: clean_debug create_folder_debug
	gitbook serve $(CURRENT_DIR_NOSLASH) $(DEBUG_PATH)

## Generate gitbook website
website: clean_website create_folder_website
	@echo ================================================================================
	@echo Generate website for $(BOOK_NAME)
	gitbook build $(CURRENT_DIR_NOSLASH) $(WEBSITE_FULLNAME)

## Generate PDF file
pdf: clean_pdf create_folder_pdf
	@echo ================================================================================
	@echo Generate PDF for $(BOOK_NAME)
	gitbook pdf $(CURRENT_DIR_NOSLASH) $(PDF_FULLNAME)

## Generate ePub file
epub: clean_epub create_folder_epub
	@echo ================================================================================
	@echo Generate ePub for $(BOOK_NAME)
	gitbook epub $(CURRENT_DIR_NOSLASH) $(EPUB_FULLNAME)

## Generate Mobi file
mobi: clean_mobi create_folder_mobi
	@echo ================================================================================
	@echo Generate Mobi for $(BOOK_NAME)
	gitbook mobi $(CURRENT_DIR_NOSLASH) $(MOBI_FULLNAME)

## Generate all files: website/pdf/epub/mobi
all: website pdf epub mobi


################################################################################
# Help
################################################################################

TARGET_MAX_CHAR_NUM=25
## Show help
help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)