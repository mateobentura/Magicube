import re
import six
import csv
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd

order = ['Pytorch-fp16', 'vectorSparse-fp16', 'Magicube-16b8b', 'Magicube-8b8b', 'Magicube-8b4b', 'Magicube-4b4b']
n2n_a_data = pd.read_csv('n2n_a.csv')
sns.set(rc={"lines.linewidth": 0.5})
sns.set(rc={'figure.figsize':(5, 3)})
g = sns.barplot(data=n2n_a_data, x="S0.9,Seq_l=4096,num_h=4", y="Latency(ms)", hue="algs", palette="Blues_d", hue_order=order, ci=95, capsize=.1)
#plt.xticks(rotation=20)
g.tick_params(labelsize=8)
g.set(ylim=(0, 25))
g.set_xlabel("S0.9,Seq_l=4096,num_h=4", fontsize=10)
plt.setp(g.get_legend().get_texts(), fontsize='6')
plt.setp(g.get_legend().get_title(), fontsize='6')
g.figure.savefig('./figs/Figure16-a.pdf')

