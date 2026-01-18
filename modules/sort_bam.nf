process SORT_BAM {

     publishDir "${params.output}/alignment", mode: 'copy'

    input:
    tuple val(sample_id), path(bam_file)

    output:
    tuple val(sample_id), path("${sample_id}_sorted.bam"), emit: sorted_bam

    script:
    """
    ${params.samtools_bin} sort ${bam_file} -o ${sample_id}_sorted.bam
    """
}