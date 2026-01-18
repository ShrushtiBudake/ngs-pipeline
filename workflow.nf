include { FASTQC as FASTQC_RAW } from './modules/fastqc.nf'
include { CUTADAPT } from './modules/cutadapt.nf'
include { FASTQC as FASTQC_TRIMMED } from './modules/fastqc.nf'
include { BWA_ALIGN } from './modules/bwa_align.nf'
include { SAM_TO_BAM } from './modules/sam_to_bam.nf'
include { SORT_BAM } from './modules/sort_bam.nf'
include { VARIANT_CALLING } from './modules/variant_calling.nf'

workflow QC_PIPELINE {
    
    // 1. Input reads channel
    read_pairs_ch = channel.fromFilePairs("${params.input}/SRR390728_{1,2}.fastq", size: 2, checkIfExists: true)
    
    // Create genome channel
    genome_ch = Channel.fromPath(params.genome).collect()
    
    // 2. Initial QC on raw reads
    FASTQC_RAW(read_pairs_ch, '1_fastqc_raw')
    
    // 3. Trim adapters and filter quality
    CUTADAPT(read_pairs_ch)
    
    // 4. Final QC on the trimmed data produced by Cutadapt
    FASTQC_TRIMMED(CUTADAPT.out.trimmed_reads, '3_fastqc_trimmed')

    // 5. Alignment (Mapping)
    BWA_ALIGN(CUTADAPT.out.trimmed_reads, genome_ch)

    // 6. File Conversion
    SAM_TO_BAM(BWA_ALIGN.out.sam)

    // 7. Sorting BAM file
    SORT_BAM(SAM_TO_BAM.out.bam)

    // 8. Variant calling 
    VARIANT_CALLING(SORT_BAM.out.sorted_bam, genome_ch)
}