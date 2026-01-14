process FASTQC {
    publishDir "${params.output}/1_fastqc_raw", mode: 'copy'

    input:
    path fastq

    output:
    path "*_fastqc.html"
    path "*_fastqc.zip"

    script:
    """
    ${params.fastqc_bin} ${fastq}
    """
}
