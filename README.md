# genome-transcriptome-assembly
A de-novo genome assembly with data of Arabidopsis Thaliana is performed with the Kar-1 accession.

After QC four types of assemblies are performed:
flye, hifiasm and LJA on PacBio HiFi whole genome sequences (WGS) as well as Trinity on transcriptome Illumina RNA-Seq data.

Further the quality of the assemblies is evaluated using BUSCO, QUAST, merqury.

The assembled genomes from flye, hifiasm and LJA are compared against the Arabidopsis thaliana reference and against each other using nucmer and mummer.

For the detailed step-by-step explanation look into the step_by_step.md.