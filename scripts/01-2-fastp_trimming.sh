Perform k-mer counting

Exercise: Go to http://genomescope.org/genomescope2.0/, and follow their suggestions on counting k-mers (jellyfish count) and creating a histogram (jellyfish histo). Other than what is suggested on the genomescope website, you can use the options -s 5G (hash of 5Gb, be aware to specify at least 40 Gb of memory) and -t 4 (4 threads). The other options you can keep the same as suggested on the website. Again, submit the commands from within a script using sbatch.

jellyfish count only accepts uncompressed input

Your fastq files are compressed (i.e. ending with fastq.gz). jellyfish can not read those directly, but you can provide the files with process substitution of zcat, i.e.:

jellyfish count \
[OPTIONS] \
<(zcat myreads.fastq.gz) \
<(zcat myotherreads.fastq.gz)

