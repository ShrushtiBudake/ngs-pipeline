process CUTADAPT {
    publishDir "${params.outdir}/trimmed", mode: 'copy'

    input:
   
    tuple val(sample_id), path(reads)

    output:
   
    path "trimmed_*.fastq.gz", emit: trimmed_reads

    script:
    """
    ${params.cutadapt_bin} -o trimmed_1.fastq.gz -p trimmed_2.fastq.gz ${reads[0]} ${reads[1]}
    """
}
