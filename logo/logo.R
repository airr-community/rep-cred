# install.packages("hexSticker")
library(hexSticker)
library(ggplot2)
library(emojifont)
emojifont::load.fontawesome()
sysfonts::font_add_google("Noto Sans Mono")


subplot <- ggplot(data.frame(x=0, y=0),
                  aes(x,y)) + 
    geom_text(label=fontawesome('fa-check'),
              family='fontawesome-webfont', 
              color="white",
              size=20) +
    theme_void()

sticker(subplot,
        package="Rep-Cred", 
        p_size=8, 
        p_color = "#FFFFFF",
        p_family = "Noto Sans Mono",
        p_fontface = "bold",
        s_x=1, s_y=0.8, s_width=1, s_height=1,
        h_fill = "#1881C2",
        h_color = "#000000",
        spotlight = F,
        white_around_sticker = F,
        filename=file.path(here::here(),
                           "inst","shiny-app","www",
                           "logo.svg"))


sticker(subplot,
        package="Rep-Cred", 
        p_size=8, 
        p_color = "#FFFFFF",
        p_family = "Noto Sans Mono",
        p_fontface = "bold",
        s_x=1, s_y=0.8, s_width=1, s_height=1,
        h_fill = "#1881C2",
        h_color = "#000000",
        spotlight = F,
        white_around_sticker = F,
        filename=file.path(here::here(),
                           "inst","rstudio","templates","project","project_files",
                           "logo.svg"))
