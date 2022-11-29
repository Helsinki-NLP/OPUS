

URLBASE = https://github.com/Helsinki-NLP/OPUS/blob/main/corpus

all: corpus/releases.md corpus/releases-no-elrc.md corpus/releases-elrc.md


corpus/releases.md:
	echo "# List of corpus releases" >$@
	echo "" >> $@
	echo "| corpus | releases | " >> $@
	echo "|--------|----------| " >> $@
	for c in `find corpus -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort`; do \
	  if [ -e corpus/$$c/$$v/info.yaml ]; then \
	    w=`grep website corpus/$$c/$$v/info.yaml | cut -f2 -d' '`; \
	    echo -n "| [$$c]($$w) | " >> $@; \
	  else \
	    echo -n "| $$c | " >> $@; \
	  fi; \
	  for v in `find corpus/$$c -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort`; do \
	    echo -n "[$$v](${URLBASE}/$$c/$$v) " >> $@; \
	  done; \
	  echo " |" >> $@; \
	done


corpus/releases-no-elrc.md:
	echo "# List of corpus releases (without ELRC)" >$@
	echo "" >> $@
	echo "| corpus | releases | " >> $@
	echo "|--------|----------| " >> $@
	for c in `find corpus -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -v ELRC | grep -v ELRA | sort`; do \
	  if [ -e corpus/$$c/$$v/info.yaml ]; then \
	    w=`grep website corpus/$$c/$$v/info.yaml | cut -f2 -d' '`; \
	    echo -n "| [$$c]($$w) | " >> $@; \
	  else \
	    echo -n "| $$c | " >> $@; \
	  fi; \
	  for v in `find corpus/$$c -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort`; do \
	    echo -n "[$$v](${URLBASE}/$$c/$$v) " >> $@; \
	  done; \
	  echo " |" >> $@; \
	done

corpus/releases-elrc.md:
	echo "# List of corpus releases (without ELRC)" >$@
	echo "" >> $@
	echo "| corpus | releases | " >> $@
	echo "|--------|----------| " >> $@
	for c in `find corpus -maxdepth 1 -mindepth 1 -type d -name 'ELRC*' -printf "%f\n" | sort`; do \
	  if [ -e corpus/$$c/$$v/info.yaml ]; then \
	    w=`grep website corpus/$$c/$$v/info.yaml | cut -f2 -d' '`; \
	    echo -n "| [$$c]($$w) | " >> $@; \
	  else \
	    echo -n "| $$c | " >> $@; \
	  fi; \
	  for v in `find corpus/$$c -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort`; do \
	    echo -n "[$$v](${URLBASE}/$$c/$$v) " >> $@; \
	  done; \
	  echo " |" >> $@; \
	done
