import numpy as np
import math

A = [0, 1, 0]

angle = 30
cos_t = math.cos(angle * math.pi / 180)
sin_t = math.sin(angle * math.pi / 180)
B = [[1,     0,      0],
     [0, cos_t, -sin_t],
     [0, sin_t, cos_t]]

print(np.matmul(A, B));
