# steps documenting the workflow of the project

## obtaining data and data origin 
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

## assembly

in a next step the following four assemblies are performed:
- Whole genome assembly using flye
- Whole genome assembly using hifiasm
- Whole genome assembly using LJA
- Whole transcriptome assembly using Trinity


