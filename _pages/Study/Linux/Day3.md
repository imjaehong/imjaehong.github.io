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

### 📘 수식 표현



---

### 🎯 요약

- 퍼셉트론은 **이진 분류 문제**를 해결할 수 있는 가장 기본적인 신경망 구조이다.
- 학습을 통해 입력 신호의 중요도를 나타내는 **가중치**가 조정된다.
- 단층 퍼셉트론은 **선형 분리 가능한 문제**만 해결할 수 있다.

# 👨‍💻 실습
---

### 💡 Code : AND Gate Perceptron

```py
# AND Gate Perceptron
import numpy as np
import matplotlib.pyplot as plt

class Perceptron:
def __init__(self, input_size, lr=0.1, epochs=10):
    self.weights = np.zeros(input_size)   # 입력 개수만큼 0으로 초기화된 가중치
    self.bias = 0                          # 바이어스 초기값 0
    self.lr = lr                           # 학습률 (learning rate)
    self.epochs = epochs                   # 학습 반복 횟수
    self.errors = []                       # epoch별 오류 저장 리스트

    def activation(self, x):
    return np.where(x > 0, 1, 0)           # 단위 계단 함수

    def predict(self, x):
    linear_output = np.dot(x, self.weights) + self.bias  # 선형 조합
    return self.activation(linear_output)                # 활성화 함수 적용

    def train(self, X, y):
    for epoch in range(self.epochs):
        total_error = 0
        for xi, target in zip(X, y):             # 각 데이터 샘플(xi)과 정답(target)
            prediction = self.predict(xi)        # 예측
            update = self.lr * (target - prediction)  # 오차만큼 업데이트
            self.weights += update * xi
            self.bias += update
            total_error += int(update != 0.0)     # 업데이트 발생 여부 저장
        self.errors.append(total_error)
        print(f"Epoch {epoch+1}/{self.epochs}, Errors: {total_error}")

# AND 게이트 데이터
X_and = np.array([[0,0],[0,1],[1,0],[1,1]])
y_and = np.array([0,0,0,1])

# 퍼셉트론 모델 훈련
ppn_and = Perceptron(input_size=2)
ppn_and.train(X_and, y_and)

# 예측 결과 확인
print("\nAND Gate Test:")
for x in X_and:
    print(f"Input: {x}, Predicted Output: {ppn_and.predict(x)}")
```

### ✅ Result: AND Gate Perceptron

```
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
```

### 💬 Comment: AND Gate Perceptron
- 퍼셉트론이 어떻게 논리 연산(AND)을 학습하는지 직관적으로 이해할 수 있었다.
- 초기 가중치가 전부 0인데도 반복 학습을 통해 원하는 출력을 만들어낸다는 점이 흥미로웠다.
- 출력이 0 또는 1로만 나오는 이유는 활성화 함수가 계단 함수이기 때문임을 알게 되었다.
- Epoch를 거치면서 오류가 줄어드는 과정을 통해 학습이 잘 진행되고 있음을 확인할 수 있었다.
- 단층 퍼셉트론이라서 선형 분리 문제(AND)는 잘 해결되지만, XOR처럼 비선형 문제는 학습이 안될 것 같다는 의문이 생겼다.

---

### 💡 Code : 경계 결정 시각화

```py
# 경계 결정 시각화
from matplotlib.colors import ListedColormap

def plot_decision_boundary(X, y, model):
    cmap_light = ListedColormap(['#FFAAAA', '#AAAAFF'])
    cmap_bold = ListedColormap(['#FF0000', '#0000FF'])

    h = .02  # mesh grid 간격

    x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1
    y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
    xx, yy = np.meshgrid(np.arange(x_min, x_max, h),
                         np.arange(y_min, y_max, h))

    Z = model.predict(np.c_[xx.ravel(), yy.ravel()])
    Z = Z.reshape(xx.shape)

    plt.figure(figsize=(8, 6))
    plt.contourf(xx, yy, Z, cmap=cmap_light)

    # 실제 데이터 포인트 표시
    plt.scatter(X[:, 0], X[:, 1], c=y, cmap=cmap_bold,
                edgecolor='k', s=100, marker='o')
    plt.xlabel('Input 1')
    plt.ylabel('Input 2')
    plt.title('Perceptron Decision Boundary')
    plt.show()

# AND 게이트 결정 경계 시각화
plot_decision_boundary(X_and, y_and, ppn_and)
```

### ✅ Result: 경계 결정 시각화

![alt text](<../../../assets/img/Linux/경계 결정 시각화.png> "경계 결정 시각화")

---

### 💡 Code : 오류 시각화

```py
# 오류 시각화
plt.figure(figsize=(8, 5))
plt.plot(range(1, len(ppn_and.errors) + 1), ppn_and.errors, marker='o')
plt.xlabel('Epochs')
plt.ylabel('Number of Errors')
plt.title('Perceptron Learning Error Over Epochs (AND Gate)')
plt.grid(True)
plt.show()
```

### ✅ Result: 오류 시각화

![alt text](<../../../assets/img/Linux/오류 시각화.png> "오류 시각화")

---

