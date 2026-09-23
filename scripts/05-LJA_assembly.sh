#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=LJA_assembly
#SBATCH --mail-user=marcia.rohrer@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mrohrer/assembly_annotation_course/assembly/logs/output_LJA_%j.o
#SBATCH --error=/data/users/mrohrer/assembly_annotation_course/assembly/logs/error_LJA_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mrohrer/assembly_annotation_course
OUTDIR=$WORKDIR/assembly/LJA

apptainer exec \
--bind /data \
/containers/apptainer/lja-0.2.sif \
lja \
-o $OUTDIR \
--reads $WORKDIR/Kar-1/ERR11437325.fastq.gz \
--diploid \
-t 16