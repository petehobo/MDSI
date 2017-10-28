# Setup -------------------------------------------------------------------

# Change as necessary
setwd("D:/mdsi/github/36102_iLab1/R")

set.seed(19690720)

library(fitdistrplus)
library(tidyverse)

# Source file origin:
# ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Datasets/NHDS/nhds10/NHDS10.PU.txt
# Relative to the working directory
SOURCE_FILE <- "data/NHDS10.PU.txt"

# Folder for created artifacts (like images).  No trailing /
# If relative, relative to working directory
ARTIFACTS_DIRECTORY <- "out"

# According to the data dictionary, DaysOfCare gets set to 1 if admission date
# and discharge date are the same, and the LengthOfStayFlag gets set to 0.
# Revert DaysOfCare to 0 if LengthOfStayFlag == 0?
CONVERT_ZERO_DAY_STAYS <- FALSE

# The data has a very long tail.  Trim it?
TRIM_TAIL <- TRUE

# If TRIM_TAIL is TRUE, determine how much to keep
TRIM_AFTER_QUANTILE <- 0.95

# Extra detail to add to filenames to differentiate different parameters
FILE_STUB <- if_else(TRIM_TAIL, paste0(".", TRIM_AFTER_QUANTILE), "")

# Structure of the source file.  Based on pages 16-19 of
# ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Dataset_Documentation/NHDS/NHDS_2010_Documentation.pdf
FIELDS <- tribble(
    ~name,                ~width, ~type,
    "SurveyYear",               2, col_integer(),
    "NewbornStatus",            1, col_factor(levels = c("1", "2")),
    "UnitsForAge",              1, col_factor(levels = c("1", "2", "3")),
    "Age",                      2, col_integer(),
    "Sex",                      1, col_factor(levels = c("1", "2")),
    "Race",                     1, col_factor(levels = c("1", "2", "3", "4", "5", "6", "8", "9")),
    "MaritalStatus",            1, col_factor(levels = c("1", "2", "3", "4", "5", "9")),
    "DischargeMonth",           2, col_factor(levels = c("01","02","03","04","05","06","07","08","09","10","11","12")),
    "DischargeStatus",          1, col_factor(levels = c("1", "2", "3", "4", "5", "6", "9")),
    "DaysOfCare",               4, col_integer(),
    "LengthOfStayFlag",         1, col_factor(levels = c("0", "1")),
    "GeographicDescription",    1, col_factor(levels = c("1", "2", "3", "4")),
    "NumberOfBeds",             1, col_factor(levels = c("1", "2", "3", "4","5")),
    "HospitalOwnership",        1, col_factor(levels = c("1", "2", "3")),
    "AnalysisWeight",           5, col_integer(),
    "SurveyYearPrefix",         2, col_integer(),
    "DiagnosisCode1",           5, col_character(),
    "DiagnosisCode2",           5, col_character(),
    "DiagnosisCode3",           5, col_character(),
    "DiagnosisCode4",           5, col_character(),
    "DiagnosisCode5",           5, col_character(),
    "DiagnosisCode6",           5, col_character(),
    "DiagnosisCode7",           5, col_character(),
    "DiagnosisCode8",           5, col_character(),
    "DiagnosisCode9",           5, col_character(),
    "DiagnosisCode10",          5, col_character(),
    "DiagnosisCode11",          5, col_character(),
    "DiagnosisCode12",          5, col_character(),
    "DiagnosisCode13",          5, col_character(),
    "DiagnosisCode14",          5, col_character(),
    "DiagnosisCode15",          5, col_character(),
    "ProcedureCode1",           4, col_character(),
    "ProcedureCode2",           4, col_character(),
    "ProcedureCode3",           4, col_character(),
    "ProcedureCode4",           4, col_character(),
    "ProcedureCode5",           4, col_character(),
    "ProcedureCode6",           4, col_character(),
    "ProcedureCode7",           4, col_character(),
    "ProcedureCode8",           4, col_character(),
    "PrincipalSourceOfPayment", 2, col_factor(levels = c("01","02","03","04","05","06","07","08","09","10","99")),
    "SecondarySourceOfPayment", 2, col_factor(levels = c("01","02","03","04","05","06","07","08","09","10")),
    "DiagnosisRelatedGroups",   3, col_character(),
    "TypeOfAdmission",          1, col_factor(levels = c("1", "2", "3", "4", "5", "9")),
    "SourceOfAdmission",        2, col_factor(levels = c("01","02","03","04","05","06","07","08","09","10","11","12","99")),
    "AdmittingDiagnosis",       5, col_character()
)

