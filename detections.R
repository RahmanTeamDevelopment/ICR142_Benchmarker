source("helper.R")



#----------------------------------------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------------------------------------

# Function to assesss detection of a negative base substitution site in a VCF file, taking as input VarID which is a SiteID from ValidationMatrix and the VCF data.frame file to be queried
detect_negative_bs <- function(VarID, VCF, ValidationMatrix){
  wval <- which(ValidationMatrix$SiteID == VarID)
  vname <- paste(ValidationMatrix$CHR[wval], ValidationMatrix$EvaluatedPosition[wval], sep = " ")
  vcfnames <- paste(VCF[,1], VCF[,2], sep = " ")
  retval <- 0
  if(vname %in% vcfnames){
    wvec <- which(nchar(VCF[vcfnames == vname, 4]) == 1 & nchar(VCF[vcfnames == vname, 5]) == 1)
    if (length(wvec) > 0){
      retval <- 1 
      v <- which(vcfnames %in% vname, arr.ind = TRUE)
      v_real <- which(v != "NA")
      index_vec <- v[v_real]
      index_bs_vec <- which(nchar(VCF[index_vec, 4]) == 1 & nchar(VCF[index_vec, 5]) == 1) #extract bs only
      bs_indices <- index_vec[index_bs_vec]
      sample_col <- strsplit(VCF[bs_indices, 10], ':')
      genotypes <- sapply(sample_col, "[", 1)
      if (all(genotypes  %in% v_missing_allele) ){retval <- '.'} 
      if (all(genotypes  %in% v_reference_allele) ){retval <- 0} 
      for (index in bs_indices){
        genotype <- unlist(strsplit(VCF[index, 10], ':'))[1]
        if ( !(any(v_reference_allele %in% genotype)) & !(any(v_missing_allele %in% genotype)))
        {
          fp_to_add <- data.frame(CHR = VCF[index, 1], pos = VCF[index, 2], ID = VCF[index, 3], ref = VCF[index, 4], alt = VCF[index, 5], qual = VCF[index, 6], filter_v = VCF[index, 7], i = VCF[index, 8], format_v = VCF[index, 9], sample_v = VCF[index, 10], SiteID = VarID, len = max(nchar(VCF[index, 4]), nchar(VCF[index, 5])) - 1, stringsAsFactors = F)
          fp_table <<- rbind(fp_table, fp_to_add)
        }
      }
    }
  } 
  return(retval)
}

# Function to assesss detection of a negative indel site in a VCF file, taking as input VarID which is a SiteID from ValidationMatrix and the VCF data.frame file to be queried
detect_negative_indel <- function(VarID, VCF, ValidationMatrix)
{
  wval <- which(ValidationMatrix$SiteID == VarID)
  vnames<-paste(ValidationMatrix$CHR[wval], (ValidationMatrix$EvaluatedPosition[wval] - 100):(ValidationMatrix$EvaluatedPosition[wval] + 100), sep = " ")
  vcfnames <- paste(VCF[,1],VCF[,2], sep = " ")
  retval <- 0 # Note: in a site region where only bs and missing genotypes ('.') are detected, retval = 0 (not '.')
  if(any(vnames %in% vcfnames)){
    wvec <- which(nchar(VCF[vcfnames %in% vnames, 4]) > 1 | nchar(VCF[vcfnames %in% vnames, 5]) > 1)
    if (length(wvec) > 0){
      v <- which(vcfnames %in% vnames, arr.ind = TRUE)
      v_real <- which(v != "NA")
      index_vec <- v[v_real]
      index_indel_vec <- which(nchar(VCF[index_vec, 4]) >1 | nchar(VCF[index_vec, 5]) > 1) #extract indels only
      indel_indices <- index_vec[index_indel_vec]
      sample_col <- strsplit(VCF[indel_indices, 10], ':')
      genotypes <- sapply(sample_col, "[", 1)
      if (all(genotypes  %in% v_missing_allele) ){retval <- '.'} 
      else{
        for (index in indel_indices){
          genotype <- unlist(strsplit(VCF[index, 10], ':'))[1]
          if ( !(any(v_reference_allele %in% genotype)) & !(any(v_missing_allele %in% genotype)))
          {
            retval <- retval + 1
            fp_to_add <- data.frame(CHR = VCF[index, 1], pos = VCF[index, 2], ID = VCF[index, 3], ref = VCF[index, 4], alt = VCF[index, 5], qual = VCF[index, 6], filter_v = VCF[index, 7], i = VCF[index, 8], format_v = VCF[index, 9], sample_v = VCF[index, 10], SiteID = VarID, len = max(nchar(VCF[index, 4]), nchar(VCF[index, 5])) - 1, stringsAsFactors = F)
            fp_table <<- rbind(fp_table, fp_to_add)
          }
        }
      }
    }
  } 
  return(retval)
}

