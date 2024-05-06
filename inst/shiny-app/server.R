server <- function(input, output) {
    
    dataValues <- reactiveValues(
        repcred_report_path=NULL
    )
    
    observe({
        
        val= input$input_chk
        
        if(val==TRUE){
            output$condInput <- renderUI({ fileInput("genome", 
                                                     "Choose germline reference FASTA File",
                                                     multiple = TRUE,
                                                     accept = c("text/tab-separated-values",".fasta",".fna",".ffn",".frn",".fa","text/plain"))
            })  
        }
        
        if(val==FALSE){
            output$condInput <- renderUI({})  
        }
        
    })
    
    help_text2 = "Many of the statistics can be run without a genome file but the genome file does allow missing genes to be pin pointed and gene usage to be analysed."
    
    observeEvent(input$go, {
        output$openResultsBtn <- renderUI({
            
            #req(input$file1)
            withProgress(
                tryCatch(
                    {
                        dataValues$repcred_report_path <- repcred_report(input$file1$datapath,
                                                                         genome_file=input$genome$datapath,
                                                                         #sumrep = input$sumrep,
                                                                         downsample = input$input_downsample)
                        
                    },
                    error = function(e) {
                        stop(e)
                    }
                ),
                message="Analyzing repertoire..."
            )
            
            if (!is.null(dataValues$repcred_report_path)) {
                
                #repcred::replaceChapterClassType(dataValues$repcred_report_path)
                shiny::addResourcePath(basename(dirname(dataValues$repcred_report_path)),dirname(dataValues$repcred_report_path))
                
                output$downloadResults <- downloadHandler(
                    filename = function() {
                        "report.zip"
                    },
                    content = function(fname) {
                        zip(zipfile=fname, files=dirname(dataValues$repcred_report_path))
                        if(file.exists(paste0(fname, ".zip"))) {file.rename(paste0(fname, ".zip"), fname)}
                    },
                    contentType = "application/zip"
                )
                
                div(
                    actionButton(inputId='openResultsBtn',
                                 label= 'Open analysis results',
                                 icon = icon("link"),
                                 style="color: #fff; background-color: #f39c12; border-color: #f39c12",
                                 onclick =paste0("window.open('",file.path(".",basename(dirname(dataValues$repcred_report_path)),basename(dataValues$repcred_report_path)),"', '_blank')")
                    ),
                    downloadButton("downloadResults")
                )
            }
        })
    })
    
    
}