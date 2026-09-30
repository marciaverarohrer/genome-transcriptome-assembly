#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=04:00:00
#SBATCH --job-name=nucmer_mummerplot
#SBATCH --mail-user=marcia.rohrer@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mrohrer/assembly_annotation_course/comparison/logs/output_nucmer_%j.o
#SBATCH --error=/data/users/mrohrer/assembly_annotation_course/comparison/logs/error_nucmer_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mrohrer/assembly_annotation_course
REFDIR=/data/courses/assembly-annotation-course/references
REF=$REFDIR/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa

OUTDIR=$WORKDIR/evaluation/nucmer
mkdir -p $OUTDIR
cd $OUTDIR

FLYE=$WORKDIR/assembly/flye/assembly.fasta
HIFIASM=$WORKDIR/assembly/hifiasm/Kar-1.p_ctg.fa
LJA=$WORKDIR/assembly/LJA/assembly.fasta

SIF=/containers/apptainer/mummer4_gnuplot.sif

run_nucmer_plot () {
    local ref=$1
    local query=$2
    local prefix=$3

    apptainer exec --bind /data $SIF \
    nucmer --prefix=$prefix \
    --breaklen 1000 \
    --mincluster 1000 \
    $ref $query

    apptainer exec --bind /data $SIF \
    mummerplot \
    -R $ref -Q $query \
    --filter \
    -t png \
    --large \
    --layout \
    --fat \
    -p $prefix \
    $prefix.delta
}

# Each assembly vs. reference
run_nucmer_plot $REF $FLYE     flye_vs_ref
run_nucmer_plot $REF $HIFIASM  hifiasm_vs_ref
run_nucmer_plot $REF $LJA      LJA_vs_ref

# Pairwise assembly comparisons
run_nucmer_plot $FLYE $HIFIASM flye_vs_hifiasm
run_nucmer_plot $FLYE $LJA     flye_vs_LJA
run_nucmer_plot $HIFIASM $LJA  hifiasm_vs_LJA