rn50="$dataset_dir/rn50/random_pruning"
file="bottleneck_2_block_group3_5_1.smtx"
op="spmm"
N=512
LRs=(
    "16 16"
    "16 8"
    "16 4"
    "12 4"
    "8 8"
    "8 4"
    "4 4"
)
sparsities=(0.5 0.7 0.8 0.9 0.95 0.98)
Vs=(2 4 8)

opt="0 1 1 1"
echo -e "Evaluation perf for different precisions: N = $N, Iteration = 1024 \n"
for LR in "${LRs[@]}"; do
    echo -e "LR: $LR"
    for sparsity in "${sparsities[@]}"; do
        for V in "${Vs[@]}"; do
            ./${op}_benchmark $rn50/$sparsity/$file $N $V $opt $LR
        done
    done
done

