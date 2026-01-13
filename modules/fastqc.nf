process FASTQC {
    tag "$sample_id"
    publishDir "${params.outdir}/${folder_name}", mode: 'copy'

    input:
    tuple val(sample_id), path(reads)
    val folder_name 

    output:
    path "*.{html,zip}", emit: fastqc_results

    script:
    """
    fastqc -q ${reads}
    """
}