nextflow.enable.dsl=2

// Parameters
params.input = "$projectDir/data"
params.outdir = "$projectDir/results"

// Include modules
include { FASTQC as FASTQC_RAW } from './modules/fastqc.nf'
include { CUTADAPT } from './modules/cutadapt.nf'
include { FASTQC as FASTQC_TRIMMED } from './modules/fastqc.nf'

workflow {
    // Channel creation MUST be inside the workflow block
    read_pairs_ch = channel.fromFilePairs("${params.input}/SRR390728_{1,2}.fastq", size: 2, checkIfExists: true)
    
    // Step 1: FastQC on raw reads
    FASTQC_RAW(read_pairs_ch, '1_fastqc_raw')
    
    // Step 2: Cutadapt trimming
    CUTADAPT(read_pairs_ch)
    
    // Step 3: FastQC on trimmed reads
    // Using the 'trimmed_reads' output from the CUTADAPT process
    FASTQC_TRIMMED(CUTADAPT.out.trimmed_reads, '3_fastqc_trimmed')
}