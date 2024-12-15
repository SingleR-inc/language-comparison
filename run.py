import singler
import scrnaseq
import celldex
import dolomite_base
import shutil

import gypsum_client
import os
gypsum_client.cache_directory(os.path.expanduser("~/.cache/gypsum")) # remove this once ArtifactDB/gypsum-py#15 is fixed.

z_sce = scrnaseq.fetch_dataset("zeisel-brain-2015", "2023-12-14", realize_assays=True)
immgen_ref = celldex.fetch_reference("immgen", "2024-02-26", realize_assays=True)
l_sce = scrnaseq.fetch_dataset("lamanno-brain-2016", "2023-12-17", path = "human-es", realize_assays=True)
blueprint_ref = celldex.fetch_reference("blueprint_encode", "2024-02-26", realize_assays=True)
h_sce = scrnaseq.fetch_dataset("he-organs-2020", "2023-12-21", path="blood", realize_assays=True)
dice_ref = celldex.fetch_reference("dice", "2024-02-26", realize_assays=True)

matches = singler.annotate_single(z_sce, immgen_ref, immgen_ref.get_column_data().column("label.main"))
if os.path.exists("py_basic_scenario_1"):
    shutil.rmtree("py_basic_scenario_1")
dolomite_base.save_object(matches, "py_basic_scenario_1")

matches = singler.annotate_single(l_sce, blueprint_ref, blueprint_ref.get_column_data().column("label.main"))
if os.path.exists("py_basic_scenario_2"):
    shutil.rmtree("py_basic_scenario_2")
dolomite_base.save_object(matches, "py_basic_scenario_2")

matches, imatches = singler.annotate_integrated(
    h_sce, 
    [blueprint_ref, dice_ref],
    [blueprint_ref.get_column_data().column("label.main"), dice_ref.get_column_data().column("label.main")]
)
if os.path.exists("py_integrated_scenario"):
    shutil.rmtree("py_integrated_scenario")
os.mkdir("py_integrated_scenario")
dolomite_base.save_object(matches[0], "py_integrated_scenario/blueprint")
dolomite_base.save_object(matches[1], "py_integrated_scenario/dice")
dolomite_base.save_object(imatches, "py_integrated_scenario/integrated")
