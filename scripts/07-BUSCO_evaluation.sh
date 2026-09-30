#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=02:00:00
#SBATCH --job-name=busco_evaluation
#SBATCH --mail-user=marcia.rohrer@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mrohrer/assembly_annotation_course/evaluation/logs/output_busco_%j.o
#SBATCH --error=/data/users/mrohrer/assembly_annotation_course/evaluation/logs/error_busco_%j.e
#SBATCH --partition=pshort_el8


WORKDIR=/data/users/mrohrer/assembly_annotation_course
OUTDIR=$WORKDIR/evaluation

mkdir -p $OUTDIR

# running BUSCO on each of the four assemblies

# Genome assemblies (mode: geno)

apptainer exec --bind /data /containers/apptainer/busco_5.7.1.sif \
busco -i $WORKDIR/assembly/flye/assembly.fasta \
--mode geno \
--lineage_dataset brassicales_odb10 \
--cpu 16 \
--out flye_busco \
--out_path $OUTDIR \
--force

apptainer exec --bind /data /containers/apptainer/busco_5.7.1.sif \
busco -i $WORKDIR/assembly/hifiasm/Kar-1.p_ctg.fa \
--mode geno \
--lineage_dataset brassicales_odb10 \
--cpu 16 \
--out hifiasm_busco \
--out_path $OUTDIR \
--force

apptainer exec --bind /data /containers/apptainer/busco_5.7.1.sif \
busco -i $WORKDIR/assembly/LJA/assembly.fasta \
--mode geno \
--lineage_dataset brassicales_odb10 \
--cpu 16 \
--out LJA_busco \
--out_path $OUTDIR \
--force

# --- Transcriptome assembly (mode: tran) ---

apptainer exec --bind /data /containers/apptainer/busco_5.7.1.sif \
busco -i $WORKDIR/assembly/Trinity/trinity_out.Trinity.fasta \
--mode tran \
--lineage_dataset brassicales_odb10 \
--cpu 16 \
--out Trinity_busco \
--out_path $OUTDIR \
--force