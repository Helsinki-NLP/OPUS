

URLBASE = https://github.com/Helsinki-NLP/OPUS/blob/main/corpus

TSV_FILES = info/RELEASES.tsv \
	info/RELEASE_LICENSES.tsv \
	info/RELEASE_HISTORY.tsv \
	info/RELEASE_SIZE.tsv \
	info/RELEASE_NR_OF_LANGUAGES.tsv

MD_FILES = info/RELEASES.md info/RELEASES-without-ELRC.md

all:  ${MD_FILES} ${TSV_FILES}
	${MAKE} commit
	${MAKE} cleanup-dry-run > untracked-files.txt

info:  ${MD_FILES} ${TSV_FILES}

## remove untracked files
## (all released data that we don't store in the repository)

cleanup-dry-run:
	echo "${MAKE} commit"
	git clean -d -n

cleanup:
	${MAKE} commit
	git clean -d -f


# create a TSV file with essential release information

info/RELEASES.tsv: corpus
	find corpus/ -mindepth 3 -name info.yaml | xargs grep 'release date:' > $@.1
	cut -f1 -d: $@.1 | cut -f2,3 -d/ > $@.corpus
	cut -f3- -d: $@.1 | cut -f3 -d/ | \
		sed 's/unknown/1900-01-01/' |\
		sed 's/^ /date +%F --date="/;s/$$/"/' > $@.date.sh
	chmod +x $@.date.sh
	./$@.date.sh | sed 's/1900-01-01/unknown/' > $@.date
	paste $@.corpus $@.date | sort -k1,1 -u > $@.releases
	find corpus/ -mindepth 3 -name info.yaml | xargs grep 'license:' > $@.1
	cut -f1 -d: $@.1 | cut -f2,3 -d/ > $@.2
	cut -f3- -d: $@.1 | sed 's/^ *//' | tr "\t" ' ' > $@.3
	paste $@.2 $@.3 | sort -k1,1 -u > $@.license
	find corpus/ -mindepth 3 -name info.yaml | xargs grep 'alignments:' > $@.1
	cut -f1 -d: $@.1 | cut -f2,3 -d/ > $@.2
	cut -f3 -d: $@.1 | sed 's/^ *//' > $@.3
	paste $@.2 $@.3 | sort -k1,1 -u > $@.alignments
	find corpus/ -mindepth 3 -name info.yaml | xargs grep 'sentences:' > $@.1
	cut -f1 -d: $@.1 | cut -f2,3 -d/ > $@.2
	cut -f3 -d: $@.1 | sed 's/^ *//' > $@.3
	paste $@.2 $@.3 | sort -k1,1 -u > $@.sentences
	find corpus/ -mindepth 3 -name info.yaml | xargs grep 'tokens:' > $@.1
	cut -f1 -d: $@.1 | cut -f2,3 -d/ > $@.2
	cut -f3 -d: $@.1 | sed 's/^ *//' > $@.3
	paste $@.2 $@.3 | sort -k1,1 -u > $@.tokens
	find corpus/ -mindepth 3 -name info.yaml | xargs grep 'number of languages:' > $@.1
	cut -f1 -d: $@.1 | cut -f2,3 -d/ > $@.2
	cut -f3 -d: $@.1 | sed 's/^ *//' > $@.3
	paste $@.2 $@.3 | sort -k1,1 -u > $@.languages
	find corpus/ -mindepth 3 -name info.yaml | xargs grep 'number of language pairs:' > $@.1
	cut -f1 -d: $@.1 | cut -f2,3 -d/ > $@.2
	cut -f3 -d: $@.1 | sed 's/^ *//' > $@.3
	paste $@.2 $@.3 | sort -k1,1 -u > $@.languagepairs
	join -t'	' -e unknown -a1 -a2 -o 0,1.2,2.2 $@.releases $@.alignments > $@.1
	join -t'	' -e unknown -a1 -a2 -o 0,1.2,1.3,2.2 $@.1 $@.sentences > $@.2
	join -t'	' -e unknown -a1 -a2 -o 0,1.2,1.3,1.4,2.2 $@.2 $@.tokens > $@.3
	join -t'	' -e unknown -a1 -a2 -o 0,1.2,1.3,1.4,1.5,2.2 $@.3 $@.languages > $@.4
	join -t'	' -e unknown -a1 -a2 -o 0,1.2,1.3,1.4,1.5,1.6,2.2 $@.4 $@.languagepairs > $@.5
	join -t'	' -e unknown -a1 -a2 -o 0,1.2,1.3,1.4,1.5,1.6,1.7,2.2 $@.5 $@.license > $@.6
	echo 'name	release	release date	alignments	sentences	tokens	languages	language pairs	license' > $@
	sed 's#\([^/]*\)/#\1	#' < $@.6 >> $@
	rm -f $@.*

info/RELEASE_LICENSES.tsv: info/RELEASES.tsv
	head -1 $< > $@
	tail -n +2 $< | sort -t'	' -k4,4 >> $@

info/RELEASE_HISTORY.tsv: info/RELEASES.tsv
	head -1 $< > $@
	tail -n +2 $< | sort -t'	' -k3,3r >> $@

info/RELEASE_SIZE.tsv: info/RELEASES.tsv
	head -1 $< > $@
	tail -n +2 $< | sort -t'	' -k5,5nr -k6,6nr -k7,7nr >> $@

info/RELEASE_NR_OF_LANGUAGES.tsv: info/RELEASES.tsv
	head -1 $< > $@
	tail -n +2 $< | sort -t'	' -k8,8nr -k9,9nr >> $@


info/RELEASES.md: corpus
	echo "# List of corpus releases" >$@
	echo "" >> $@
	echo "* [list of releases without ELRC](RELEASES-without-ELRC.md)" >> $@
	echo "" >> $@
	echo "| corpus | releases | " >> $@
	echo "|--------|----------| " >> $@
	for c in `find corpus -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort`; do \
	  if [ -e corpus/$$c/info.yaml ]; then \
	    w=`grep '^website:' corpus/$$c/info.yaml | cut -f2 -d' '`; \
	    echo -n "| [$$c]($$w) | " >> $@; \
	  else \
	    echo -n "| $$c | " >> $@; \
	  fi; \
	  for v in `find corpus/$$c -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort`; do \
	    echo -n "[$$v](${URLBASE}/$$c/$$v) " >> $@; \
	  done; \
	  echo " |" >> $@; \
	done


info/RELEASES-without-ELRC.md: corpus
	echo "# List of corpus releases (without ELRC)" >$@
	echo "" >> $@
	echo "* [complete list of releases](RELEASES.md)" >> $@
	echo "" >> $@
	echo "| corpus | releases | " >> $@
	echo "|--------|----------| " >> $@
	for c in `find corpus -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -v ELRC | grep -v ELRA | sort`; do \
	  if [ -e corpus/$$c/info.yaml ]; then \
	    w=`grep '^website:' corpus/$$c/info.yaml | cut -f2 -d' '`; \
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
