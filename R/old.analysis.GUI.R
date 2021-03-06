old.analysis.GUI <- function()   {
  #
  #   Setup and run a GUI to take inputs for an analysis file.
  #
  
  
  #   ---- Define the main window
  win <- gtkWindowNew("toplevel")
  win$setBorderWidth(8) 
  win$setTitle("S-Draw : Continuous variable analysis interface")
  
  vbox1 <- gtkVBoxNew(FALSE, 8)
  vbox1$setBorderWidth(8)
  win$add(vbox1)
  
  #--------------------------- Middle horizontal box ---------------
    req.frame <- gtkFrameNew("Required Inputs")
    vbox1$packStart(req.frame)
    
    hbox1 <- gtkVBoxNew(FALSE, 8) #sets up middle horizontal box, FALSE means things not evenly spaced, 8 is for 8 pixels between things
    hbox1$setBorderWidth(8)
    req.frame$add(hbox1) #this adds the new horizontal box to the frame which is in the overall vertical box.  we are building the window vertically   
    # ================= Required Inputs frame ============================
    frame.frame <- gtkFrameNew("Sample Information")
    hbox1$add(frame.frame)  # Adds the frame to the horizontal box
    
    #   ---- Define a vertical box
    req.vbox <- gtkVBoxNew(FALSE, 8)
    req.vbox$setBorderWidth(8)
    frame.frame$add(req.vbox)
    
    
    #   ---- Define table of boxes so everything aligns
    tbl <- gtkTable(18,2,FALSE) #3 rows, 2 columns, FALSE for nonhomogeneous
    gtkTableSetRowSpacings(tbl,1) #1 pixel between rows
    gtkTableSetColSpacings(tbl,5) #5 pixels between columns
    
    req.vbox$packStart(tbl)
    
    
    #   ---- Input csv file box
    shape.in.entry <- gtkEntry()
    shape.in.entry$setText( "" )
    shape.file.label <- gtkLabel("CSV file OR data.frame object:")
    
    shape.in.dir <- gtkEntry()  # this entry box is hidden/not displayed
    shape.in.dir$setText( getwd() )
    
    #out.r.entry <- gtkEntry()
    #out.r.entry$setText( "" )
    
    #   ---- Output R object box
    out.r.entry <- gtkEntry()
    out.r.entry$setText("")#paste("sdraw.", format(Sys.time(), "%Y.%m.%d.%H%M%S"), sep=""))
    out.r.label <- gtkLabel("Output File:")
    
    gtkTableAttach(tbl,out.r.label, 0, 1, 3, 4, xpadding=5, ypadding=5)
    gtkTableAttach(tbl,out.r.entry, 1, 2, 3, 4, xpadding=5, ypadding=5)
    
    
    shape.file.box <- gtkHBox(FALSE, 10)
    browse.b <- gtkButton("Browse")
    gSignalConnect(browse.b, "clicked", browse.for.shapefile,data=list(
      shape.in.entry = shape.in.entry, 
      shape.in.dir = shape.in.dir,
      out.r.entry = out.r.entry,
      parent.window = win
    ))
    
    
    shape.file.box$packEnd(browse.b)
    shape.file.box$packStart(shape.in.entry)
    
    gtkTableAttach(tbl,shape.file.label, 0, 1, 1, 2, xpadding=5, ypadding=5)
    gtkTableAttach(tbl,shape.file.box, 1, 2, 1, 2, xpadding=5, ypadding=5)
    
    # ---- needed analysis variables
  
  # siteID
  siteID.entry <- gtkEntryNew()
  siteID.entry$setText( "siteID" )
  siteID.label <- gtkLabel("Site-ID Variable:")
  gtkTableAttach(tbl,siteID.label, 0, 1, 5, 6, xpadding=5, ypadding=5)
  gtkTableAttach(tbl,siteID.entry, 1, 2, 5, 6, xpadding=5, ypadding=5)
  
  # EvalStatus
  evalStatus.entry <- gtkEntryNew()
  evalStatus.entry$setText( "EvalStatus" )
  evalStatus.label <- gtkLabel("Evaluation Status Variable:")
  gtkTableAttach(tbl,evalStatus.label, 0, 1, 7, 8, xpadding=5, ypadding=5)
  gtkTableAttach(tbl,evalStatus.entry, 1, 2, 7, 8, xpadding=5, ypadding=5)
  
  # Target_Sampled
  evalStatusYes.entry <- gtkEntryNew()
  evalStatusYes.entry$setText( "Include=Y" )
  evalStatusYes.label <- gtkLabel("Inclusion Identifier:")
  #evalStatusYes.label$setMarkup("<span color='red'>Inclusion Identifier:</span>")
  gtkTableAttach(tbl,evalStatusYes.label, 0, 1, 9, 10, xpadding=5, ypadding=5)
  gtkTableAttach(tbl,evalStatusYes.entry, 1, 2, 9, 10, xpadding=5, ypadding=5)
  
  # (sub)Population 2 -- recall population 1 is all elements together
  pop2.entry <- gtkEntryNew()
  pop2.entry$setText( "" )
  pop2.label <- gtkLabel("Subpopulation 1:")
  gtkTableAttach(tbl,pop2.label, 0, 1, 11, 12, xpadding=5, ypadding=5)
  gtkTableAttach(tbl,pop2.entry, 1, 2, 11, 12, xpadding=5, ypadding=5)
  
  # (sub)Population 3 -- recall population 1 is all elements together
  pop3.entry <- gtkEntryNew()
  pop3.entry$setText( "" )
  pop3.label <- gtkLabel("Subpopulation 2:")
  gtkTableAttach(tbl,pop3.label, 0, 1, 13, 14, xpadding=5, ypadding=5)
  gtkTableAttach(tbl,pop3.entry, 1, 2, 13, 14, xpadding=5, ypadding=5)
  
  # wgt
  wgt.entry <- gtkEntryNew()
  wgt.entry$setText( "wgt" )
  wgt.label <- gtkLabel("Weight Variable:")
  gtkTableAttach(tbl,wgt.label, 0, 1, 15, 16, xpadding=5, ypadding=5)
  gtkTableAttach(tbl,wgt.entry, 1, 2, 15, 16, xpadding=5, ypadding=5)
  
  # xcoord
  xcoord.entry <- gtkEntryNew()
  xcoord.entry$setText( "xcoord" )
  xcoord.label <- gtkLabel("X-Coordinate:")
  gtkTableAttach(tbl,xcoord.label, 0, 1, 17, 18, xpadding=5, ypadding=5)
  gtkTableAttach(tbl,xcoord.entry, 1, 2, 17, 18, xpadding=5, ypadding=5)
  
  # ycoord
  ycoord.entry <- gtkEntryNew()
  ycoord.entry$setText( "ycoord" )
  ycoord.label <- gtkLabel("Y-Coordinate:")
  gtkTableAttach(tbl,ycoord.label, 0, 1, 19, 20, xpadding=5, ypadding=5)
  gtkTableAttach(tbl,ycoord.entry, 1, 2, 19, 20, xpadding=5, ypadding=5)
  
  # continuous analysis variable
  cont.var.entry <- gtkEntryNew()
  cont.var.entry$setText( "contvar" )
  cont.var.label <- gtkLabel("Continuous Outcome:")
  gtkTableAttach(tbl,cont.var.label, 0, 1, 21, 22, xpadding=5, ypadding=5)
  gtkTableAttach(tbl,cont.var.entry, 1, 2, 21, 22, xpadding=5, ypadding=5)
  
  
    
    # =========================== Frame information area ==================================
    
  
  
  
  # # ------ Optional inputs box
  # opt.hbox <- gtkHBoxNew(TRUE, 2)
  # opt.hbox$setBorderWidth(8)
  # hbox2$packStart(opt.hbox)
  # 
  # opt.frame <- gtkFrameNew("Optional Inputs")
  # opt.hbox$packStart(opt.frame)
  # 
  # #    opt.blank.box <- gtkHBoxNew(TRUE,2)
  # #    opt.hbox$packStart(opt.blank.box)
  # 
  # opt.vbox <- gtkVBoxNew(FALSE, 8)
  # opt.vbox$setBorderWidth(8)
  # opt.frame$add(opt.vbox)
  # 
  # 
  # #   ---- Define table of boxes so everything aligns
  # opt.tbl <- gtkTable(7,5,FALSE)
  # gtkTableSetRowSpacings(opt.tbl,1)
  # gtkTableSetColSpacings(opt.tbl,5)
  # 
  # opt.vbox$add(opt.tbl)
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    #   ---- Separator
    vbox1$packStart(gtkHSeparatorNew(), expand=FALSE)
    
    finfo.vbox <- gtkHBoxNew(FALSE,2)
    finfo.vbox$setBorderWidth(8)
    vbox1$packStart(finfo.vbox)
    
    finfo.title <- gtkLabel("Sample\nContents:    \n<pending>")
    finfo.vbox$packStart(finfo.title, expand=FALSE, fill=FALSE)
    
    finfo.vbox$packStart(gtkVSeparatorNew(), expand=FALSE)
    
    max.vars <- 20  # maximum number of variables to display
    n.blank.cols <- 4  # must be even, half place on left and half on right
    
    finfo.tbl <- gtkTable(max.vars+1,n.blank.cols+2,FALSE) #FALSE for nonhomogeneous
    gtkTableSetRowSpacings(finfo.tbl,1) #1 pixel between rows
    gtkTableSetColSpacings(finfo.tbl,5) #5 pixels between columns
    finfo.vbox$packStart(finfo.tbl)
    
    # Allocate the labels
    names.labs <- lapply(1:(max.vars+1), gtkLabel, str="")
    vtypes.labs <- lapply(1:(max.vars+1), gtkLabel, str="")
    
    # Place column header labels
    names.labs[[1]]$setText("VARIABLE")
    vtypes.labs[[1]]$setText("CLASS")
    
    gtkTableAttach(finfo.tbl, names.labs[[1]], (n.blank.cols/2), (n.blank.cols/2)+1, 0,1 )
    gtkTableAttach(finfo.tbl, vtypes.labs[[1]], (n.blank.cols/2)+1, (n.blank.cols/2)+2, 0,1 )
    
    # Place separators
    gtkTableAttach(finfo.tbl, gtkHSeparatorNew(), (n.blank.cols/2), (n.blank.cols/2)+1, 1,2)
    gtkTableAttach(finfo.tbl, gtkHSeparatorNew(), (n.blank.cols/2)+1, (n.blank.cols/2)+2, 1,2)
    
    # Set their length
    #     f.setlablen <-function(x,lablist){
    #         lablist[[x]]$setWidthChars(25)
    #         #lablist[[x]]$setJustify(GTK_JUSTIFY_LEFT)
    #         #lablist[[x]]$setAlignment(0,.5)
    #     }
    #     names.labs <- lapply(1:(max.vars+1), f.setlablen, lablist=names.labs)
    #     vtypes.labs <- lapply(1:(max.vars+1), f.setlablen, lablist=vtypes.labs)
    
    # place them
    placelabs <-  function(x, lablist, obj, labcol, bcols){
      gtkTableAttach( obj, lablist[[x+1]], bcols+labcol-1, bcols+labcol, x-1+2, x+2) # + 2 for header
    }
    
    lapply(1:max.vars, placelabs, lablist=names.labs, obj=finfo.tbl, labcol=1, bcols=n.blank.cols/2)
    lapply(1:max.vars, placelabs, lablist=vtypes.labs, obj=finfo.tbl, labcol=2, bcols=n.blank.cols/2 )
    
    
    #     blank.labs <- lapply(1:(n.blank.cols+2), gtkLabel, str=" ")
    #     placeblanklabs <-  function(x, lablist, obj, side){
    #       gtkTableAttach( obj, lablist[[side+x]], side+x-1, side+x, 0, 1)
    #     }
    #     lapply(1:(n.blank.cols/2), placeblanklabs, lablist=blank.labs, obj=finfo.tbl, side=0)
    #     lapply(1:(n.blank.cols/2), placeblanklabs, lablist=blank.labs, obj=finfo.tbl, side=(n.blank.cols/2)+1)
    
    # Initial values in columns, and hide all but first
    names.labs[[2]]$setText("<pending>")
    vtypes.labs[[2]]$setText("<pending>")
    lapply(2:max.vars, function(x,lablist){lablist[[x+1]]$hide()}, lablist=names.labs)
    lapply(2:max.vars, function(x,lablist){lablist[[x+1]]$hide()}, lablist=vtypes.labs)
    
    
    
    
    
    # =========================== Bottom row of buttons ==================================
    
    
    #   ---- Separator
    vbox1$packStart(gtkHSeparatorNew(), expand=FALSE)
    
    
    #   ---- Define box for row of buttons at bottom
    bbox <- gtkHButtonBox()
    bbox$SetLayout("Spread")                   # Layout can be c("Start", "Edge", "Spread", "End")
    bbox$SetBorderWidth(10)
    
    #   ---- Read frame button, but do not draw sample, this displays variables in shapefile
    read.b <- gtkButton("Inspect\n Sample")
    gSignalConnect(read.b, "clicked", readButtonActionCSV, 
                   data=list(
                     shape.in.entry=shape.in.entry,
                     shape.in.dir=shape.in.dir,
                     out.r.entry=out.r.entry,
                     name.labs=names.labs,
                     type.labs=vtypes.labs, 
                     finfo.title=finfo.title
                   )
    )
    bbox$packEnd(read.b, expand=FALSE)
    
  
    #   ---- Run button
    run.b <- gtkButton("Run")
    gSignalConnect(run.b, "clicked", analysisCont, data=list( 
      shape.in.entry=shape.in.entry,
      shape.in.dir=shape.in.dir,
      siteID.entry=siteID.entry,
      evalStatus.entry=evalStatus.entry,
      evalStatusYes.entry=evalStatusYes.entry,
      pop2.entry=pop2.entry,
      pop3.entry=pop3.entry,
      wgt.entry=wgt.entry,
      xcoord.entry=xcoord.entry,
      ycoord.entry=ycoord.entry,
      cont.var.entry=cont.var.entry,
      out.r.entry = out.r.entry 
    )
    ) 
    bbox$packEnd(run.b, expand=FALSE)
  
    #   ---- Read frame button, but do not draw sample, this plots resulting CDF
  #   plot.b <- gtkButton("  Plot\nCDF")
  #   gSignalConnect(plot.b, "clicked", analysisPlotCDF, 
  #                  data=list(
  #                  )
  #   )
  #   bbox$packEnd(plot.b, expand=FALSE)  
    
    #   ---- View button
    view.b <- gtkButton("Tabulate\n Sample")
    gSignalConnect(view.b, "clicked", view.analysis.sample, data=list(
      out.r.entry = out.r.entry
    ))
    bbox$packEnd( view.b, expand=FALSE)
    
    
    
    #   ---- Write to csv button
    write.csv.b <- gtkButton("Export")
    gSignalConnect(write.csv.b, "clicked", my.write.csv, data=list(
      out.r.entry = out.r.entry, 
      parent.window = win            
    ))
    bbox$packEnd( write.csv.b, expand=FALSE)
    
    
    #   ---- Done button
    cancel.b <- gtkButton("Done")
    gSignalConnect(cancel.b, "clicked", function(x){
      win$Hide();
      win$Destroy()
    })
    bbox$packEnd( cancel.b, expand=FALSE)
    
    
    #   ---- Pack the rows of buttons into the vertical box
    vbox1$packEnd( bbox, expand=FALSE)
    
    
    #  ---- Finally, show the window
  win$Show()
  
}
