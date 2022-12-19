

URLBASE = https://github.com/Helsinki-NLP/OPUS/blob/main/corpus

all: RELEASES.md RELEASES-without-ELRC.md


RELEASES.md:
	echo "# List of corpus releases" >$@
	echo "" >> $@
	echo "* [list of releases without ELRC](RELEASES-without-ELRC.md)" >> $@
	echo "" >> $@
	echo "| corpus | releases | " >> $@
	echo "|--------|----------| " >> $@
	for c in `find corpus -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort`; do \
	  if [ -e corpus/$$c/info.yaml ]; then \
	    w=`grep website corpus/$$c/info.yaml | cut -f2 -d' '`; \
	    echo -n "| [$$c]($$w) | " >> $@; \
	  else \
	    echo -n "| $$c | " >> $@; \
	  fi; \
	  for v in `find corpus/$$c -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort`; do \
	    echo -n "[$$v](${URLBASE}/$$c/$$v) " >> $@; \
	  done; \
	  echo " |" >> $@; \
	done


RELEASES-without-ELRC.md:
	echo "# List of corpus releases (without ELRC)" >$@
	echo "" >> $@
	echo "* [complete list of releases](RELEASES.md)" >> $@
	echo "" >> $@
	echo "| corpus | releases | " >> $@
	echo "|--------|----------| " >> $@
	for c in `find corpus -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -v ELRC | grep -v ELRA | sort`; do \
	  if [ -e corpus/$$c/info.yaml ]; then \
	    w=`grep website corpus/$$c/info.yaml | cut -f2 -d' '`; \
	    echo -n "| [$$c]($$w) | " >> $@; \
	  else \
	    echo -n "| $$c | " >> $@; \
	  fi; \
	  for v in `find corpus/$$c -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort`; do \
	    echo -n "[$$v](${URLBASE}/$$c/$$v) " >> $@; \
	  done; \
	  echo " |" >> $@; \
	done



## commit all data in the current directory
## (adding files that we want to keep etc)

commit:
	find corpus -name 'README' | xargs git add
	find corpus -name 'LICENSE' | xargs git add
	find corpus -name 'INFO' -exec git add {} \;
	find corpus -name 'CONTACT*' -exec git add {} \;
	find corpus -name 'CITATION*' -exec git git add {} \;
	find corpus -name '*.tsv' | xargs git add
	find corpus -name '*.yaml' | xargs git add
	git add corpus/*/*.txt
	git add corpus/*/*.info
	git add corpus/*/.released*
	git add corpus/*/.uploaded*
	git add *.md
	git commit -am 'corpus update'


RELEASED_VERSIONS = $(shell find corpus -maxdepth 2 -mindepth 2 -type d)

check-release-flags:
	@for r in ${RELEASED_VERSIONS}; do \
	  d=`dirname $$r` ;\
	  v=`basename $$r` ;\
	  if [ ! -e $$d/.released-$$v ]; then \
	    echo "no release flag for $$r ($$d/.released-$$v)"; \
	  fi \
	done


check-upload-flags:
	@for r in ${RELEASED_VERSIONS}; do \
	  d=`dirname $$r` ;\
	  v=`basename $$r` ;\
	  if [ ! -e $$d/.uploaded-$$v ]; then \
	    echo "no upload flag for $$r ($$d/.uploaded-$$v)"; \
	  fi \
	done

check-both-flags:
	@for r in ${RELEASED_VERSIONS}; do \
	  d=`dirname $$r` ;\
	  v=`basename $$r` ;\
	  if [ ! -e $$d/.released-$$v ]; then \
	    if [ ! -e $$d/.uploaded-$$v ]; then \
	      echo "neither upload no release flag for $$r"; \
	    fi \
	  fi \
	done
