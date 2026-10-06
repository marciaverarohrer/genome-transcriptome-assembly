# genome-transcriptome-assembly
A de-novo genome assembly with data of Arabidopsis Thaliana is performed with the Kar-1 accession.

After QC four types of assemblies are performed:
flye, hifiasm and LJA on PacBio HiFi whole genome sequences (WGS) as well as Trinity on transcriptome Illumina RNA-Seq data.

Further the quality of the assemblies is evaluated using BUSCO, QUAST, merqury.

The assembled genomes from flye, hifiasm and LJA are compared against the Arabidopsis thaliana reference and against each other using nucmer and mummer.

Structure of the repository:
/scripts : containing 10 bash scripts used for the practical part
/QC : folder for fastQC and jellyfish output results (contains 3 .html files from fastQC and one reads.histo file from jellyfish)
README.md as well as a more detailed step-by-step documentation step_by_step.md.
