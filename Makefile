PACKAGE = exam-tickets
TICKETS = tickets
COURSE_FILE = 052002-test.json
OUTPUT = $(COURSE_FILE:.json=.pdf)
TICKETS_LIST = tickets-list.tex

$(OUTPUT): $(TICKETS).tex $(PACKAGE).sty $(TICKETS_LIST)
	latexmk -pdf $(TICKETS).tex
	mv $(TICKETS).pdf $(OUTPUT)

$(PACKAGE).sty: $(PACKAGE).org $(BUILD_DIR)
	emacs --script org-tangle.el $(PACKAGE).org

$(TICKETS_LIST): $(COURSE_FILE) generate-tickets.py
	./generate-tickets.py $(COURSE_FILE) $(TICKETS_LIST)

clean: $(TICKETS_LIST) $(TICKETS).pdf $(PACKAGE_NAME).sty
	rm $(TICKETS_LIST) $(TICKETS).pdf $(PACKAGE_NAME).sty
