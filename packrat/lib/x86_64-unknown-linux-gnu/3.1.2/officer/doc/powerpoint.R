## ---- echo = FALSE, message=FALSE, warning=FALSE-------------------------
dir.create("assets/pptx", recursive = TRUE, showWarnings = FALSE)
office_doc_link <- function(url){
  stopifnot(requireNamespace("htmltools", quietly = TRUE))
  htmltools::tags$p(  htmltools::tags$span("Download file "),
    htmltools::tags$a(basename(url), href = url), 
    htmltools::tags$span(" - view with"),
    htmltools::tags$a("office web viewer", target="_blank", 
      href = paste0("https://view.officeapps.live.com/op/view.aspx?src=", url)
      ), 
    style="text-align:center;font-style:italic;color:gray;"
    )
}

## ------------------------------------------------------------------------
library(officer)
# Package `magrittr` makes officer usage easier.
library(magrittr)

## ------------------------------------------------------------------------
my_pres <- read_pptx() 

## ------------------------------------------------------------------------
my_pres <- my_pres %>% 
  add_slide(layout = "Title and Content", master = "Office Theme")

## ------------------------------------------------------------------------
layout_summary(my_pres)

## ------------------------------------------------------------------------
my_pres <- my_pres %>% 
  ph_with_text(type = "title", str = "A title") %>%
  ph_with_text(type = "ftr", str = "A footer") %>%
  ph_with_text(type = "dt", str = format(Sys.Date())) %>%
  ph_with_text(type = "sldNum", str = "slide 1") %>%
  ph_with_text(str = "Hello world", type = "body")

## ------------------------------------------------------------------------
layout_properties ( x = my_pres, layout = "Two Content", master = "Office Theme" ) %>% head()

## ------------------------------------------------------------------------
annotate_base(output_file = "assets/pptx/annotated_layout.pptx")

## ----echo=FALSE----------------------------------------------------------
office_doc_link( url = paste0( "https://davidgohel.github.io/officer/articles/", "assets/pptx/annotated_layout.pptx" ) )

## ------------------------------------------------------------------------
print(my_pres, target = "assets/pptx/first_example.pptx") 

## ----echo=FALSE----------------------------------------------------------
office_doc_link( url = paste0( "https://davidgohel.github.io/officer/articles/", "assets/pptx/first_example.pptx" ) )

## ------------------------------------------------------------------------
my_pres <- read_pptx() %>% 
  add_slide(layout = "Two Content", master = "Office Theme") %>% 
  add_slide(layout = "Title and Content", master = "Office Theme") %>% 
  add_slide(layout = "Title Only", master = "Office Theme")
length(my_pres)

## ------------------------------------------------------------------------
my_pres <- my_pres %>% remove_slide(index = 1)
length(my_pres)

## ------------------------------------------------------------------------
my_pres <- my_pres %>% on_slide(index = 1)

## ------------------------------------------------------------------------
doc <- read_pptx() %>%
  add_slide(layout = "Two Content", master = "Office Theme") %>%
  ph_with_text(type = "body", str = "A first text", index = 1) %>%
  ph_with_text(type = "body", str = "A second text", index = 2) %>%
  ph_with_text(type = "title", str = "A title") %>%
  ph_with_text(type = "ftr", str = "Slide footer") %>%
  ph_with_text(type = "dt", str = format(Sys.Date()))

print(doc, target = "assets/pptx/ph_with_text.pptx") 

## ----echo=FALSE----------------------------------------------------------
office_doc_link( url = paste0( "https://davidgohel.github.io/officer/articles/", "assets/pptx/ph_with_text.pptx" ) )

## ------------------------------------------------------------------------
img.file <- file.path( R.home("doc"), "html", "logo.jpg" )

doc <- read_pptx() 
doc <- doc %>%
  add_slide(layout = "Two Content", master = "Office Theme") %>%
  ph_with_text(type = "body", str = "body (index 1) is text", index = 1) %>% 
  ph_with_img(type = "body", index = 2, src = img.file, height = 1.06, width = 1.39 )

print(doc, target = "assets/pptx/ph_with_img.pptx")

## ----echo=FALSE----------------------------------------------------------
office_doc_link( url = paste0( "https://davidgohel.github.io/officer/articles/", "assets/pptx/ph_with_img.pptx" ) )

## ------------------------------------------------------------------------
if( require("ggplot2") ){
  doc <- read_pptx()
  doc <- add_slide(doc, layout = "Title and Content",
    master = "Office Theme")

  gg_plot <- ggplot(data = iris ) +
    geom_point(mapping = aes(Sepal.Length, Petal.Length), size = 3) +
    theme_minimal()

  if( capabilities(what = "png") )
    doc <- ph_with_gg(doc, value = gg_plot )

  print(doc, target = "assets/pptx/ph_with_gg.pptx" ) 
}

## ----echo=FALSE----------------------------------------------------------
if( file.exists("assets/pptx/ph_with_gg.pptx"))
  office_doc_link( url = paste0( "https://davidgohel.github.io/officer/articles/",
                                 "assets/pptx/ph_with_img.pptx" ) )

