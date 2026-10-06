# steps documenting the workflow of the project

## data origin and obtaining data 
For this assembly course the data from the two papers mentioned below were fetched generating a soft link. They include:
- Whole genome PacBio HiFi reads for Kar-1 accession
- Whole transcriptome Illumina RNA-seq for accession Sha


Qichao Lian et al. A pan-genome of 69 Arabidopsis thaliana accessions reveals a conserved genome structure throughout the global species range. Nature Genetics. 2024;56:982-991. Available from: https://www.nature.com/articles/s41588-024-01715-9

Jiao WB, Schneeberger K. Chromosome-level assemblies of multiple Arabidopsis genomes reveal hotspots of rearrangements with altered evolutionary dynamics. Nature Communications. 2020;11:1–10. Available from: http://dx.doi.org/10.1038/s41467-020-14779-y

soft link generated with the following commands (username mrohrer and accession label Kar-1):
cd /data/users/mrohrer/assembly_annotation_course
ln -s /data/courses/assembly-annotation-course/raw_data/Kar-1 ./
ln -s /data/courses/assembly-annotation-course/raw_data/RNAseq_Sha ./

### sbatch commands displayed in this file run from the root of the directory


## FastQC - quality control
sbatch scripts/01-run_fastqc.sh
command for running the fastQC quality control, outputs to /QC/fastQC three .html files and three fastqc.zip files.
analyze quality using the .html files on a browser

## k-mer counting
sbatch scripts/02-kmer_counting.sh
command for running the kmer counting bash script, outputs in /QC/jellyfish a reads.histo and a reads.jf file.
With genome scope ( http://genomescope.org/genomescope2.0/ ) and the .histo file, several histograms were generated.
Outputs genome size, percentage of heterozygosity and coverage.
kmer size was set to 31, max kmer coverage ranged from -1 (default), 2000 to 2500. For final comparisons with other accessions the default -1 was used.
For downstream genome size estimations the obtained value with a max kmer coverage of 2000 was used (129,3 Mb) since this likely excludes organelle DNA. This was deducted from the logarithmized plot. 


## assembly

in a next step the following four assemblies are performed:
- Whole genome assembly using flye

generated script using help page, run the job with:
sbatch scripts/03-flye_assembly.sh
(falsely put the outputs into the QC/logs folder, changed manually afterwards and created new directory in /assembly/logs)

- Whole genome assembly using hifiasm
sbatch scripts/04-hifiasm_assembly.sh

- Whole genome assembly using LJA
sbatch scripts/05-LJA_assembly.sh
corrected for the --diploid flag, because LJA per default assumes a haploid organism

- Whole transcriptome assembly using Trinity
Trinity assembles transcript sequences from Illumina RNA-Seq data ( https://github.com/trinityrnaseq/trinityrnaseq/wiki ).
The RNAseq_Sha reads were used for Trinity as stated in the instructions
sbatch scripts/06-Trinity_assembly.sh

## assembly evaluation

for --help commands started interactive session with srun

and then ran with corresponding container, for example

apptainer exec --bind /data /containers/apptainer/quast_5.2.0.sif quast.py --help

using BUSCO:
sbatch scripts/07-BUSCO_evaluation.sh
using QUAST:
sbatch scripts/08-QUAST_evaluation.sh

using merqury:
The k-mer size for the Merqury meryl database was chosen with Merqury's best_k.sh, using the estimated genome size of 129.3 Mb (GenomeScope).
apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif \sh /usr/local/share/merqury/best_k.sh 129300000
Output returned k = 18.46 which was rounded to k = 18.
genome: 129300000
tolerable collision rate: 0.001
18.4552

sbatch scripts/09-merqury_evaluation.sh



## genome comparison
sbatch scripts/10-nucmer_mummer_plot.sh


## Tools & versions

| Step | Tool | Version | Container |
|---|---|---|---|
| QC | FastQC | 0.12.1 | `/containers/apptainer/fastqc-0.12.1.sif` |
| K-mer counting | Jellyfish | — | `/containers/apptainer/jellyfish-2.2.6--0.sif` |
| Genome profiling | GenomeScope2 | 2.0 | http://genomescope.org/genomescope2.0/ |
| Assembly | Flye | 2.9.5 | `/containers/apptainer/flye_2.9.5.sif` |
| Assembly | hifiasm | 0.25.0 | `/containers/apptainer/hifiasm_0.25.0.sif` |
| Assembly | LJA | 0.2 | `/containers/apptainer/lja-0.2.sif` |
| Assembly | Trinity | 2.15.1 | module (`Trinity/2.15.1-foss-2021a`) |
| Evaluation | BUSCO | 5.7.1 | `/containers/apptainer/busco_5.7.1.sif` |
| Evaluation | QUAST | 5.2.0 | `/containers/apptainer/quast_5.2.0.sif` |
| Evaluation | Merqury (incl. meryl) | 1.3 | `/containers/apptainer/merqury_1.3.sif` |
| Genome comparison | MUMmer (nucmer/mummerplot) | 4 | `/containers/apptainer/mummer4_gnuplot.sif` |

