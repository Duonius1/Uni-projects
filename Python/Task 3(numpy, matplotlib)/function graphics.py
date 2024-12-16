"""
Created on Tue Dec 12 22:38:27 2023
"""

import matplotlib.pyplot as plt
import numpy as np

sin_x = np.linspace(-6, 6, 1000)
sin_y = np.sin(np.square(sin_x))

plt.title("f(x) = sin($x^2$)")
plt.xlabel("x")
plt.ylabel("y")
plt.xlim(-6, 6)
plt.plot(sin_x, sin_y, linestyle='dotted', color='blue')
plt.savefig("sin_x2.pdf", format = "pdf")
plt.show()
plt.close()

hip_x = np.linspace(-5, 5, 100000)
hip_y1 = 1 / np.cbrt(hip_x)
hip_y2 = 1 / hip_x
hip_y3 = 1 / hip_x**2

plt.title("Hyperbolas")
plt.xlabel("x")
plt.ylabel("y")
plt.xlim(-5, 5)
plt.ylim(-15, 15)
plt.plot(hip_x, hip_y1, color='blue')
plt.plot(hip_x, hip_y2, color='orange', linestyle='dashed')
plt.plot(hip_x, hip_y3, color='green', linestyle='dotted')
plt.legend([r'$f_{1}(x)=\frac{1}{\sqrt[3]{x}}$', r'$f_{2}(x)=\frac{1}{x}$', r'$f_{3}(x)=\frac{1}{x^2}$'])
plt.savefig("hyperbola.pdf", format="pdf")
plt.show()
plt.close()