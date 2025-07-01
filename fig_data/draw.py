from h5py import File
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np

allocator_data=File("allocator_data.mat","r")

x_axis=allocator_data['n2_vec'][:]
y_0=allocator_data['p_lose'][:]
y_2k=allocator_data['p_lose_ins_2k'][:]
y_5k=allocator_data['p_lose_ins_5k'][:]
y_1w=allocator_data['p_lose_ins_1w'][:]

x_axis=np.squeeze(x_axis)
y_0=np.squeeze(y_0)
y_2k=np.squeeze(y_2k)
y_5k=np.squeeze(y_5k)
y_1w=np.squeeze(y_1w)

sns.set(style='white', font_scale=1.2)

# 画图
plt.figure(figsize=(8, 5))
sns.lineplot(x=x_axis, y=y_0, label='benchmark')
sns.lineplot(x=x_axis, y=y_2k, label='$p_f=2000$')
sns.lineplot(x=x_axis, y=y_5k, label='$p_f=5000$')
sns.lineplot(x=x_axis, y=y_1w, label='$p_f=10000$')

# 图例和标签
plt.title('Probability of system failure')
plt.xlabel('5 X ratio')
plt.ylabel('System failure probability')
#plt.legend(title='$$ value')
plt.tight_layout()
plt.savefig('DAC_allocator.pdf', format='pdf')
plt.show()