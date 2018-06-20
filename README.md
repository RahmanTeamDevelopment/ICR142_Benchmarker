
# ICR142_Benchmarking

## Introduction
An easy to use tool for understanding variant caller performance using the ICR142 NGS validation series. 
ICR142_Benchmarking reports a series of informative metrics with increasing levels of detail from overall calling performance to per site profiles and a one page report summarising both standalone performance and performance in the context of existing best practice. 


## Prerequisites
ICR142_Benchmarking is available for Linux, implemented in R and requires:
1) R version 3.1.2 
2) A capacity to build packages from source (requires gcc and gfortran compilers).

## Installation
ICR142_Benchmarking implements strict version control over all packages and dependencies used by changing the local default R settings. Any R session launched from the same directory as ICR142_Benchmarking will have these settings, therefore it is strongly recommended to install ICR142_Benchmarking to a new directory containing only ICR142_Benchmarking.

- Clone the repo: `git clone https://github.com/RahmanTeamDevelopment/ICR142_Benchmarking.git`
- Go to main directory: `cd ICR142_Benchmarking`
- Install with: `./setup.sh`
setup.sh downloads and installs all required packages and dependencies, automatically creating a setup.log file.

## Running ICR142_Benchmarking
Once ICR142_Benchmarking has been downloaded and installed, run the following command from the directory containing the ICR142_Benchmarking scripts:\
**./ICR142_Benchmarking**   **--input** *input.txt*   **--method_name** *method_name*   [**--output** *path_to_output_directory*]

## Input
- **INPUT** file - path to tab separated input file containing:\
Header with SampleID and Location columns \
Data with:
  1. Sample IDs (same name and format as seen in [Sanger validation information](https://github.com/RahmanTeamDevelopment/ICR142_Benchmarking/blob/master/data/SupportingFile1_20180612.txt))
  1. Paths to 142 VCF v4.X files

SampleID | Location
------------ | -------------
D129031 | path/to/D129031.vcf
L81899 | path/to/L81899.vcf
... | ...

- **METHOD** - one word variant caller identifier (can be delimiter-separated)
- **OUTPUT** - path to exitsting or new folder in which outputs will be created. By default "Output_ICR142_Analysis" folder will be created in the main ICR142_Benchmarking directory.

## Output
ICR142_Benchmarking generates the following files:
- **Summary.txt** - provides summary performance metrics for the evaluated method, specifically the overall sensitivity, specificity and FDR values and the same three metrics calculated for only base substitutions and only indels.
- **FullResults.txt** - tab separated file containing all of the Sanger validation information from the ICR142 dataset and information on the method’s performance at each of the 704 sites.
- **FalsePositives.txt** - relevant lines of the VCF files for false positive variant calls.
- **TruePositives.txt** - relevant lines of the VCF files for true positive variant calls.
- **Report.docx** - Word document providing a clear variant calling analysis report of the method’s performance on the ICR142 dataset.
Key points from the detailed outputs are highlighted to the user, including information about the method’s performance in the context of existing best practice.
\
:information_source: Detailed description of all columns in the .txt files is provided in the ColumnHeaders.txt supporting file. 


## License
Code released under the [MIT License](https://github.com/RahmanTeamDevelopment/ICR142_Benchmarking/blob/master/LICENSE).

## Links
