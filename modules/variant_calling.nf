process VARIANT_CALLING {

    publishDir "${params.output}/variants", mode: 'copy'

    input:
    tuple val(sample_id), path(sorted_bam)
    path genome

    output:
    tuple val(sample_id), path("${sample_id}.vcf"), emit: vcf

    script:
    """
    # mpileup looks at the stack of DNA; call finds the differences
    ${params.bcftools_bin} mpileup -f ${genome} ${sorted_bam} | \
    ${params.bcftools_bin} call -mv -Ob -o ${sample_id}.vcf
    """
}