process BWA_ALIGN {
    tag "Mapping reads for ${sample_id}"

    publishDir "${params.output}/alignment", mode: 'copy'

    input:
    tuple val(sample_id), path(reads) 
    path genome                       

    output:
    tuple val(sample_id), path("${sample_id}.sam"), emit: sam

    script:
    """
    ${params.bwa_bin} mem ${genome} ${reads[0]} ${reads[1]} > ${sample_id}.sam
    
    """
}