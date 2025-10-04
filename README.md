HipPerm is a distributed memory framework we developed on top of CombBLAS to perform permutation, extraction, and assignment of sparse matrices. It leverages CombBLAS’s core distributed sparse matrix data structures.

Operations in HipPerm :
HipPerm: Reordering rows/columns of large sparse matrices for graph and HPC applications.
HipExtract: Extracting submatrix of sparse matrix corresponding to row and columns selection indices.
HipAssign: Assigning a sparse matrix to a large sparse matrix.


⚠️ For reproducibility please use the branch:
[toms-reproducibility](https://github.com/HipGraph/HipPerm/tree/toms-reproducibility)

Clone and checkout with:

```bash
git clone https://github.com/HipGraph/HipPerm.git
cd HipPerm
git checkout toms-reproducibility
