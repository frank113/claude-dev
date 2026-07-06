---
paths:
    - "*.R"
    - "*.r"
---

# R Styling Rules

## Assignment and Naming

+ Always use `<-` for variable assignment
+ Use `snake_case` for all variable and function names — `state_mask_df`, `bad_ut_idx`, `discontinuity_mod_df`
+ Suffix index vectors with `_idx` — `bad_ut_idx`, `remove_idx`, `sample_cols_idx`
+ Name data frames to reflect what they hold — `state_positive_change_df`, `daily_sample_size`

## Spacing and Control Flow

+ Place spaces inside `if` and `for` parentheses: `if ( condition )`, `for ( i in 1:n )`
+ Use 2-space indentation
+ Place spaces around `<-` and all binary operators

## Comments

+ Use `##` (double hash) for all inline comments — never single `#`
+ Use `-->` arrows in comments to convey direction or flow: `## positive changes --> nothing to something`
+ Mark major sections of a script with 5-hash banners: `##### Data Loading #####`, `##### Cleaning #####`

## Functions

+ Use explicit `return()` at the end of functions
+ Define reusable helpers (e.g., `my.table()`, `proj.theme()`) in the same file or setup chunk where they will be used
