#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=02:00:00
#SBATCH --job-name=QUAST_evaluation
#SBATCH --mail-user=marcia.rohrer@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mrohrer/assembly_annotation_course/evaluation/logs/output_quast_%j.o
#SBATCH --error=/data/users/mrohrer/assembly_annotation_course/evaluation/logs/error_quast_%j.e
#SBATCH --partition=pshort_el8

WORKDIR=/data/users/mrohrer/assembly_annotation_course
REFDIR=/data/courses/assembly-annotation-course/references
OUTDIR=$WORKDIR/evaluation/quast

mkdir -p $OUTDIR/with_ref
mkdir -p $OUTDIR/no_ref

# --- Run 1: WITHOUT reference ---
apptainer exec --bind /data /containers/apptainer/quast_5.2.0.sif \
quast.py \
$WORKDIR/assembly/flye/assembly.fasta \
$WORKDIR/assembly/hifiasm/Kar-1.p_ctg.fa \
$WORKDIR/assembly/LJA/assembly.fasta \
--labels flye,hifiasm,LJA \
--eukaryote \
--est-ref-size 129300000 \
--threads 16 \
-o $OUTDIR/no_ref

# --- Run 2: WITH reference ---
apptainer exec --bind /data /containers/apptainer/quast_5.2.0.sif \
quast.py \
$WORKDIR/assembly/flye/assembly.fasta \
$WORKDIR/assembly/hifiasm/Kar-1.p_ctg.fa \
$WORKDIR/assembly/LJA/assembly.fasta \
--labels flye,hifiasm,LJA \
-r $REFDIR/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa \
--features $REFDIR/Arabidopsis_thaliana.TAIR10.57.gff3 \
--eukaryote \
--threads 16 \
-o $OUTDIR/with_ref