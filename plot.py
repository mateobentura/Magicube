import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
import pandas as pd
import os

#Open and process Magicube CSV results (output of scripts)
magicube_df = pd.read_csv("SpMM_tests/results/spmm_results.csv")
magicube_df['Precisions']= 'L'+magicube_df["L_pre"].astype(str)+'R'+magicube_df["R_pre"].astype(str)+' (Magicube)'

#Open cuSparse results
cusparse_df = pd.read_csv("cuSparse/results/spmm_cuSparse.csv")
cusparse_df['L_pre']=8
cusparse_df['R_pre']=8
cusparse_df['Precisions']= "L8R8 (cuSaprse)"

#Concatenate Magicube and Cusparse results
res_df = pd.concat([magicube_df, cusparse_df], ignore_index=True, join='inner')
res_df=res_df.sort_values(by=['L_pre','R_pre'],ascending=False)

#Select only int8 precision results
res_df = res_df[res_df['Precisions'].isin(['L8R8 (Magicube)','L8R8 (cuSaprse)'])]

#Plot latency for each aglorithm, grouped by sparsity, then vector length
h, w = (5,5)
sns.set(rc={'figure.figsize':(w,h)})
g = sns.catplot(x="vec_length", y="spmm_time", hue="Precisions", col="sparsity", data=res_df,
                kind="bar", errorbar=None, height=h, aspect=w/h, col_wrap=3)

g.set_axis_labels("V","Latency (ms)")

#Save to ~
g.figure.savefig(os.path.join(os.getenv("HOME"),"SpMM_compare.pdf"))  
