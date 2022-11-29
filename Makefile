

URLBASE = https://github.com/Helsinki-NLP/OPUS/blob/main/corpus

corpora.md:
	echo "# List of OPUS corpora" >$@
	echo "" >> $@
	echo "| corpus name | website, corpus releases | " >> $@
	echo "|-------------|--------------------------| " >> $@
	for c in `find corpus -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort`; do \
	  w=`grep website corpus/$$c/$$v/info.yaml | cut -f2 -d' '`; \
	  echo -n "| [$$c](${URLBASE}/$$c) | [website]($$w)" >> $@; \
	  for v in `find corpus/$$c -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort`; do \
	    echo -n ", [$$v](${URLBASE}/$$c/$$v)" >> $@; \
	  done; \
	  echo " |" >> $@; \
	done