# Function to assesss detection of a base substitution variant in a VCF file, taking as input VarID which is a SiteID from ValidationMatrix and the VCF data.frame file to be queried
detect_variant_bS <- function(VarID, VCF, ValidationMatrix){
  wval <- which(ValidationMatrix$SiteID == VarID)
  vname <- paste(ValidationMatrix$CHR[wval], ValidationMatrix$POS[wval], ValidationMatrix$REF[wval], ValidationMatrix$ALT[wval], sep=" ")
  vcfnames <- paste(VCF[,1], VCF[,2], VCF[,4], VCF[,5], sep = " ")
  if(vname %in% vcfnames){
    index <- which(vcfnames %in% vname, arr.ind = TRUE)
    genotype <- unlist(strsplit(VCF[index, 10], ':'))[1]
    if (any(v_missing_allele %in% genotype)){retval <- '.'} 
    else if (any(v_reference_allele %in% genotype)) {retval <- 0} 
    else{ 
      index <- which(vcfnames %in% vname, arr.ind = TRUE)
      ExactFinalMatch[VarID] <<- "yes"
      tp_to_add <- data.frame(CHR = VCF[index, 1], pos = VCF[index, 2], ID = VCF[index, 3], ref = VCF[index, 4], alt = VCF[index, 5], qual = VCF[index, 6], filter_v = VCF[index, 7], i = VCF[index, 8], format_v = VCF[index, 9], sample_v = VCF[index, 10], SiteID = VarID, len = max(nchar(VCF[index, 4]), nchar(VCF[index, 5])) -1 , stringsAsFactors = F)
      tp_table <<- rbind(tp_table, tp_to_add)
      retval <- 1 
    }
  } else retval <- 0
  return(retval)
}


