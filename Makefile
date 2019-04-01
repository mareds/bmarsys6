#################################
# Makefile for website built:
# mareds/bmarsys6 website
# Copyright Saskia A. Otto 2019
#################################

RMD_SITE = $(wildcard site/*.Rmd)
HTML_SITE = $(patsubst site/%.Rmd, docs/%.html, $(RMD_SITE))

RMD_EXER = $(wildcard exercises/ex_*.Rmd)
HTML_EXER  = $(patsubst exercises/%.Rmd, docs/%.html, $(RMD_EXER))


$(info Building the docs folder for github-pages)

all : exercises site
	$(info The site is now in the docs folder)

exercises : $(HTML_EXER)

site : $(HTML_SITE)


# docs/ex_%.html : exercises/ex_%.Rmd
# 	touch exercises/index.Rmd
# 	cp site/_site.yml exercises/_site.yml
# 	cp site/_navbar.html  exercises/_navbar.html
# 	cp site/footer_site.html  exercises/footer_site.html
# 	Rscript -e "rmarkdown::render_site(input = '$<', encoding = 'UTF-8')" || (rm exercises/index.Rmd exercises/_site.yml exercises/_navbar.html exercises/footer_site.html; echo >&2 "Failed to build exercises"; false)
# 	rm exercises/index.Rmd exercises/_site.yml exercises/_navbar.html exercises/footer_site.html

docs/%.html : site/%.Rmd site/_site.yml
	touch docs/.nojekyll
	Rscript -e "rmarkdown::render_site(input = '$<', encoding = 'UTF-8')"


clean :
	rm -rf docs/*
	rm -f lectures/index.Rmd lectures/_site.yml lectures/footer_site.html exercises/index.Rmd exercises/_site.yml exercises/_navbar.html exercises/footer_site.html
	$(info The docs folder is now empty)
