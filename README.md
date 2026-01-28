# Automated Pipeline for NGS Data

A streamlined Nextflow-based solution for identifying genetic variants from paired-end sequencing reads through quality control, alignment, and variant discovery.

## Pipeline Workflow

```text
Input FASTQ files (data/*_{1,2}.fastq.gz)
        ↓
   FASTQC_RAW (Quality Control)
        ↓
    CUTADAPT (Adapter Trimming)
        ↓
  FASTQC_TRIM (Post-trim QC)
        ↓
   BWA_ALIGN (Read Alignment)
        ↓
  SAM_TO_BAM (Format Conversion)
        ↓
   SORT_BAM (BAM Sorting)
        ↓
VARIANT_CALLING (Call Variants)
        ↓
FILTER_VARIANTS (Filter Quality Variants)
        ↓
Final VCF files (results/8_filtered/)
```

## Overview

This pipeline transforms raw sequencing data into high-confidence variant calls through an eight-stage processing workflow:

1. **Initial QC (FastQC)** - Evaluate raw read quality and detect potential issues in sequencing data

2. **Read Cleaning (Cutadapt)** - Trim adapter sequences and remove poor-quality bases from read ends

3. **QC Verification (FastQC)** - Confirm successful trimming and assess improved data quality

4. **Genome Mapping (BWA-MEM)** - Align processed reads to a reference genome assembly

5. **File Conversion (Samtools)** - Transform alignments from SAM to space-efficient BAM format

6. **Coordinate Sorting (Samtools)** - Organize aligned reads by genomic position

7. **Variant Discovery (BCFtools)** - Detect single nucleotide polymorphisms (SNPs) and insertions/deletions (indels)

8. **Quality Filtering (BCFtools)** - Retain only variants meeting quality thresholds

## Key Features

* **End-to-end automation** from raw reads to filtered variants
* **Multi-sample support** with parallel execution
* **Quality metrics** generated at each step
* **Standardized output formats** (BAM, VCF)
* **Cross-platform compatibility**
* **Environment management** via Conda

## Purpose

Sequencing instruments produce raw data that contains errors and technical artifacts. This pipeline addresses these challenges by:
- Identifying and removing low-quality sequences
- Accurately mapping reads to their genomic origins
- Distinguishing true genetic variations from sequencing errors
- Delivering ready-to-analyze variant files for research applications

