# Imports
library(repcred)
library(profvis)

repertoire <- normalizePath(file.path("test_repertoires","p1974_d60.tsv"))

outdir <- file.path("profiling","out","test1_down-T")
prof1d <- profvis({
    dir.create(outdir, recursive = T)
    outdir <- normalizePath(outdir)
    opt <- list(
        REP=repertoire,
        OUTDIR=outdir,
        GENOME=NULL,
        DOWN=TRUE,
        FORMAT="html"
    )    
    report <- render_report(rep=opt$REP, 
                            outdir=opt$OUTDIR, 
                            genome = opt$GERM, 
                            downsample = opt$DOWN, 
                            format=opt$FORMAT)
    
})
htmlwidgets::saveWidget(prof1d, file.path(outdir,"prof1d.html"))


outdir <- file.path("profiling","out","test1_down-F")
prof1 <- profvis({
    dir.create(outdir, recursive = T)
    outdir <- normalizePath(outdir)
    opt <- list(
        REP=repertoire,
        OUTDIR=outdir,
        GENOME=NULL,
        DOWN=FALSE,
        FORMAT="html"
    )    
    report <- render_report(rep=opt$REP, 
                            outdir=opt$OUTDIR, 
                            genome = opt$GERM, 
                            downsample = opt$DOWN, 
                            format=opt$FORMAT)
    
})
save(prof1, file=file.path(outdir, prof1))
htmlwidgets::saveWidget(prof1, "prof1.html")