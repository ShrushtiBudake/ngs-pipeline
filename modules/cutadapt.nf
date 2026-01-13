process CUTADAPT {
    tag "$sample_id"
    publishDir "${params.outdir}/2_trimmed", mode: 'copy'
    
    input:
    tuple val(sample_id), path(reads)
    
    output:
    tuple val(sample_id), path("*_trimmed*.fastq"), emit: trimmed_reads
    
    script:
    def (read1, read2) = reads
    """
    cutadapt -q 20 -m 20 \
        -o ${sample_id}_trimmed_R1.fastq \
        -p ${sample_id}_trimmed_R2.fastq \
        ${read1} ${read2}
    """
}