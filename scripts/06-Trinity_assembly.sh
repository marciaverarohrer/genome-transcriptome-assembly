#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=Trinity_assembly
#SBATCH --mail-user=marcia.rohrer@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mrohrer/assembly_annotation_course/assembly/logs/output_Trinity_%j.o
#SBATCH --error=/data/users/mrohrer/assembly_annotation_course/assembly/logs/error_Trinity_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mrohrer/assembly_annotation_course
OUTDIR=$WORKDIR/assembly/Trinity

mkdir -p $OUTDIR


module load Trinity/2.15.1-foss-2021a   # from 'module avail trinity'

Trinity \
--seqType fq \
--max_memory 64G \
--left $WORKDIR/RNAseq_Sha/ERR754081_1.fastq.gz \
--right $WORKDIR/RNAseq_Sha/ERR754081_2.fastq.gz \
--CPU 16 \
--output $OUTDIR/trinity_out