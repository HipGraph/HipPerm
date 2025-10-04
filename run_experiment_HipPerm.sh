#!/usr/bin/env bash
# demo for running HipPerm permutation2

set -euo pipefail

EXE="CombBLAS/_build/Applications/HipPerm/permutation2"
DATASET="datasets/dolphins.mtx"
TASKS=${TASKS:-4}
THREADS=${THREADS:-2}

# Choose launcher: env override > auto-detect
LAUNCHER="${LAUNCHER:-}"
if [[ -z "${LAUNCHER}" ]]; then
  if [[ -n "${SLURM_JOB_ID:-}" ]] || command -v srun >/dev/null 2>&1; then
    LAUNCHER="mpirun"
  else
    LAUNCHER="srun"
  fi
fi

usage() {
  cat <<USAGE
Usage: ./run_experiment_HipPerm.sh [--help]

Runs the default permutation2 demo on $DATASET

Launcher (auto-detected = $LAUNCHER). Override with:
  LAUNCHER=srun   ./run_experiment_HipPerm.sh
  LAUNCHER=mpirun ./run_experiment_HipPerm.sh

You can also override tasks/threads via env:
  TASKS=8 THREADS=2 ./run_experiment_HipPerm.sh

Commands:
  srun  : srun -N 1 -n \$TASKS -c \$THREADS $EXE -I mm -M <dataset> -base 1 -pvec 0 -invertPvec 0 -rcm 0
  mpirun: OMP_NUM_THREADS=\$THREADS mpirun -np \$TASKS $EXE -I mm -M <dataset> -base 1 -pvec 0 -invertPvec 0 -rcm 0

  -I <input type>     Input type: "mm" = Matrix Market (.mtx), "triples" = edge list (.txt)
  -M <path>           Path to input matrix file
  -base <0|1>         Indexing convention: 0 = zero-based, 1 = one-based
  -pvec <0|1>         0 = randomly generate permutation vector
                      1 = read permutation vector from file
  -P <path>           Path to permutation vector file (used if -pvec 1)
  -invertPvec <0|1>   1 = invert the permutation vector, 0 = do not
  -rcm <0|1>          0 = no RCM reordering,
                      1 = apply Reverse Cuthill–McKee reordering
USAGE
}

if [[ "${1:-}" == "--help" ]]; then usage; exit 0; fi

mkdir -p logs artifacts

echo "[Run] dataset=$DATASET tasks=$TASKS threads=$THREADS launcher=$LAUNCHER"
if [[ "$LAUNCHER" == "srun" ]]; then
  srun -N 1 -n "$TASKS" -c "$THREADS" "$EXE" \
    -I mm -M "$DATASET" -base 1 -pvec 0 -invertPvec 0 -rcm 0 \
    2>&1 | tee logs/permutation_default.log
elif [[ "$LAUNCHER" == "mpirun" ]]; then
  OMP_NUM_THREADS="$THREADS" mpirun -np "$TASKS" "$EXE" \
    -I mm -M "$DATASET" -base 1 -pvec 0 -invertPvec 0 -rcm 0 \
    2>&1 | tee logs/permutation_default.log
else
  echo "[ERR] Unknown LAUNCHER='$LAUNCHER' (use LAUNCHER=srun or LAUNCHER=mpirun)"; exit 1
fi

echo
echo "[Done] Log written to logs/permutation_default.log"

