nextflow.enable.dsl=2

// Parameters
params.input = "$projectDir/data"
params.outdir = "$projectDir/results"

// Print pipeline info
log.info """\
    ================================================
         NGS QUALITY CONTROL PIPELINE - NEXTFLOW
    ================================================
    Input directory  : ${params.input}
    Output directory : ${params.outdir}
    ================================================
    """
    .stripIndent()

// Include modules
include { FASTQC as FASTQC_RAW } from './modules/fastqc.nf'
include { CUTADAPT } from './modules/cutadapt.nf'
include { FASTQC as FASTQC_TRIMMED } from './modules/fastqc.nf'

// Main workflow
workflow {
    // Create input channel from FASTQ files
    Channel
        .fromFilePairs("${params.input}/SRR390728_{1,2}.fastq", size: 2)
        .set { read_pairs_ch }
    
    // Step 1: FastQC on raw reads
    FASTQC_RAW(read_pairs_ch, '1_fastqc_raw')
    
    // Step 2: Cutadapt trimming
    CUTADAPT(read_pairs_ch)
    
    // Step 3: FastQC on trimmed reads
    FASTQC_TRIMMED(CUTADAPT.out, '3_fastqc_trimmed')
}

workflow.onComplete {
    log.info """\
    ================================================
    Pipeline completed!
    Status: ${workflow.success ? 'SUCCESS' : 'FAILED'}
    Results: ${params.outdir}
    ================================================
    """
    .stripIndent()
}
