#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=hifiasm_assembly
#SBATCH --mail-user=marcia.rohrer@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mrohrer/assembly_annotation_course/assembly/logs/output_hifiasm_%j.o
#SBATCH --error=/data/users/mrohrer/assembly_annotation_course/assembly/logs/error_hifiasm_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mrohrer/assembly_annotation_course
OUTDIR=$WORKDIR/assembly/hifiasm

mkdir -p $OUTDIR

apptainer exec \
--bind /data \
/containers/apptainer/hifiasm_0.25.0.sif \
hifiasm \
-o $OUTDIR/Kar-1 \
-t 16 \
$WORKDIR/Kar-1/ERR11437325.fastq.gz \
2> $OUTDIR/Kar-1.hifiasm.log

# Convert the primary contig GFA to FASTA
awk '/^S/{print ">"$2;print $3}' $OUTDIR/Kar-1.bp.p_ctg.gfa > $OUTDIR/Kar-1.p_ctg.fa