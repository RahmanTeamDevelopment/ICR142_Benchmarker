packrat::on()
suppressPackageStartupMessages(library(R.utils, quietly = TRUE, warn.conflicts=FALSE))
source("detections.R")
source("statistics.R")
source("helper.R")
source("word_report.R")

# Set version
version <- "v1.0.1"

# Print welcome message and start time ---------------------------
welcome_message(version)

# Load ICR142 NGS Validation table ---------------------------
icr142mat <- read_icr142()

# Read, check input arguments ---------------------------  
args = commandArgs(asValue = TRUE)
fkey_in <- args$input
submitter <- args$method_name
output_dir <- args$output
fkey <- check_args(fkey_in, icr142mat, submitter)

# Create output directory ---------------------------
if (is.null(output_dir)){
  output_dir <- file.path(getwd(), "Output_ICR142_Analysis")
}
dir.create(output_dir, showWarnings = FALSE)

# Populate per-site detection information and create TruePositive.txt, FalsePositive.txt ---------------------------
exact_match <- get_detected_matrix(icr142mat, fkey, output_dir, submitter)

# Calculate statistics and create Summary.txt, FullResults.txt ---------------------------
calculate_stats(icr142mat, output_dir, exact_match, submitter)

# Generate word report ---------------------------
generate_report(output_dir, submitter)

# Print goodbye message and end time ---------------------------
goodbye_message()

