# Define UI
options(shiny.maxRequestSize = 0)

ui <- fluidPage(
    
    tags$head(
        tags$link(rel = "stylesheet", type = "text/css", href = "repcred.css")
    ),
    
    tags$script(
        HTML(
            "$(function () { 
        $('[data-toggle=tooltip]').tooltip();   
      });"
        )
    ),
    
    # App title
    fluidRow(
        id="div-main",
        tags$img(src = "logo.svg", width = "100px"),
        tags$h1("Rep-Cred"),
        tags$strong("Credibility of a repertoire"),
        tags$p("Summary statistics and graphical information to quickly asses the quality of a repertoire."),
        tabsetPanel(
            tabPanel("Rep-Cred",
                     br(),
                     # Input
                     fileInput("file1", 
                               "Choose repertoire (.tsv) (REQUIRED)",
                               multiple = FALSE,
                               accept = c("text/tab-separated-values",
                                          ".tsv",".csv",".tab", "text/plain")),
                     # helpText( "Note: The repertoire file should contain the ",
                     #           "speficied rows as set out by the AIRR guidelines.",
                     #           "Please be aware some stats will be unable to be ",
                     #           "run if there is missing data in some columns. ",
                     #           "This is mainly the sumrep stats , if there are ",
                     #           "specific stats you need makesure the related ",
                     #           "columns that are required are filled."),
                     
                     # Downsample
                     checkboxInput("input_downsample", "Downsample repertoire?", value = TRUE ),
                     # helpText( "Note: Whether to downsample the input repertoire",
                     #           "to 5000 sequences."),
                     
                     # Genome fasta file upload
                     checkboxInput("input_chk", "Upload germline reference set?", value = FALSE ),
                     # helpText( "Note: Many of the statistics can be run without ",
                     #            "a genome file but the genome file does allow ",
                     #            "missing genes to be pin pointed and gene usage ",
                     #            "to be analysed."),
                     
                     # Sumrep 
                     uiOutput("condInput"),      
                     #selectInput("sumrep" , "Select Sumrep stats to run. Full stats takes longer to run but gives pairwise statistics , Basic statistics is faster but contains less statistics." , choices=c("Full sumrep stats" , "Basic sumrep stats")),
                     actionButton("go", "Run analysis"),
                     
                     # Output
                     uiOutput("openResultsBtn")                     
                     
            ),
            tabPanel("Help"),
            tabPanel("About")
        )
    )
)
