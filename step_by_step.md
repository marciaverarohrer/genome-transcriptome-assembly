# steps documenting the workflow of the project

## data origin and obtaining data 
For this assembly course the data from the two papers mentioned below were fetched with a soft link. They include:
- whole genome PacBio HiFi reads for Kar-1 accession
- Whole transcriptome Illumina RNA-seq for accession Sha

Qichao Lian et al. A pan-genome of 69 Arabidopsis thaliana accessions reveals a conserved genome structure throughout the global species range. Nature Genetics. 2024;56:982-991. Available from: https://www.nature.com/articles/s41588-024-01715-9

Jiao WB, Schneeberger K. Chromosome-level assemblies of multiple Arabidopsis genomes reveal hotspots of rearrangements with altered evolutionary dynamics. Nature Communications. 2020;11:1–10. Available from: http://dx.doi.org/10.1038/s41467-020-14779-y

## FastQC - quality control
sbatch scripts/01-run_fastqc.sh
command for running the fastQC quality control, outputs to /QC/fastQC three .html files and three fastqc.zip files.
analyze quality using the .html files on a browser

## k-mer counting
sbatch scripts/02-kmer_counting.sh
command for running the kmer counting bash script, outputs in /QC/jellyfish a reads.histo and a reads.jf file.
With genome scope ( http://genomescope.org/genomescope2.0/ ) and the .hist file, several histograms were generated.
Outputs genome size, percentage of heterozygousity and coverage.

result with max kmer coverage 2000:
http://genomescope.org/genomescope2.0/analysis.php?code=Y9Sj3Tk0M3A5sWStkDu9


## assembly

in a next step the following four assemblies are performed:
- Whole genome assembly using flye

generated script using help page, run the job with sbatch 03-flye_assembly.sh
(faultly put the outputs into the QC/logs folder, changed manually afterwards and created new directory in /assembly/logs)

- Whole genome assembly using hifiasm
run with sbatch 04-hifiasm_assembly.sh

- Whole genome assembly using LJA
run with sbatch 05-LJA_assembly.sh
corrected for the --diploid flag, because LJA per default assumes a haploid organism

- Whole transcriptome assembly using Trinity
Trinity assembles transcript sequences from Illumina RNA-Seq data ( https://github.com/trinityrnaseq/trinityrnaseq/wiki ).
The RNAseq_Sha reads were used for Trinity
run with sbatch 06-Trinity_assembly.sh

## assembly evaluation

using BUSCO:

using QUAST:

using merqury:

## genome comparison



