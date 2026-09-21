#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=marcia.rohrer@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mrohrer/assembly_annotation_course/QC/logs/output_fastqc_%j.o
#SBATCH --error=/data/users/mrohrer/assembly_annotation_course/QC/logs/error_fastqc_%j.e
#SBATCH --partition=pshort_el8

WORKDIR=/data/users/mrohrer/assembly_annotation_course
OUTDIR=$WORKDIR/QC/fastQC

mkdir -p $OUTDIR

apptainer exec \
--bind /data \
/containers/apptainer/fastqc-0.12.1.sif \
fastqc \
--outdir $OUTDIR \
$WORKDIR/Kar-1/*.fastq.gz \
$WORKDIR/RNAseq_Sha/*.fastq.gz