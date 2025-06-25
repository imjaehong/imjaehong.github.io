---
title: "Day3 : Perceptron"
tags:
    - Study
    - Language
date: "2025-06-25"
thumbnail: "/assets/img/thumbnail/Linux_logo.png"
bookmark: true
---

# 📌 Perceptron란?
---
퍼셉트론(Perceptron)은 생물학적 뉴런을 수학적으로 모델링한 **인공 뉴런 모델**로, 여러 입력 신호를 받아 각 입력에 대한 **가중치(Weight)**를 곱한 후, 이들의 **가중합(Weighted Sum)**을 계산하고, **활성화 함수(Activation Function)**를 통해 최종 출력을 결정하는 구조이다.

---

### 🔧 구조 (Perceptron Structure)

```
입력(x) → 가중치(w) → 가중합(∑) → 활성화 함수(f) → 출력(y)
```

- **입력 (Input)**: AND, OR 등 논리 연산을 위한 입력 신호.
- **가중치 (Weight)**: 입력 신호의 중요도를 결정하며, 학습을 통해 조정됨.
- **가중합 (Weighted Sum)**: 각 입력과 그에 대응하는 가중치의 곱을 모두 더한 값.
- **활성화 함수 (Activation Function)**: 가중합이 임계값을 넘으면 1, 넘지 못하면 0을 출력하는 함수. 대표적으로 단위 계단 함수 사용.
- **출력 (Output)**: 최종 결과값 (보통 0 또는 1의 이진 출력).

---

### 🎯 요약

- 퍼셉트론은 **이진 분류 문제**를 해결할 수 있는 가장 기본적인 신경망 구조이다.
- 학습을 통해 입력 신호의 중요도를 나타내는 **가중치**가 조정된다.
- 단층 퍼셉트론은 **선형 분리 가능한 문제**만 해결할 수 있다.

# 👨‍💻 실습
---

### 💡 Code : AND & OR & NAND & XOR Gate Perceptron

```py
# AND & OR & NAND & XOR Gate Perceptron
import numpy as np
import matplotlib.pyplot as plt

class Perceptron:
    def __init__(self, input_size, lr=0.1, epochs=10):
        self.weights = np.zeros(input_size)
        self.bias = 0
        self.lr = lr
        self.epochs = epochs
        self.errors = []

    def activation(self, x):
        return np.where(x > 0, 1, 0)

    def predict(self, x):
        linear_output = np.dot(x, self.weights) + self.bias
        return self.activation(linear_output)

    def train(self, X, y):
        for epoch in range(self.epochs):
            total_error = 0
            for xi, target in zip(X, y):
                prediction = self.predict(xi)
                update = self.lr * (target - prediction)
                self.weights += update * xi
                self.bias += update
                total_error += int(update != 0.0)
            self.errors.append(total_error)
            print(f"Epoch {epoch+1}/{self.epochs}, Errors: {total_error}")

# AND 게이트 데이터 및 학습
X_and = np.array([[0,0],[0,1],[1,0],[1,1]])
y_and = np.array([0,0,0,1])

print(" AND Gate Training")
ppn_and = Perceptron(input_size=2)
ppn_and.train(X_and, y_and)

print("\n AND Gate Test:")
for x in X_and:
    print(f"Input: {x}, Predicted Output: {ppn_and.predict(x)}")

# OR 게이트 데이터 및 학습
X_or = np.array([[0,0],[0,1],[1,0],[1,1]])
y_or = np.array([0,1,1,1])

print("\n OR Gate Training")
ppn_or = Perceptron(input_size=2)
ppn_or.train(X_or, y_or)

print("\n OR Gate Test:")
for x in X_or:
    print(f"Input: {x}, Predicted Output: {ppn_or.predict(x)}")

# NAND 게이트 데이터 및 학습
X_nand = np.array([[0,0],[0,1],[1,0],[1,1]])
y_nand = np.array([1,1,1,0])  # AND와 반대

print("\n NAND Gate Training")
ppn_nand = Perceptron(input_size=2)
ppn_nand.train(X_nand, y_nand)

print("\n NAND Gate Test:")
for x in X_nand:
    print(f"Input: {x}, Predicted Output: {ppn_nand.predict(x)}")

# XOR 게이트 데이터 및 학습
X_xor = np.array([[0,0],[0,1],[1,0],[1,1]])
y_xor = np.array([0,1,1,0])  # 선형 분리 불가능

print("\n XOR Gate Training")
ppn_xor = Perceptron(input_size=2)
ppn_xor.train(X_xor, y_xor)

print("\n XOR Gate Test:")
for x in X_xor:
    print(f"Input: {x}, Predicted Output: {ppn_xor.predict(x)}")
```

### ✅ Result: AND Gate Perceptron

