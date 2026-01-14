params.input = "$projectDir/data"
params.outdir = "$projectDir/results"


include { QC_PIPELINE } from './workflow.nf'

workflow {
    QC_PIPELINE()
}
