#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=flye_assembly
#SBATCH --mail-user=marcia.rohrer@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mrohrer/assembly_annotation_course/assembly/logs/output_flye_%j.o
#SBATCH --error=/data/users/mrohrer/assembly_annotation_course/assembly/logs/error_flye_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mrohrer/assembly_annotation_course
OUTDIR=$WORKDIR/assembly/flye

mkdir -p $OUTDIR

apptainer exec \
--bind /data \
/containers/apptainer/flye_2.9.5.sif \
flye \
--pacbio-hifi $WORKDIR/Kar-1/ERR11437325.fastq.gz \
--out-dir $OUTDIR \
--threads 16