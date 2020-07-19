
具体来说.
$$
\begin{array}{c}
\begin{cases}
x_0 = \text{var: }xi\\
x_1 = x_0-y_1\\
x_2 = x_1-y_2 = x-y_1-y_2\\
x_3 = x_2-y_3 = x-y_1-y_2-y_3\\
\dots\\
x_i = x_{i-1}-y_i = x-\sum_{j = 1}^iy_i\\
\dots\\
x_{n-1} = x_0+y_0 = x-\sum_{j = 1}^{n-1}y_i
\end{cases}\\
\text{let } A_k = \sum_{i = 1}^k y_k\ A_0 = 0\\
x_i = x-A_i \Rightarrow \min(\sum |x-A_i|)
\end{array}
$$
