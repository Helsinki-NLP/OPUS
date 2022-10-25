# OPUS
The Open Parallel Corpus


* website: http://opus.nlpl.eu
* contact: jorg.tiedemann@helsinki.fi


This directory contains information about the released parallel corpora and derived data
sets in OPUS, the open collection of parallel corpora. Each sub-directory in `corpus/`
corresponds to one specific resource with released versions and data sets
according to the following format:


~~~
corpus/name/vX ........... corpus release with version <vX>
corpus/name/vX/raw ....... untokenized XML files
corpus/name/vX/xml ....... tokenized XML files (possibly more annotation)
~~~

There are various data files that are derived from the core data sets.

~~~
corpus/name/vX/moses ..... plain text files for each bitext (Moses format)
corpus/name/vX/tmx ....... translation memory exchange format for each bitext
corpus/name/vX/parsed .... parsed corpora in XML (not all data sets are parsed)
corpus/name/vX/dic ....... a rough dictionary extracted from word alignment
corpus/name/vX/mono ...... monolingual plain text files for each language
corpus/name/vX/freq ...... token frequency lists
corpus/name/vX/smt ....... word alignments and extracted phrase translation tables
~~~


## Citing

Please, cite the following [LREC 2012 paper](https://aclanthology.org/L12-1246/) when using OPUS
and also acknowledge corpus-specific references as specified in the resource-specific information and documentation!

```bibtex
@InProceedings{TIEDEMANN12.463,
  author = {Jörg Tiedemann},
  title = {Parallel Data, Tools and Interfaces in {OPUS}},
  booktitle = {Proceedings of the Eight International Conference on Language Resources and Evaluation (LREC'12)},
  year = {2012},
  month = {may},
  date = {23-25},
  address = {Istanbul, Turkey},
  publisher = {European Language Resources Association (ELRA)},
  isbn = {978-2-9517408-7-7},
}
```

