rn50="rn50/random_pruning"
matrix="bottleneck_2_block_group3_5_1.smtx"
op="spmm"
Ns=(256)
sparsities=(0.5 0.7 0.8 0.9 0.95 0.98)
Vs=(2 4 8)
kernel=1
sorted=1
func=0
sparse=3
mixed=1
opt="$kernel $sorted $func $sparse $mixed"
echo -e "sparsity,vec_length,m_vec,m,n,k,spmm_time"
for N in "${Ns[@]}"; do
    #echo -e "Evaluation perf for different precisions: N = $N, Iteration = 1024 \n"
    #echo -e " "
    for sparsity in "${sparsities[@]}"; do
        file=$rn50/$sparsity/$matrix
        for V in "${Vs[@]}"; do
            #echo -e "Matrix: '$file' with sparsity $sparsity\n"
            ./${op}_benchmark $dataset_dir/$file $N $V $opt
        done
    done
done
