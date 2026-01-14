include { FASTQC as FASTQC_RAW } from './modules/fastqc.nf'
include { CUTADAPT } from './modules/cutadapt.nf'
include { FASTQC as FASTQC_TRIMMED } from './modules/fastqc.nf'

workflow QC_PIPELINE {
    
    read_pairs_ch = channel.fromFilePairs("${params.input}/SRR390728_{1,2}.fastq", size: 2, checkIfExists: true)
    
    // 2. Initial QC on raw reads
    FASTQC_RAW(read_pairs_ch, '1_fastqc_raw')
    
    // 3. Trim adapters and filter quality
    CUTADAPT(read_pairs_ch)
    
    // 4. Final QC on the trimmed data produced by Cutadapt
    FASTQC_TRIMMED(CUTADAPT.out.trimmed_reads, '3_fastqc_trimmed')
}
