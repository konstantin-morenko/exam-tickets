COURSE_FILE = 052002-test.json
OUTPUT = $(COURSE_FILE:.json=)
TICKETS_EXT = -tickets
LIST_EXT = -list

all: $(OUTPUT)$(TICKETS_EXT).pdf $(OUTPUT)$(LIST_EXT).pdf


exam-tickets.sty: exam-tickets.org
	emacs --script org-tangle.el exam-tickets.org


tickets-list.tex: $(COURSE_FILE)
	./generate-tickets.py $(COURSE_FILE) tickets-list.tex

$(OUTPUT)$(TICKETS_EXT).pdf: tickets.tex exam-tickets.sty tickets-list.tex
	latexmk -pdf tickets.tex
	mv tickets.pdf $(OUTPUT)$(TICKETS_EXT).pdf


questions-list.tex: $(COURSE_FILE)
	./generate-list.py $(COURSE_FILE) questions-list.tex

$(OUTPUT)$(LIST_EXT).pdf: questions.tex exam-tickets.sty questions-list.tex
	latexmk -pdf questions.tex
	mv questions.pdf $(OUTPUT)$(LIST_EXT).pdf
