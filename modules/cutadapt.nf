process CUTADAPT {
    publishDir "${params.output}/trimmed", mode: 'copy'

    input:
    path reads

    output:
    path "trimmed.fastq.gz"

    script:
    """
    ${params.cutadapt_bin} -o trimmed.fastq.gz ${reads}
    """
}
