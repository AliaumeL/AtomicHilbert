.PHONY: clean all

PAPER=atomic
SRC=src/*.tex             \
    lib/*.tex             \
    papers.bib            \
    lib/knowledges.kl     \
    ensps-colorscheme.sty \
    plainurl.bst	        \
    $(PAPER).md

all: $(PAPER).pdf


      arxiv-meta.txt: paper-meta.yaml 
	pandoc --metadata-file=paper-meta.yaml \
		     --lua-filter=templates/git-meta.lua \
			   --template=templates/arxiv-submission.txt \
			   -t plain \
			   --wrap=none \
			   -o arxiv-meta.txt \
			   $(PAPER).md

# Default target: create the pdf file
%.pdf: %.tex 
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" $<

$(PAPER).tex: $(SRC) ./paper-meta.yaml
	pandoc -t latex \
		   --defaults plain \
		   --metadata-file=./paper-meta.yaml \
		   --wrap=none \
		   -o $(PAPER).tex \
		   $(PAPER).md

$(PAPER).sigconf.tex: $(SRC) ./paper-meta.yaml
	pandoc -t latex \
		     --output $(PAPER).sigconf.tex \
			   --defaults acmart \
			   --metadata-file=./paper-meta.yaml \
			   --wrap=none \
		     $(PAPER).md

# Create a single file tex document for arXiv
$(PAPER).arxiv.tex: $(PAPER).tex ./paper-meta.yaml
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" $(PAPER).tex
	latexpand -o $(PAPER).arxiv.tex         \
		        --empty-comments          \
		        --expand-bbl $(PAPER).plain.tex \
						$(PAPER).tex
	@rm $(PAPER).plain.*

# Create an archive with the single file tex document and the license
$(PAPER).arxiv.tar.gz: $(PAPER).arxiv.tex
	tar -czf $(PAPER).arxiv.tar.gz \
           $(PAPER).arxiv.tex    \
			 plainurl.bst              \
			 ensps-colorscheme.sty     \
       ./LICENSE

$(PAPER).arxiv.pdf: $(PAPER).arxiv.tar.gz
	# create temporary directory
	@mkdir -p /tmp/$(PAPER).arxiv
	# extract archive
	@tar -xzf $(PAPER).arxiv.tar.gz -C /tmp/$(PAPER).arxiv
	# compile in the temporary directory
	cd  /tmp/$(PAPER).arxiv && latexmk -pdf $(PAPER).arxiv.tex
	# extract the pdf 
	@cp /tmp/$(PAPER).arxiv/$(PAPER).arxiv.pdf ./
	# delete the temporary directory
	@rm -rf /tmp/$(PAPER).arxiv/

clean: 
	latexmk -C
	rm -f *.tex *.tar.gz *.aux *.bbl *.kaux *.blg *.log *.out *.fls *.fdb_latexmk *.synctex.gz
