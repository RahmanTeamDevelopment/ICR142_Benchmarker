## File: FullResults.txt	
___

Column_name | Description
----------- | -----------
Sample |sample name in the ICR142 series
Gene | HGNC symbol
SangerCall | the most 3' representation annotated with CSN
Type | `bs`, `del`, `ins`, `complex` or `indel` for `base substitutions`, `simple deletions`, `simple insertions`, `complex indels`, or `negative indel` sites, respectively
Transcript | the ENST ID from Ensembl v65 used to annotate the Sanger call
CHR | chromosome
EvaluatedPosition | evaluated hg19 site position, centre of designed amplicon
POS | the left-aligned position in hg19 coordinates for variants
REF | the reference allele in hg19 for variants
ALT | the alternative allele in hg19 for variants
Zygosity | `homozygous` or `heterozygous` for variants based on Sanger call
SiteID | numeric ID within the ICR142 series
Group | `A`, `B` or `.` see [below](#groupdescriptions)
<Method_name> | `.` if there is a missing genotype, `0` if site is not called in the submitted call set, `1` if a base substitution is called when Type = `bs`, or integer value `X` if `X` indels are called when Type = `del`, `ins`, `complex`, or `indel`
ConcordantFinalResult | `no` if either SangerCall is `No` and `Method_name` is >0 or SangerCall is not `No` and `Method_name` is `0` or `.`, `yes` if SangerCall and `Method_name` are concordant
ExactFinalMatch | `yes` if `CHR`, `POS`, `REF`, and `ALT` all match when SangerCall is not `No`, `no` if `CHR`, `POS`, `REF`, and `ALT` do not match when SangerCall is not `No`, `.` if there is a missing genotype
	
File: TruePositives.txt	
CHROM	from submitted VCF file
POS	from submitted VCF file
ID	from submitted VCF file
REF	from submitted VCF file
ALT	from submitted VCF file
QUAL	from submitted VCF file
FILTER	from submitted VCF file
INFO	from submitted VCF file
FORMAT	from submitted VCF file
SAMPLE	from submitted VCF file
SiteID	numeric ID within the ICR142 series
Length	length of variant, 0 for Base substitutions, >0 for indels 

File: FalsePositives.txt	
CHROM	from submitted VCF file
POS	from submitted VCF file
ID	from submitted VCF file
REF	from submitted VCF file
ALT	from submitted VCF file
QUAL	from submitted VCF file
FILTER	from submitted VCF file
INFO	from submitted VCF file
FORMAT	from submitted VCF file
SAMPLE	from submitted VCF file
SiteID	numeric ID within the ICR142 series
Length	length of variant, 0 for Base substitutions, >0 for indels 
