PACKAGE_NAME = exam-tickets
ORG_FILES = exam-tickets.org
TEST_NAME = test

$(TEST_NAME).pdf: $(TEST_NAME).tex $(PACKAGE_NAME).sty
	pdflatex $(TEST_NAME).tex

$(PACKAGE_NAME).sty: $(PACKAGE_NAME).org
	emacs --script org-tangle.el "$(ORG_FILES)"

