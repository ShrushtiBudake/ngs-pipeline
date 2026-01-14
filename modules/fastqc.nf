process FASTQC {
   
    publishDir "${params.outdir}/${folder_name}", mode: 'copy'

    input:
    tuple val(sample_id), path(fastq)
    val folder_name

    output:
    path "*_fastqc.html"
    path "*_fastqc.zip"

    script:
    """
    ${params.fastqc_bin} ${fastq}
    """
}

