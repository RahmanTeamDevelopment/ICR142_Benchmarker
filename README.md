
# ICR142_Benchmarking


## Introduction
An easy to use tool for understanding variant caller performance using the ICR142 NGS validation series. 
ICR142_Benchmarking reports a series of informative metrics with increasing levels of detail from overall calling performance to per site profiles and a one page report summarising both standalone performance and performance in the context of existing best practice. 

## Quick start
- Clone the repo: `git clone https://github.com/RahmanTeamDevelopment/ICR142_Benchmarking.git`
- Go to main directory: `cd ICR142_Benchmarking`
- Install with: `./setup.sh`

## Installation
ICR142_Benchmarking implements strict version control over all packages and dependencies used by changing the local default R settings. Any R session launched from the same directory as ICR142_Benchmarking will have these settings, therefore it is strongly recommended to install ICR142_Benchmarking to a new directory containing only ICR142_Benchmarking.
setup.sh downloads and installs all required packages and dependencies, automatically creating a setup.log file.

## Running ICR142_Benchmarking
Run the following command from the directory containing the ICR142_Benchmarking scripts:
`./ICR142_Benchmarking --input _input.txt_ --method_name *method_name* --output *path_to_output_directory*`

## License
Code released under the [MIT License] (https://github.com/RahmanTeamDevelopment/ICR142_Benchmarking/blob/master/LICENSE).
