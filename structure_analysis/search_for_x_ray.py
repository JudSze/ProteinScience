import sys
import requests
import urllib.request
import pandas as pd

if __name__ == "__main__":
    target_method = "X-RAY DIFFRACTION"
    target_column = "experimental_method"

    path_to_mined_structures = sys.argv[1]
    results_folder = sys.argv[2]

    mined_structures = pd.read_csv(path_to_mined_structures, sep=",", on_bad_lines="skip")

    if target_method in mined_structures[target_column].values:
        crystal_structures = mined_structures.loc[mined_structures[target_column]
                                                  == target_method]

        for PDB_structure in crystal_structures["structure_id"]:
            pdb_file = f"https://files.rcsb.org/download/{PDB_structure}.pdb"
            response = requests.get(pdb_file)

            if response.status_code == 200:
                urllib.request.urlretrieve(pdb_file, f"{results_folder}/{PDB_structure}.pdb")
