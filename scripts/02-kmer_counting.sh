#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=70G
#SBATCH --time=02:00:00
#SBATCH --job-name=jellyfish_kmer
#SBATCH --mail-user=marcia.rohrer@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mrohrer/assembly_annotation_course/QC/logs/output_jellyfish_%j.o
#SBATCH --error=/data/users/mrohrer/assembly_annotation_course/QC/logs/error_jellyfish_%j.e
#SBATCH --partition=pshort_el8

WORKDIR=/data/users/mrohrer/assembly_annotation_course
OUTDIR=$WORKDIR/QC/jellyfish

mkdir -p $OUTDIR

apptainer exec \
--bind /data \
/containers/apptainer/jellyfish-2.2.6--0.sif \
jellyfish count \
-C \
-m 31 \
-s 5G \
-t 4 \
<(zcat $WORKDIR/Kar-1/ERR11437325.fastq.gz) \
-o $OUTDIR/reads.jf

apptainer exec \
--bind /data \
/containers/apptainer/jellyfish-2.2.6--0.sif \
jellyfish histo \
-t 4 \
$OUTDIR/reads.jf > $OUTDIR/reads.histo