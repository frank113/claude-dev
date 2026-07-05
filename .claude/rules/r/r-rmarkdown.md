---
paths:
    - "*.Rmd"
    - "*.rmd"
---

# R Markdown Rules

## Setup Chunk

+ Open every document with `{r setup, include=FALSE}`
+ Set global chunk options with `knitr::opts_chunk$set()` using at minimum: `echo = FALSE, eval = TRUE, warning = FALSE, message = FALSE, fig.align = "center", fig.pos = 'H', fig.height = 4, fig.width = 7`
+ Load packages with `require()` in the setup chunk — `library(dplyr)` is the exception when `require()` causes a namespace conflict
+ Call `set.seed()` in the setup chunk with a fixed integer
+ Guard against re-attaching already-loaded data: `if ( "obj" %in% search() ) { detach(obj) }`
+ Define `my.table()` and `proj.theme()` as helper functions in the setup chunk, not scattered across analysis chunks
+ Call `source()` for any external R utility scripts in the setup chunk

## Chunk Organization

+ Every chunk that produces a figure gets a `fig.cap`: `{r, fig.cap="Weekend Effect (Sundays in Red)"}`
+ Use `include = FALSE` on chunks that only produce side effects with no rendered output
+ Override `fig.height` and `fig.width` per chunk when a figure deviates from the global defaults

## Tables

+ Define a `my.table()` wrapper in the setup chunk — it calls `kable()` then `kableExtra::kable_styling()` with `bootstrap_options = "bordered"`, `latex_options = "hold_position"`, and `full_width = FALSE`
+ Always pass the caption through `my.table(dat, cap = "Caption Text")`, not as a separate `kable()` argument

## Code Inside Chunks

+ The same `##` comment style and `##### Section #####` conventions from `r-style.md` apply inside Rmd chunks without exception
