.PHONY: build serve open

SRCDIR:=src
PUBLICDIR:=public
MAIN_ELM:=$(SRCDIR)/Main.elm
OUTPUT_JS:=$(PUBLICDIR)/main.js

MAIN_HTML:=$(PUBLICDIR)/index.html

LOCALPORT:=8080

build:
	@elm make $(MAIN_ELM) --output=$(OUTPUT_JS)

serve:
	@cmd /c "start http://127.0.0.1:$(LOCALPORT)"
	@python -m http.server --directory $(PUBLICDIR) $(LOCALPORT)

open:
	@cmd /c "start $(MAIN_HTML)"
