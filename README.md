# OPUS

The Open Parallel Corpus


* website: http://opus.nlpl.eu
* github: https://github.com/Helsinki-NLP/OPUS
* contact: opus-project AT helsinki DOT fi


This directory contains information about the [released parallel corpora](RELEASES.md) and derived data
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
corpus/name/vX/mono ...... monolingual plain text files for each language
corpus/name/vX/freq ...... token frequency lists
corpus/name/vX/smt ....... word alignments and extracted phrase translation tables
corpus/name/vX/dic ....... a rough dictionary extracted from word alignment
~~~

## The OPUS ecosystem

Tools for finding and processing OPUS data sets:

* [OpusTools](https://github.com/Helsinki-NLP/OpusTools) - Python library and tools for accessing and processing OPUS data [[pypi](https://pypi.org/project/opustools/)]
* [OpusTools-perl](https://github.com/Helsinki-NLP/OpusTools-perl) - Perl scripts for processing OPUS data
* [OPUS-API](https://github.com/Helsinki-NLP/OPUS-API) - API for searching OPUS resources [[live API](https://opus.nlpl.eu/opusapi/)]
* [OpusFilter](https://github.com/Helsinki-NLP/OpusFilter) - a toolbox for filtering and compiling parallel corpora [[doc](https://helsinki-nlp.github.io/OpusFilter/)]


Managing OPUS:

* [OPUS-ingest](https://github.com/Helsinki-NLP/OPUS-ingest) - recipes for ingesting/importing data to OPUS
* [OPUS-website](https://github.com/Helsinki-NLP/OPUS-website) - OPUS website and corpus sample files
* [OPUS-admin](https://github.com/Helsinki-NLP/OPUS-admin) - scripts and recipes for admin tasks (restricted access)
* [OPUS-repository](https://opus-repository.ling.helsinki.fi) - experimental parallel data management system [[frontend](https://github.com/Helsinki-NLP/OPUS-interface)] [[backend](https://github.com/Helsinki-NLP/OPUS-repository)] [live demo](https://opus-repository.ling.helsinki.fi)
* [OPUS-ISA](https://github.com/Helsinki-NLP/OPUS-ISA) - experimental sentence alignment interface [[live demo](https://opus.nlpl.eu/isa/isa.php)]


Machine translation with OPUS-MT:

* [Opus-MT](https://github.com/Helsinki-NLP/Opus-MT) - OPUS-MT web service setup
* [OPUS-MT-train](https://github.com/Helsinki-NLP/OPUS-MT-train) - scripts and recipes for training OPUS-MT models
* [OPUS-translator](https://github.com/Helsinki-NLP/OPUS-translator) - OPUS-MT web interface [[live demo](https://translate.ling.helsinki.fi/)]
* [OPUS-MT-testsets](https://github.com/Helsinki-NLP/OPUS-MT-testsets) - a collection of MT benchmarks
* [OPUS-MT-leaderboard](https://github.com/Helsinki-NLP/OPUS-MT-leaderboard) - OPUS-MT evaluation scores and leaderboards [[live demo](https://opus.nlpl.eu/leaderboard/)]
* [OPUS-MT-map](https://github.com/Helsinki-NLP/OPUS-MT-map) - interactive map of OPUS-MT language coverage [[live demo](https://opus.nlpl.eu/NMT-map/Tatoeba-all/src2trg/index.html)]
* [OPUS-MT-app](https://github.com/Helsinki-NLP/OPUS-MT-app) - desktop app for local translation with OPUS-MT (fork of [translateLocally](https://github.com/XapaJIaMnu/translateLocally))
* [OPUS-CAT](https://github.com/Helsinki-NLP/OPUS-CAT) - OPUS-MT integration in CAT tools




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


## Links to other resources

* [mtdata](https://github.com/thammegowda/mtdata) - a library for retrieving MT datasets
* [LanguageCodes](https://github.com/Helsinki-NLP/LanguageCodes) - Perl modules for managing language codes
* [eflomal](https://github.com/robertostling/eflomal) - a tool for efficient word alignment with [pre-trained priors from OPUS](https://opus.nlpl.eu/eflomal-priors.html)
* [the Tatoeba translation challenge](https://github.com/Helsinki-NLP/Tatoeba-Challenge) - a comprehensive MT dataset compiled from OPUS and Tatoeba
* [wiki back-translations](https://github.com/Helsinki-NLP/Tatoeba-Challenge/blob/master/data/Backtranslations.md) - over a billion automatically translated sentences
* [OPUS-SPM](https://github.com/Helsinki-NLP/OPUS-MT-train/blob/master/tatoeba/SentencePieceModels.md) - pre-trained sentence piece models from OPUS data



## Acknowledgements

OPUS and related resources and tools have been partially supported by various projects such as

* [LetsMT!](http://project.letsmt.eu/) - A Platform for Online Sharing
of Training Data and Building User Tailored Machine Translation (EU ICT PSP)
* [MeMAD](https://memad.eu/) - Methods for Managing Audiovisual Data (EU Horizon 2020)
* [NLPL](https://wiki.neic.no/wiki/Nordic_language_processing_laboratory) - the Nordic Language Processing Laboritory (neic)
* [EOSC-nordic](https://www.eosc-nordic.eu/) - the European Open Science Cloud within the Nordic and Baltic countries (EU Horizon 2020)
* [ELG](https://live.european-language-grid.eu/catalogue/project/2866) - the European Language Grid (EU Horizon 2020)
* [FoTran](https://www.helsinki.fi/en/researchgroups/natural-language-understanding) - Found in Translation (EU ERC)
* [HPLT](https://hplt-project.org/) - High-Performance Language Technologies (EU Horizon)

OPUS is hosted by [CSC](https://www.csc.fi), the IT Center for Science in Finland, and heavily draws on the HPC resources provided by CSC. OPUS is also part of [NLPL](http://wiki.nlpl.eu), the Nordic Language Processing Laboratory. Last but not least, OPUS would not be possible without the various contributions from the community including aligned data sets and tools to create and process parallel corpora.