

# Print welcome message and start time ---------------------------
welcome_message <- function(version){
  cat("\n --- ICR142_Benchmarker", version, " \n\n")
  start_time <- Sys.time()
  cat (paste(" --- Started in: ", start_time, " \n\n"))
}

# Print goodbye message and end time ---------------------------
goodbye_message <- function(){
  end_time <- Sys.time()
  cat(paste ("\n --- Finished in: ", end_time, " \n"))
}

# Read ICR142 NGS Validation table ---------------------------
read_icr142 <- function(){
  icr142mat <- read.table("data/ICR142_Validation_Table.txt", sep = "\t", hea = T, stringsAsFactors = F)
}

# Check input arguments ---------------------------
check_args <- function(fkey_in, icr142mat, submitter){
  if (is.null(fkey_in)){
    print("ERROR: Input file (--input) must be provided. Execution halted")
    quit()
  }
  fkey <- read.table(paste(fkey_in), sep= "\t" ,hea = T, stringsAsFactors = F)
  if(! (all(c("SampleID", "Location") %in% colnames(fkey)))){
    print("ERROR: Input file header must have SampleID and Location columns!")
    quit()
  }
  if (nrow(fkey) != 142){
    print(paste("ERROR: Input file must contain exactly 142 samples."))
    quit()
    
  }
  if (is.null(submitter)){
    print("ERROR: Method name (--method_name) must be provided. Execution halted")
    quit()
  }
  return (fkey)
}

# Get text inside parenthesis ---------------------------
geti<-function(text){
  return(gsub("\\(([^()]*)\\)|.", "\\1", text, perl=T))
}
