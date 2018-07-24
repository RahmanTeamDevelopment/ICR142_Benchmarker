
# Assign whether a reult was concordant to the Sanger site or not
concordantVal <- function(sanger, method){
  isCon <- "check"
  if (is.na(method)) {
    isCon <- "NA" 
  } else if (method == '.') {
    isCon <- "."
  } else {
    if(sanger == "No" & method > 0) isCon <- "no"
    if(sanger != "No" & method == 0) isCon <- "no"
    if(sanger == "No" & method == 0) isCon <- "yes"
    if(sanger != "No" & method > 0) isCon <- "yes"
  }
  return (isCon)
}

# Calculate performance metrics and generate Summary.txt, FullResults.txt files ---------------------------
calculate_stats <- function(icr142mat, output_dir, ExactFinalMatch, submitter){
  
  cat ("\n --- Calculating statistics ... \n")
  # Load data generated from detections.R
  methods_mat <- read.table(file.path(output_dir, "NumberOfDetections.txt"), sep = "\t", hea = T, stringsAsFactors = F, colClasses = c("character")) #integer
  
  # Base substitutions senstitivity  
  true_pos_bs <- length(which(methods_mat == 1 & icr142mat$Type == "bs" & icr142mat$SangerCall != "No"))
  table_true_bs <- length(which(icr142mat$Type == "bs" & icr142mat$SangerCall != "No"))
  sens_bs <- paste(true_pos_bs, '/', table_true_bs," (", round((true_pos_bs / table_true_bs) * 100, digits = 0), '%', ")", sep = '')
  
  # Indels senstitivity 
  true_pos_indel <- length(which(methods_mat >= 1 & icr142mat$Type != "bs" & icr142mat$SangerCall != "No"))
  table_true_indel <- length(which(icr142mat$Type != "bs" & icr142mat$SangerCall != "No"))
  sens_indel <- paste(true_pos_indel, '/', table_true_indel, " (", round((true_pos_indel / table_true_indel) * 100, digits = 0), '%', ")", sep = '')
  
  # Overall senstitivity 
  sens_overall <- paste((true_pos_bs + true_pos_indel), '/', (table_true_bs + table_true_indel), " (", round(((true_pos_bs + true_pos_indel) / (table_true_bs + table_true_indel)) * 100, digits = 0), '%', ")", sep = '')
  
  # Base substitutions specificity  
  true_neg_bs <- length(which(methods_mat == 0 & icr142mat$Type == "bs" & icr142mat$SangerCall == "No"))
  table_neg_bs <- length(which(icr142mat$Type == "bs" & icr142mat$SangerCall == "No"))
  spec_bs <- paste(true_neg_bs, '/', table_neg_bs, " (", round((true_neg_bs / table_neg_bs) * 100, digits = 0), '%', ")", sep = '')
  
  # Indels specificity  
  true_neg_indel <- length(which(methods_mat == 0 & icr142mat$Type != "bs" & icr142mat$SangerCall == "No"))
  table_neg_indel <- length(which(icr142mat$Type != "bs" & icr142mat$SangerCall == "No"))
  spec_indel <- paste(true_neg_indel, '/', table_neg_indel, " (", round((true_neg_indel / table_neg_indel) * 100, digits = 0), '%', ")", sep = '')
  
  # Overall specificity 
  spec_overall <- paste((true_neg_bs + true_neg_indel), '/', (table_neg_bs + table_neg_indel), " (", round(((true_neg_bs + true_neg_indel) / (table_neg_bs + table_neg_indel)) * 100, digits = 0), '%', ")", sep = '')
  
  # Base substitutions false detection rate 
  false_pos_bs <- length(which(methods_mat == 1 & icr142mat$Type == "bs" & icr142mat$SangerCall == "No"))
  method_pos_bs <- length(which(methods_mat == 1 & icr142mat$Type == "bs"))
  fdr_bs <- paste(false_pos_bs, '/', method_pos_bs, " (", round((false_pos_bs / method_pos_bs) * 100, digits = 0), '%', ")", sep = '')
  
  # Indels false detection rate 
  false_pos_indel <- length(which(methods_mat >= 1 & icr142mat$Type != "bs" & icr142mat$SangerCall == "No"))
  method_pos_indel <- length(which(methods_mat >= 1 & icr142mat$Type != "bs"))
  fdr_indel <- paste(false_pos_indel, '/', method_pos_indel, " (", round((false_pos_indel / method_pos_indel) * 100, digits = 0), '%', ")", sep = '')
  
  # Overall false detection rate 
  fdr_overall <- paste((false_pos_bs + false_pos_indel), '/', (method_pos_bs + method_pos_indel), " (", round(((false_pos_bs + false_pos_indel) / (method_pos_bs + method_pos_indel)) * 100, digits = 0), '%', ")", sep = '')
  
  # Create Summary.txt
  names_stats <- c("Overall", "Base substitutions", "Indels", "", "Overall", "Base substitutions", "Indels", "", "Overall ", "Base substitutions", "Indels")
  table_calc <- cbind(names_stats, rbind(sens_overall, sens_bs, sens_indel, "", spec_overall, spec_bs, spec_indel, "", fdr_overall, fdr_bs, fdr_indel))
  colnames(table_calc) <- c("Variant type", submitter)
  rownames(table_calc) <-c ("Sensitivity", "", "", "", "Specificity", "", "", "", "False detection rate", "", "")
  write.table(table_calc, file.path(output_dir, "Summary.txt"), sep = '\t', col.names = NA)
  
  # Create FullResults.txt, a combination of: ICR142 NGS Validations Table, NumberOfDetections, Concordant Result and ExactFinalMatch.
  final_detection_table <- cbind(icr142mat, methods_mat)
  final_detection_table[["ConcordantFinalResult"]] <- mapply(concordantVal, final_detection_table$SangerCall, final_detection_table[[submitter]])
  final_detection_table <- cbind(final_detection_table, ExactFinalMatch)
  write.table(final_detection_table, file.path(output_dir, "FullResults.txt"), sep = '\t', row.names = F, quote = F)
  
  # Remove temporary detections file
  file.remove(file.path(output_dir, "NumberOfDetections.txt"))
}

