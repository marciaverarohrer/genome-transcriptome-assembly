#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=2:00:00
#SBATCH --job-name=merqury_eval
#SBATCH --mail-user=marcia.rohrer@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mrohrer/assembly_annotation_course/evaluation/logs/output_merqury_%j.o
#SBATCH --error=/data/users/mrohrer/assembly_annotation_course/evaluation/logs/error_merqury_%j.e
#SBATCH --partition=pshort_el8

WORKDIR=/data/users/mrohrer/assembly_annotation_course
OUTDIR=$WORKDIR/evaluation/merqury

mkdir -p $OUTDIR
cd $OUTDIR

export MERQURY="/usr/local/share/merqury"

# Build meryl k-mer database from HiFi reads (k=18, best k-mer size for A. thaliana found with best_k.sh)
apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif \
meryl k=18 count \
$WORKDIR/Kar-1/ERR11437325.fastq.gz \
output $OUTDIR/reads.meryl

# Run merqury on each assembly

apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif \
merqury.sh $OUTDIR/reads.meryl \
$WORKDIR/assembly/flye/assembly.fasta \
flye_merqury

apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif \
merqury.sh $OUTDIR/reads.meryl \
$WORKDIR/assembly/hifiasm/Kar-1.p_ctg.fa \
hifiasm_merqury

apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif \
merqury.sh $OUTDIR/reads.meryl \
$WORKDIR/assembly/LJA/assembly.fasta \
LJA_merqury