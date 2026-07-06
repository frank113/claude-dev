---
paths:
    - "*.R"
    - "*.r"
    - "*.Rmd"
    - "*.rmd"
---

# Data Manipulation Preferences

This code is a deliberate hybrid of base R and tidyverse. Do not force pure tidyverse idioms where base R is clearer.

## Row Filtering

+ Use `subset()` for row filtering over `dplyr::filter()` — `subset(df, condition)` reads closer to plain English
+ Use `which()` combined with `[` indexing when removing rows by a precomputed index: `df[-bad_idx,]`

## Joining

+ Use the explicit dot form in all join calls: `left_join(x = ., y = other_df, by = c("key" = "key"))`
+ Qualify `dplyr::select` with the package name whenever `MASS` or `nlme` are loaded — they export conflicting names

## Iteration

+ Use `for` loops for row-wise operations that update a column or accumulate results into a vector
+ Use `sapply()` for element-wise operations that return a scalar per element
+ Reserve `purrr::map_*` only when a typed return variant (`map_dfr`, `map_chr`) makes the code meaningfully cleaner

## Membership Testing

+ Use `%in%` for set membership: `state %in% c("ia", "nd", "ne")`
+ Use `union()` and `intersect()` for set operations on index vectors

## Plotting

+ Use `ggplot2` for all publication-quality figures; use base R `plot()` only for quick diagnostic plots (e.g., `plot(model)`)
+ Define a single `proj.theme()` function in the setup or top of script and append it to every plot: `+ proj.theme()`
+ Use named character vectors for `scale_color_manual()` and `scale_fill_manual()` — `c("0" = "red", "1" = "blue")`
+ Annotate directly on the plot with `geom_label()` rather than relying on external captions when the label belongs near the data
+ Label axes and titles with `xlab()`, `ylab()`, and `ggtitle()` — not `labs()`
