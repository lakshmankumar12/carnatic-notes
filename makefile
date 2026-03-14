srcdir=$(PWD)

# Document definitions
DOCS := sarali dattu alangaram
sarali_infile := sarali.tex
dattu_infile := dattu.tex
alangaram_infile := alangaram.tex

# Generic function to build any document
define build_doc
	( cd $(srcdir) && rm -f $(1).pdf && \
		[ ! -f $(1).pdf ] || (echo "Error: $(1).pdf still exists after rm" && exit 1) )
	docker run --rm -v $(srcdir):/data moss_xelatex_fonts xelatex -interaction=batchmode -no-pdf-info -jobname=$(1) -output-directory=./ $(2) || true
	test -f $(srcdir)/$(1).pdf
endef

# Individual targets
sarali:
	$(call build_doc,sarali,$(sarali_infile))

dattu:
	$(call build_doc,dattu,$(dattu_infile))

alangaram:
	$(call build_doc,alangaram,$(alangaram_infile))

publish:
	cp src/*pdf docs/

# Build all documents
all: $(DOCS) publish

clean:
	rm -f *log *aux

.PHONY: sarali
