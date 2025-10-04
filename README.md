HipPerm is a distributed memory framework we developed on top of CombBLAS to perform permutation, extraction, and assignment of sparse matrices. It leverages CombBLAS’s core distributed sparse matrix data structures.

Operations in HipPerm :
HipPerm: Reordering rows/columns of large sparse matrices for graph and HPC applications.
HipExtract: Extracting submatrix of sparse matrix corresponding to row and columns selection indices.
HipAssign: Assigning a sparse matrix to a large sparse matrix.


**For reproducibility:** please use the branch `toms-reproducibility`.

**How to run (quick start):**

## 🔨 Build Instructions

HipPerm builds on top of **CombBLAS**. Use the provided `build.sh` script:

```bash
./build.sh

You can overwrite the compiler by seeting the environment variables before running the script like this:
```bash
CC=mpicc CXX=mpicxx ./build.sh


## Running the Demo

To reproduce the default experiment on the included `dolphins.mtx` dataset:

```bash
./run_experiment.sh

To see available options and parameter explanations:
./run_experiment.sh --help




