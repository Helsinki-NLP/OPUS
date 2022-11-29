

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
