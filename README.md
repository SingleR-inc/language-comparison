# Consistency checks for R/Python

This repository contains some tests to check for consistent results between the [R](https://github.com/SingleR-inc/SingleR) and [Python](https://github.com/SingleR-inc/singler-py) bindings.
We perform annotations on datasets from the **scRNAseq** package and compare the results between the latest versions of **SingleR** in both languages.

- Run `run.R` to generate the R versions of each result.
- Run `run.py` to generate the Python versions of each result.
- Use `compare.R` to check for equality between results.