## ------------------------------------------------------------------------
doc <- read_pptx() 
doc <- doc %>%
  add_slide(layout = "Title and Content", master = "Office Theme") %>%
  ph_with_table(type = "body", value = head(mtcars) )

print(doc, target = "assets/pptx/ph_with_table.pptx")

## ----echo=FALSE----------------------------------------------------------
office_doc_link( url = paste0( "https://davidgohel.github.io/officer/articles/", "assets/pptx/ph_with_table.pptx" ) )

## ------------------------------------------------------------------------
doc <- read_pptx() 
doc <- doc %>%
  add_slide(layout = "Title and Content", master = "Office Theme") %>%
  ph_with_table_at(value = head(mtcars), left = 1, top = 3, 
                 height = 7, width = 7 )

print(doc, target = "assets/pptx/ph_with_table_at.pptx")

## ----echo=FALSE----------------------------------------------------------
office_doc_link( url = paste0( "https://davidgohel.github.io/officer/articles/", "assets/pptx/ph_with_table_at.pptx" ) )

## ------------------------------------------------------------------------
slide_summary(doc)

## ------------------------------------------------------------------------
doc <- ph_remove(x = doc, type = "body")

## ------------------------------------------------------------------------
my_pres <- read_pptx() %>% 
  add_slide(layout = "Title and Content", master = "Office Theme") %>% 
  ph_empty(type = "body")

## ------------------------------------------------------------------------
text_prop <- fp_text(color = "red", font.size = 20)
my_pres <- my_pres %>% 
  ph_add_par() %>%
  ph_add_text(str = "This is a red text!", style = text_prop ) %>% 
  ph_add_par(level = 2) %>%
  ph_add_text(str = "Level 2") %>% 
  ph_add_par(level = 3) %>%
  ph_add_text(str = "Level 3")

print(my_pres, target = "assets/pptx/ph_add_text_1.pptx")

## ----echo=FALSE----------------------------------------------------------
office_doc_link( url = paste0( "https://davidgohel.github.io/officer/articles/", "assets/pptx/ph_add_text_1.pptx" ) )

## ------------------------------------------------------------------------
my_pres <- read_pptx() %>% 
  add_slide(layout = "Title and Content", master = "Office Theme") %>% 
  ph_with_text(type = "body", str = "A first text")

## ------------------------------------------------------------------------
text_blue_prop <- update(text_prop, color = "blue" )
my_pres <- my_pres %>% 
  ph_add_text(str = "A small red text!", style = text_prop ) %>% 
  ph_add_text(str = "Blue text first... ", pos = "before", style = text_blue_prop ) %>% 
  ph_add_par(level = 2) %>%
  ph_add_text(str = "additional paragraph")

print(my_pres, target = "assets/pptx/ph_add_text_2.pptx") 

## ----echo=FALSE----------------------------------------------------------
office_doc_link( url = paste0( "https://davidgohel.github.io/officer/articles/", "assets/pptx/ph_add_text_2.pptx" ) )

## ------------------------------------------------------------------------
doc <- read_pptx() %>% 
  add_slide(layout = "Title and Content", master = "Office Theme") %>% 
  ph_with_text(type = "body", str = "Blah blah blah") %>% 
  ph_hyperlink(type = "body", href = "https://cran.r-project.org") %>% 
  add_slide(layout = "Title and Content", master = "Office Theme") %>% 
  ph_with_text(type = "body", str = "placeholder target")

print(doc, target = "assets/pptx/ph_hyperlink.pptx")

## ----echo=FALSE----------------------------------------------------------
office_doc_link( url = paste0( "https://davidgohel.github.io/officer/articles/", "assets/pptx/ph_hyperlink.pptx" ) )

## ------------------------------------------------------------------------
doc <- read_pptx() %>% 
  add_slide(layout = "Title and Content", master = "Office Theme") %>% 
  ph_with_text(type = "body", str = "Blah blah blah") %>% 
  add_slide(layout = "Title and Content", master = "Office Theme") %>% 
  ph_with_text(type = "body", str = "placeholder target") %>% 
  on_slide(index = 1 ) %>% 
  ph_slidelink(type = "body", slide_index = 2)

print(doc, target = "assets/pptx/ph_slidelink.pptx")

## ----echo=FALSE----------------------------------------------------------
office_doc_link( url = paste0( "https://davidgohel.github.io/officer/articles/", "assets/pptx/ph_slidelink.pptx" ) )

## ------------------------------------------------------------------------
my_pres <- read_pptx() %>% 
  add_slide(layout = "Title and Content", master = "Office Theme") %>% 
  ph_with_text(type = "body", str = "An ") %>% 
  ph_add_text(str = "hyperlink", href = "https://cran.r-project.org" )

print(my_pres, target = "assets/pptx/ph_add_text_3.pptx")

## ----echo=FALSE----------------------------------------------------------
office_doc_link( url = paste0( "https://davidgohel.github.io/officer/articles/", "assets/pptx/ph_add_text_3.pptx" ) )

