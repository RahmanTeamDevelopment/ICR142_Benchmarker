packrat::on()
source("helper.R")

suppressPackageStartupMessages(library(magrittr, quietly = TRUE, warn.conflicts=FALSE))
suppressPackageStartupMessages(library(officer, quietly = TRUE, warn.conflicts=FALSE))



# Generate Report.docx file which reports of the method’s performance on the ICR142 dataset, constructed from the Summary.txt and FullResults.txt files 
generate_report <- function(output_dir, submitter){

  cat ("\n --- Generating word report ...\n")
  folder_path <- output_dir
  PerformanceSummary <- read.table(paste(folder_path, "/", "Summary.txt", sep = ""), sep = "\t", hea = T, stringsAsFactors = F)
  FullResults <- read.table(paste(folder_path, "/", "FullResults.txt", sep = ""), sep = "\t", hea = T, stringsAsFactors = F)
  data_col <- 3 
  
  A <- as.character(length(which(FullResults$Group == 'A'&FullResults$ConcordantFinalResult == "no")))
  B <- as.character(length(which(FullResults$Group == 'B'&FullResults$ConcordantFinalResult == "no")))
  
  col_final <- 14
  miss_variants <- as.character(length(which(FullResults$SangerCall!="No"&FullResults[, col_final] == '.')))
  miss_negative <- as.character(length(which(FullResults$SangerCall=="No"&FullResults[, col_final] == '.')))
  miss_samples <- as.character(length(unique(FullResults$Sample[FullResults[, col_final] == '.'])))
  
  
  doc = read_docx( path = 'data/Template_with_Bookmarks_ICR142_Report.docx' ) 
  doc<-doc %>%  
    body_replace_text_at_bkm("Submitter", submitter) %>%
    
    body_replace_text_at_bkm("O_sens", geti(PerformanceSummary[1, data_col])) %>%
    body_replace_text_at_bkm("O_spec", geti(PerformanceSummary[5, data_col])) %>%
    body_replace_text_at_bkm("O_fdr", geti(PerformanceSummary[9, data_col])) %>%
    
    body_replace_text_at_bkm("I_sens", geti(PerformanceSummary[3, data_col])) %>%
    body_replace_text_at_bkm("I_spec", geti(PerformanceSummary[7, data_col])) %>%
    body_replace_text_at_bkm("I_fdr", geti(PerformanceSummary[11, data_col])) %>%
    
    body_replace_text_at_bkm("B_sens", geti(PerformanceSummary[2, data_col])) %>%
    body_replace_text_at_bkm("B_spec", geti(PerformanceSummary[6, data_col])) %>%
    body_replace_text_at_bkm("B_fdr", geti(PerformanceSummary[10, data_col])) %>%
    
    body_replace_text_at_bkm("A", A) %>%
    body_replace_text_at_bkm("B", B) %>%
    
    body_replace_text_at_bkm("miss_variants", miss_variants) %>%
    body_replace_text_at_bkm("miss_negative", miss_negative) %>%
    body_replace_text_at_bkm("miss_samples", miss_samples) %>%

    body_replace_text_at_bkm("Date", as.character(Sys.Date())) 
  
  
  print(doc, target = paste(folder_path, "Report.docx", sep="/"))
}

