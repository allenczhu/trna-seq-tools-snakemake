'''
Author: Allen Zhu
Affiliation: Meren Lab at the University of Chicago
Aim: A simple Snakemake workflow to automate the processing of database files into anvi-profiles.
Date: Wed Sep 27
Run: snakemake (-s Snakefile) 
'''

BASE_DIR = "/Users/allenzhu/Google\ Drive/\[Rotation_Meren-and-Pan\]/tRNA-profiles/"

SAMPLES = ['tRNA-DM-HF-M01', 'tRNA-DM-HF-M02', 'tRNA-DM-HF-M03', 'tRNA-DM-HF-M01', 'tRNA-DM-HF-M02', 'tRNA-DM-HF-M03',\
           'tRNA-HF-M01', 'tRNA-HF-M02', 'tRNA-HF-M03', 'tRNA-LF-M01', 'tRNA-LF-M02', 'tRNA-LF-M03']

# tRNA-seq-tools needs to be installed in order to use this snakemake file.
TRNA_SEQ_TOOLS_ACTIVATE_PATH = '~/virtual-envs/tRNA-seq-tools/bin/activate'

# Activate tRNA-seq-tools
print('First, activating tRNA-seq-tools.')
#shell: 'echo "snakemake"'
#shell: "trna-seq-tools-activate"

print(expand("hello_{sample}", sample=SAMPLES))

# Rules

rule all:
    input:
        expand('workflow_snakemake/full_length_reads_{sample}.fa', sample=SAMPLES),
        expand('workflow_snakemake/all_reads_{sample}.fa', sample=SAMPLES)

rule db_to_full_length_fasta:
    input:
        'tRNA-db-profiles/{sample}.db'
    output:
        full_length_fasta = 'workflow_snakemake/full_length_reads_{sample}.fa',    
        all_read_fasta = 'workflow_snakemake/all_reads_{sample}.fa'
    shell:
        'trna-get-sequences -p {input} -o {output.full_length_fasta} --full-length-only; trna-get-sequences -p {input} -o {output.all_read_fasta}'
'''
rule db_to_all_read_fasta:
    input:
        'tRNA-db-profiles/{sample}.db'
    output:
        full_length_fasta = 'workflow_snakemake/full_length_reads_{sample}.fa',    
        #all_read_fasta = 'workflow_snakemake/all_reads_{sample}.fa'
    shell:
        'touch filenamehere.log'
        'echo {input} > {output.full_length_fasta}'
'''