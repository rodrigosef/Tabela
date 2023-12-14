source('./r_files/flatten_HTML.r')

############### Library Declarations ###############
libraryRequireInstall("DT");
####################################################

################### Actual code ####################
if (!exists("settings_rdatatable_params_method"))
{
    settings_rdatatable_params_method = "5";
}

if (!exists("settings_rdatatable_params_showColumnFilters"))
{
    settings_rdatatable_params_showColumnFilters = "top";
}

if (!exists("settings_rdatatable_params_limitDecimalPlaces"))
{
    settings_rdatatable_params_limitDecimalPlaces = 2;
}

if (!exists("settings_rdatatable_params_showChanges"))
{
  settings_rdatatable_params_showChanges = "no"

}

if (!exists("settings_rdatatable_params_showCompact"))
{
  settings_rdatatable_params_showCompact = "no"
}

idx <- sapply(Values, class)=="numeric"
Values[, idx] <- lapply(Values[, idx], formatC, digits = as.numeric(settings_rdatatable_params_limitDecimalPlaces), format = "f")

if (settings_rdatatable_params_showChanges == "yes") {
  Values <- Values[, dim(table(Values)) != 1]
}

if (settings_rdatatable_params_showCompact == "yes") {
  p <- datatable(
    Values,
    class = 'cell-border compact stripe hover',
    rownames = FALSE,
    filter = settings_rdatatable_params_showColumnFilters,
    width = "100%",
    height = "100%",
      extensions = list('Buttons','Scroller'),
    options = list(
      #dom = 't',
      pageLength = settings_rdatatable_params_method,
      autoWidth = FALSE,
      scroller = FALSE,
      dom = 'tB',
      buttons = c('copy', 'csv', 'excel')
    )
  )
} else {
  p <- datatable(
    Values,
    class = 'cell-border compact stripe hover',
    rownames = FALSE,
    filter = settings_rdatatable_params_showColumnFilters,
    width = "100%",
    height = "100%",
    extensions = list('Buttons','Scroller'),

    options = list(
      pageLength = settings_rdatatable_params_method,
      lengthMenu = c(5, 10, 15, 20, 25, 50, 100, 1000),
      autoWidth = FALSE,
      scrollX = "100%",
      scrollY = "100%",
      scroller = TRUE,
      dom = 'tB',
      buttons = c('copy', 'csv', 'excel')
    )

  )
}

# adjust padding to use entire container
p$sizingPolicy$browser$padding <- 0

####################################################

############# Create and save widget ###############
internalSaveWidget(p, 'out.html');
####################################################