data <- read_fwf(SOURCE_FILE, fwf_widths(FIELDS$width, FIELDS$name), col_types = FIELDS$type)

if (CONVERT_ZERO_DAY_STAYS) {
    data <- data %>%
        mutate(DaysOfCare = if_else(LengthOfStayFlag=="0", 0L, DaysOfCare))
}

if (TRIM_TAIL) {
    data <- data %>% filter(DaysOfCare <= quantile(DaysOfCare, TRIM_AFTER_QUANTILE))
}

DaysOfCare <- data %>% pull(DaysOfCare)


# Add a little noise, as the lengths of stay are integers, and that seems
# to cause problems fitting various models
DaysOfCare <- DaysOfCare + runif(length(DaysOfCare), if_else(CONVERT_ZERO_DAY_STAYS, 0, -0.5), if_else(CONVERT_ZERO_DAY_STAYS, 0.99, 0.49))


# Generate a few exploratory plots
png(paste0(ARTIFACTS_DIRECTORY, "/plotdist", FILE_STUB ,".png"), width=4000, height=2000, res=300)
plotdist(DaysOfCare)
dev.off()

png(paste0(ARTIFACTS_DIRECTORY, "/descdist", FILE_STUB ,".png"), width=2000, height=2000, res=300)
descdist(DaysOfCare)
dev.off()

# png(paste0(ARTIFACTS_DIRECTORY, "/descdist.boot", FILE_STUB ,".png"), width=2000, height=2000, res=300)
# descdist(DaysOfCare, boot=1000)
# dev.off()

# Try to fit a few distributions
distributions <- list("Weibull"     = "weibull",
                      # "Exponential" = "exp",
                      "Log Normal"  = "lnorm",
                      # "Logistic"    = "logis",
                      "Normal"      = "norm",
                      "Gamma"       = "gamma")

fitted_distributions <- lapply(distributions, function(distribution) {
    cat(distribution, sep = "\n")
    result <- NULL
    tryCatch({
        result <- fitdist(DaysOfCare, distribution, method = "mle")
        # result <- fitdist(DaysOfCare, distribution, method = "mge", gof="KS")
        # result <- fitdist(DaysOfCare, distribution, method = "mme")
    },
    warning = function(w) {
        cat(paste0("*** Warning: ", w, "\n"))
    },
    error = function(e) {
        cat(paste0("*** Error: ", e, "\n"))
    })
    #
    result
})

png(paste0(ARTIFACTS_DIRECTORY, "/fitdist.weibull", FILE_STUB ,".png"), width=2000, height=2000, res=300)
plot(fitted_distributions[["Weibull"]])
dev.off()

# Remove NULLs - distributions that failed to fit any parameters
fitted_distributions <- compact(fitted_distributions)

# Dump the results as plots
png(paste0(ARTIFACTS_DIRECTORY, "/denscomp", FILE_STUB ,".png"), width=2000, height=2000, res=300)
denscomp(fitted_distributions, legendtext = names(fitted_distributions))
dev.off()

png(paste0(ARTIFACTS_DIRECTORY, "/qqcomp", FILE_STUB ,".png"), width=2000, height=2000, res=300)
qqcomp(fitted_distributions, legendtext = names(fitted_distributions))
dev.off()

png(paste0(ARTIFACTS_DIRECTORY, "/cdfcomp", FILE_STUB ,".png"), width=2000, height=2000, res=300)
cdfcomp(fitted_distributions, legendtext = names(fitted_distributions))
dev.off()

png(paste0(ARTIFACTS_DIRECTORY, "/ppcomp", FILE_STUB ,".png"), width=2000, height=2000, res=300)
ppcomp(fitted_distributions, legendtext = names(fitted_distributions))
dev.off()

gofstat(fitted_distributions, fitnames = names(fitted_distributions))

gofstat(fitted_distributions, fitnames = names(fitted_distributions))$kstest
