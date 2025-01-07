library(testthat)
library(alabaster.base)
library(S4Vectors)

check_markers <- function(markers1, markers2) {
    expect_identical(sort(names(markers1)), sort(names(markers2)))
    for (n in names(markers1)) {
        expect_identical(sort(names(markers1[[n]])), sort(names(markers2[[n]])))
        for (o in names(markers1[[n]])) {
            expect_identical(markers1[[n]][[o]], markers2[[n]][[o]])
        }
    }
}

py <- readObject("py_basic_scenario_1")
r <- readObject("r_basic_scenario_1")
expect_identical(r$labels, py$best)
expect_equal(r$delta.next, py$delta)
expect_identical(sort(colnames(r$scores)), sort(colnames(py$scores)))
cn <- colnames(r$scores)
expect_equal(unname(as.matrix(r$scores)[,cn]), unname(as.matrix(py$scores)[,cn]))
check_markers(metadata(r)$de.genes, metadata(py)$markers)

py <- readObject("py_basic_scenario_2")
r <- readObject("r_basic_scenario_2")
expect_identical(r$labels, py$best)
expect_equal(r$delta.next, py$delta)
expect_identical(sort(colnames(r$scores)), sort(colnames(py$scores)))
cn <- colnames(r$scores)
expect_equal(unname(as.matrix(r$scores)[,cn]), unname(as.matrix(py$scores)[,cn]))
check_markers(metadata(r)$de.genes, metadata(py)$markers)

py <- readObject("py_integrated_scenario/integrated")
r <- readObject("r_integrated_scenario")
expect_identical(r$labels, py$best_label)
expect_identical(r$reference, py$best_reference + 1L)
expect_equal(r$delta.next, py$delta)

py <- readObject("py_sc_de")
r <- readObject("r_sc_de")
expect_identical(r$labels, py$best)
expect_equal(r$delta.next, py$delta)
expect_identical(sort(colnames(r$scores)), sort(colnames(py$scores)))
cn <- colnames(r$scores)
expect_equal(unname(as.matrix(r$scores)[,cn]), unname(as.matrix(py$scores)[,cn]))
check_markers(metadata(r)$de.genes, metadata(py)$markers)
