## File: FullResults.txt	
Column_name | Description
----------- | -----------
Sample |sample name in the [ICR142 series](https://github.com/RahmanTeamDevelopment/ICR142_Benchmarking/blob/master/data/ICR142_Validation_Table.txt)
Gene | [HGNC symbol](https://www.genenames.org/) 
SangerCall | the most 3' representation annotated with [CSN](https://genomemedicine.biomedcentral.com/articles/10.1186/s13073-015-0195-6)
Type | `bs`, `del`, `ins`, `complex` or `indel` for _base substitutions_, _simple deletions_, _simple insertions_, _complex indels_, or _negative indel_ sites, respectively
Transcript | the ENST ID from Ensembl v65 used to annotate the Sanger call
CHR | chromosome
EvaluatedPosition | evaluated hg19 site position, centre of designed amplicon
POS | the left-aligned position in hg19 coordinates for variants
REF | the reference allele in hg19 for variants
ALT | the alternative allele in hg19 for variants
Zygosity | `homozygous` or `heterozygous` for variants based on Sanger call
SiteID | numeric ID within the [ICR142 series](https://github.com/RahmanTeamDevelopment/ICR142_Benchmarking/blob/master/data/ICR142_Validation_Table.txt)
Group | `A`, `B` or `.` see [below](#groupdescriptions)
<Method_name> | `.` if there is a missing genotype, `0` if site is not called in the submitted call set, `1` if a base substitution is called when Type = _bs_, or integer value `X` if X indels are called when Type = _del_, _ins_, _complex_, or _indel_
ConcordantFinalResult | `no` if either SangerCall is _No_ and method_name is _>0_ or SangerCall is not _No_ and method_name is _0_ or ., `yes` if SangerCall and method_name are concordant
ExactFinalMatch | `yes` if _CHR_, _POS_, _REF_, and _ALT_ all match when SangerCall is not _No_, `no` if _CHR_, _POS_, _REF_, and _ALT_ do not match when SangerCall is not _No_, `.` if there is a missing genotype

### GroupDescriptions
Total_number | Group | Description
------------ | ----- | -----------
387 | `A` | Detection of all Group `A` variants is expected. Failure to detect a Group `A` variant indicates substandard performance
261 | `B` | Avoidance of false positives at all Group `B` negative sites is expected. A false positive at a Group `B` negative site indicates substandard performance.


## File: TruePositives.txt
Column_name | Description
----------- | -----------
CHROM | from submitted VCF file
POS | from submitted VCF file
ID | from submitted VCF file
REF | from submitted VCF file
ALT | from submitted VCF file
QUAL | from submitted VCF file
FILTER | from submitted VCF file
INFO | from submitted VCF file
FORMAT | from submitted VCF file
SAMPLE | from submitted VCF file
SiteID | numeric ID within the [ICR142 series](https://github.com/RahmanTeamDevelopment/ICR142_Benchmarking/blob/master/data/ICR142_Validation_Table.txt)
Length | length of variant, `0` for Base substitutions, `>0` for indels 

## File: FalsePositives.txt
Column_name | Description
----------- | -----------
CHROM | from submitted VCF file
POS | from submitted VCF file
ID | from submitted VCF file
REF | from submitted VCF file
ALT | from submitted VCF file
QUAL | from submitted VCF file
FILTER | from submitted VCF file
INFO | from submitted VCF file
FORMAT | from submitted VCF file
SAMPLE | from submitted VCF file
SiteID | numeric ID within the [ICR142 series](https://github.com/RahmanTeamDevelopment/ICR142_Benchmarking/blob/master/data/ICR142_Validation_Table.txt)
Length | length of variant, `0` for Base substitutions, `>0` for indels 