# Function to assesss detection of an indel variant in a VCF file, taking as input VarID which is a SiteID from ValidationMatrix and the VCF data.frame file to be queried
detect_variant_indel <- function(VarID, VCF, ValidationMatrix){
  wval <- which(ValidationMatrix$SiteID == VarID)
  vnames <- paste(ValidationMatrix$CHR[wval], (ValidationMatrix$EvaluatedPosition[wval] - 100):(ValidationMatrix$EvaluatedPosition[wval] + 100), sep=" ")
  vcfnames <- paste(VCF[,1], VCF[,2], sep = " ")
  retval <- 0 # Note: in a site region where only bs and missing genotypes ('.') are detected, retval = 0 (not '.')
  if(any(vnames %in% vcfnames)){
    wvec <- which(nchar(VCF[vcfnames %in% vnames, 4]) > 1 | nchar(VCF[vcfnames %in% vnames, 5]) > 1)
    if (length(wvec) > 0 ){
      v <- which(vcfnames %in% vnames, arr.ind = TRUE)
      v_real <- which(v != "NA")
      index_vec <- v[v_real]
      index_indel_vec <- which(nchar(VCF[index_vec, 4]) > 1 | nchar(VCF[index_vec, 5]) > 1) # extract indels only
      indel_indices <- index_vec[index_indel_vec]
      sample_col <- strsplit(VCF[indel_indices, 10], ':')
      genotypes <- sapply(sample_col, "[", 1)
      if (all(genotypes  %in% v_missing_allele) ){retval <- '.'} 
      for (index in indel_indices){
        genotype <- unlist(strsplit(VCF[index, 10], ':'))[1]
        if ( !(any(v_reference_allele %in% genotype)) & !(any(v_missing_allele %in% genotype)))
        {
          retval <- retval + 1
          tp_to_add <- data.frame(CHR = VCF[index, 1], pos = VCF[index, 2], ID = VCF[index, 3], ref = VCF[index, 4], alt = VCF[index, 5], qual = VCF[index, 6], filter_v = VCF[index, 7], i = VCF[index, 8], format_v = VCF[index,9], sample_v = VCF[index, 10], SiteID = VarID, len = max(nchar(VCF[index, 4]), nchar(VCF[index, 5])) - 1, stringsAsFactors = F)
          tp_table <<- rbind(tp_table, tp_to_add)
          if (ValidationMatrix$POS[wval] == VCF[index, 2] & ValidationMatrix$REF[wval] == VCF[index, 4] & ValidationMatrix$ALT[wval] == VCF[index, 5]) ExactFinalMatch[VarID] <<- "yes"                      
        }	
      }
    }	
  } 
  return(retval)
}
# Function to run variant detection assessment in a VCF file ---------------------------
run_variant_detection <- function(SampleID, Location, icr142mat){	
  VarIDVector <- icr142mat$SiteID[icr142mat$Sample == SampleID]
  VCFToRun <- scan(Location, sep="\n", what="character")
  if(sum(substr(VCFToRun,1,1) != "#") == 0) SampleDetected <- rep(0,length(VarIDVector)) else{
    VCFToRun <- read.table(Location, sep = "\t", hea = F, stringsAsFactors = F, quote = "", blank.lines.skip = TRUE, colClasses = c("character", "integer", rep("character", 8)))
    VCFToRun [,1]  <-gsub("chr", "", VCFToRun[,1]) # Removing "chr" from column 1 if exists 
    SampleDetected <- sapply(VarIDVector, function(x){
      retval <- "check"
      if(icr142mat$Type[x] == "bs" & icr142mat$SangerCall[x] == "No") retval <- detect_negative_bs(x, VCFToRun, icr142mat)
      if(icr142mat$Type[x] != "bs" & icr142mat$SangerCall[x] == "No") retval <- detect_negative_indel(x, VCFToRun, icr142mat)
      if(icr142mat$Type[x] == "bs" & icr142mat$SangerCall[x] != "No") retval <- detect_variant_bS(x, VCFToRun, icr142mat)
      if(icr142mat$Type[x] != "bs" & icr142mat$SangerCall[x] != "No") retval <- detect_variant_indel(x, VCFToRun, icr142mat)
      return(retval)
    })
  }
  return(SampleDetected)
}


# Populate DetectedMatrix ---------------------------
get_detected_matrix <- function(icr142mat, fkey, output_dir, submitter){

  #******************** Initialize params:
  ExactFinalMatch <<- rep('no', nrow(icr142mat))
  ExactFinalMatch[(which(icr142mat[,"SangerCall"] == "No"))] <<- "."

  df_header <- data.frame(CHR = "CHR", pos = "POS", ID = "ID", ref = "REF", alt = "ALT", qual = "QUAL", filter_v = "FILTER", i = "INFO", format_v = "FORMAT", sample_v = "SAMPLE", SiteID = "SiteID", len = "Length", stringsAsFactors = F)
  fp_table <<- df_header # True positives
  tp_table <<- df_header # False positives

  v_missing_allele <<- c("./.", ".|.", ".") # All possible values indicating missingness in genotype (GT) value
  v_reference_allele <<- c("0/0", "0|0", "0") # All possible values indicating reference call in genotype (GT) value
  #*********************

  DetectedMatrix <- matrix("NA", nrow=nrow(icr142mat), ncol=1)
  colnames(DetectedMatrix) <- submitter
  for(i in 1:nrow(fkey)){
    print (paste("Sample ", fkey$SampleID[i], " is being processed ... (", i, "/", nrow(fkey),")", sep = ""))
    irow<-which(icr142mat$Sample == fkey$SampleID[i])
    DetectedMatrix[irow]<-run_variant_detection(fkey$SampleID[i],fkey$Location[i], icr142mat)
  }
  # Create output files
  write.table(DetectedMatrix, file.path(output_dir, "NumberOfDetections.txt"), sep="\t", row.names=F, quote=F, na="")
  write.table(fp_table, file.path(output_dir, "FalsePositives.txt"), quote=F, row.names=F, col.names=F, sep='\t')
  write.table(tp_table, file.path(output_dir, "TruePositives.txt"), quote=F, row.names=F, col.names=F, sep='\t')
  
  return(ExactFinalMatch)
}
