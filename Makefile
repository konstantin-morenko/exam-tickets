PACKAGE_NAME = exam-tickets
ORG_FILES = exam-tickets.org
PACKAGE_FILES = exam-tickets.sty
TEST_NAME = test
COURSE = 052002-test

$(TEST_NAME).pdf: $(TEST_NAME).tex $(PACKAGE_NAME).sty tickets.tex
	pdflatex $(TEST_NAME).tex

$(PACKAGE_NAME).sty: $(PACKAGE_NAME).org $(BUILD_DIR)
	emacs --script org-tangle.el "$(ORG_FILES)"

tickets.tex: $(COURSE).json generate-tickets.py
	./generate-tickets.py $(COURSE).json tickets.tex