```
 AND Gate Training
Epoch 1/10, Errors: 1
Epoch 2/10, Errors: 3
Epoch 3/10, Errors: 3
Epoch 4/10, Errors: 2
Epoch 5/10, Errors: 1
Epoch 6/10, Errors: 0
Epoch 7/10, Errors: 0
Epoch 8/10, Errors: 0
Epoch 9/10, Errors: 0
Epoch 10/10, Errors: 0

 AND Gate Test:
Input: [0 0], Predicted Output: 0
Input: [0 1], Predicted Output: 0
Input: [1 0], Predicted Output: 0
Input: [1 1], Predicted Output: 1

 OR Gate Training
Epoch 1/10, Errors: 1
Epoch 2/10, Errors: 2
Epoch 3/10, Errors: 1
Epoch 4/10, Errors: 0
Epoch 5/10, Errors: 0
Epoch 6/10, Errors: 0
Epoch 7/10, Errors: 0
Epoch 8/10, Errors: 0
Epoch 9/10, Errors: 0
Epoch 10/10, Errors: 0

 OR Gate Test:
Input: [0 0], Predicted Output: 0
Input: [0 1], Predicted Output: 1
Input: [1 0], Predicted Output: 1
Input: [1 1], Predicted Output: 1

 NAND Gate Training
Epoch 1/10, Errors: 2
Epoch 2/10, Errors: 3
Epoch 3/10, Errors: 3
Epoch 4/10, Errors: 0
Epoch 5/10, Errors: 0
Epoch 6/10, Errors: 0
Epoch 7/10, Errors: 0
Epoch 8/10, Errors: 0
Epoch 9/10, Errors: 0
Epoch 10/10, Errors: 0

 NAND Gate Test:
Input: [0 0], Predicted Output: 1
Input: [0 1], Predicted Output: 1
Input: [1 0], Predicted Output: 1
Input: [1 1], Predicted Output: 0

 XOR Gate Training
Epoch 1/10, Errors: 2
Epoch 2/10, Errors: 3
Epoch 3/10, Errors: 4
Epoch 4/10, Errors: 4
Epoch 5/10, Errors: 4
Epoch 6/10, Errors: 4
Epoch 7/10, Errors: 4
Epoch 8/10, Errors: 4
Epoch 9/10, Errors: 4
Epoch 10/10, Errors: 4

 XOR Gate Test:
Input: [0 0], Predicted Output: 1
Input: [0 1], Predicted Output: 1
Input: [1 0], Predicted Output: 0
Input: [1 1], Predicted Output: 0
```



### 💡 Code : # 경계 결정 시각화 함수 (AND, OR, NAND, XOR)

```py
# 경계 결정 시각화 함수 (AND, OR, NAND, XOR)
from matplotlib.colors import ListedColormap
import matplotlib.pyplot as plt
import numpy as np

def plot_decision_boundary(X, y, model, title='Perceptron Decision Boundary'):
    cmap_light = ListedColormap(['#FFDDDD', '#DDDDFF'])  # 배경 색상
    cmap_bold = ListedColormap(['#FF0000', '#0000FF'])   # 점 색상

    h = .02  # mesh grid 간격

    x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1
    y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
    xx, yy = np.meshgrid(np.arange(x_min, x_max, h),
                         np.arange(y_min, y_max, h))

    Z = model.predict(np.c_[xx.ravel(), yy.ravel()])
    Z = Z.reshape(xx.shape)

    plt.figure(figsize=(6, 5))
    plt.contourf(xx, yy, Z, cmap=cmap_light)
    plt.scatter(X[:, 0], X[:, 1], c=y, cmap=cmap_bold,
                edgecolor='k', s=100, marker='o')
    plt.xlabel('Input 1')
    plt.ylabel('Input 2')
    plt.title(title)
    plt.grid(True)
    plt.show()

# AND 게이트 결정 경계 시각화
plot_decision_boundary(X_and, y_and, ppn_and, title='AND Gate Decision Boundary')

# OR 게이트 결정 경계 시각화
plot_decision_boundary(X_or, y_or, ppn_or, title='OR Gate Decision Boundary')

# NAND 게이트 결정 경계 시각화
plot_decision_boundary(X_nand, y_nand, ppn_nand, title='NAND Gate Decision Boundary')

# XOR 게이트 결정 경계 시각화
plot_decision_boundary(X_xor, y_xor, ppn_xor, title='XOR Gate Decision Boundary')
```

### ✅ Result: 경계 결정 시각화

![alt text](<../../../assets/img/Linux/AND 게이트 결정 경계 시각화.png> "AND 게이트 결정 경계 시각화")
![alt text](<../../../assets/img/Linux/OR 게이트 결정 경계 시각화.png> "OR 게이트 결정 경계 시각화")
![alt text](<../../../assets/img/Linux/NAND 게이트 결정 경계 시각화.png> "NAND 게이트 결정 경계 시각화")
![alt text](<../../../assets/img/Linux/XOR 게이트 결정 경계 시각화.png> "XOR 게이트 결정 경계 시각화")

---

### 💡 Code : # 오류 시각화 (AND, OR, NAND, XOR)

```py
# 오류 시각화 (AND, OR, NAND, XOR)
plt.figure(figsize=(8, 5))
plt.plot(range(1, len(ppn_and.errors) + 1), ppn_and.errors, marker='o', label='AND Gate')
plt.plot(range(1, len(ppn_or.errors) + 1), ppn_or.errors, marker='s', label='OR Gate')
plt.plot(range(1, len(ppn_nand.errors) + 1), ppn_nand.errors, marker='^', label='NAND Gate')
plt.plot(range(1, len(ppn_xor.errors) + 1), ppn_xor.errors, marker='x', label='XOR Gate')
plt.xlabel('Epochs')
plt.ylabel('Number of Errors')
plt.title('Perceptron Learning Error Over Epochs')
plt.legend()
plt.grid(True)
plt.show()
```

### ✅ Result: 오류 시각화

![alt text](<../../../assets/img/Linux/오류 시각화.png> "오류 시각화")

### 💬 Comment: AND Gate Perceptron
- 퍼셉트론이 어떻게 논리 연산(AND)을 학습하는지 직관적으로 이해할 수 있었다.

---

