.PHONY: build serve open format

SRCDIR:=src
PUBLICDIR:=public
MAIN_ELM:=$(SRCDIR)/Main.elm
OUTPUT_JS:=$(PUBLICDIR)/main.js

MAIN_HTML:=$(PUBLICDIR)/index.html

LOCALPORT:=8080


build:
	# @elm make $(MAIN_ELM) --output=$(OUTPUT_JS)
	@elm make $(MAIN_ELM) --optimize --output=$(OUTPUT_JS)
	@npx esbuild $(OUTPUT_JS) --minify --outfile=$(OUTPUT_JS) --allow-overwrite

format:
	@elm-format src/ --yes

serve:
	@npx http-server -o -p $(LOCALPORT) $(PUBLICDIR)

open:
	@cmd /c "start $(MAIN_HTML)"
