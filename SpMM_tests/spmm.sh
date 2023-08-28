rn50="rn50/random_pruning"
matrix="bottleneck_2_block_group3_5_1.smtx"
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

opt="0 1 0 1"
#echo -e "Evaluation perf for different precisions: N = $N, Iteration = 1024 \n"
echo -e "sparsity,L_pre,R_pre,vec_length,m,n,k,spmm_time"
for LR in "${LRs[@]}"; do
    for sparsity in "${sparsities[@]}"; do
        file=$rn50/$sparsity/$matrix
        for V in "${Vs[@]}"; do
            #echo -e "Matrix: '$file' with sparsity $sparsity\n"
            ./${op}_benchmark $dataset_dir/$file $N $V $opt $LR
        done
    done
done

