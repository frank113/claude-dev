---
paths:
    - "*.R"
    - "*.r"
---

# R Styling Rules

When using the R programming language do the following:

+ Place all package imports at the top of the file.
+ When using a function from a package that is imported by name in multiple places prepend it with the package name. For example if using `filter` from `dplyr` and another `filter` already exists in the namespace use `dplyr::filter`
+ Prefer piping when possible
+ Always use `<-` for variable assignment rather than `=`
+ 