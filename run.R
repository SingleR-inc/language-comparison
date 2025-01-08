library(SingleR)
library(scRNAseq)
library(celldex)
library(alabaster.base)

z_sce <- fetchDataset("zeisel-brain-2015", "2023-12-14", realize.assays=TRUE)
immgen_ref <- fetchReference("immgen", "2024-02-26", realize.assays=TRUE)
l_sce <- fetchDataset("lamanno-brain-2016", "2023-12-17", path = "human-es", realize.assays=TRUE)
blueprint_ref <- fetchReference("blueprint_encode", "2024-02-26", realize.assays=TRUE)
h_sce <- fetchDataset("he-organs-2020", "2023-12-21", path="blood", realize.assays=TRUE)
dice_ref <- fetchReference("dice", "2024-02-26", realize.assays=TRUE)

matches <- SingleR(z_sce, immgen_ref, labels=immgen_ref$label.main, assay.type.test=1)
unlink("r_basic_scenario_1", recursive=TRUE)
saveObject(matches, "r_basic_scenario_1")

matches <- SingleR(l_sce, blueprint_ref, labels=blueprint_ref$label.main, assay.type.test=1)
unlink("r_basic_scenario_2", recursive=TRUE)
saveObject(matches, "r_basic_scenario_2")

#######################

matches <- SingleR(
    h_sce,
    list(blueprint=blueprint_ref, dice=dice_ref),
    labels=list(blueprint=blueprint_ref$label.main, dice=dice_ref$label.main),
    assay.type.test=1
)
unlink("r_integrated_scenario", recursive=TRUE)
saveObject(matches, "r_integrated_scenario")

#######################

m_sce <- fetchDataset("muraro-pancreas-2016", "2023-12-19", realize.assays=TRUE)
p_sce <- fetchDataset("grun-pancreas-2016", "2023-12-14", realize.assays=TRUE)

matches <- SingleR(
    p_sce,
    {
        counts <- assay(m_sce)
        scrapper::normalizeCounts(counts, size.factors=scrapper::centerSizeFactors(colSums(counts)))
    },
    labels=m_sce$label,
    de.method="wilcox",
    assay.type.test=1
)
unlink("r_sc_de", recursive=TRUE)
saveObject(matches, "r_sc_de")

matches <- SingleR(
    p_sce,
    {
        counts <- assay(m_sce)
        scrapper::normalizeCounts(counts, size.factors=scrapper::centerSizeFactors(colSums(counts)))
    },
    labels=m_sce$label,
    aggr.ref=TRUE,
    de.method="t",
    assay.type.test=1
)
unlink("r_sc_aggr", recursive=TRUE)
saveObject(matches, "r_sc_aggr")
