---
title: "Day3 : Perceptron"
tags:
    - Study
    - Language
date: "2025-06-25"
thumbnail: "/assets/img/thumbnail/Linux_logo.png"
bookmark: true
---

# Report : Perceptron
---
## 1. 퍼셉트론이란?

- 생물학적 뉴런을 모방한 가장 기본적인 인공신경망
- 입력 값 × 가중치 + 바이어스를 통해 선형결합을 만들고, 단위 계단 함수(step function) 로 0 또는 1을 출력
- 간단한 구조지만, 선형 분리 가능한 문제는 완벽하게 해결할 수 있음

> 하나의 직선으로 나눌 수 있으면 → 선형 분리 가능
> 단위 계산 함수 : 입력값이 0보다 크면 1을 출력하고, 그 외엔 0을 출력하는 함수

---

## 2. 퍼셉트론 학습 방식 (코드 중심)

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

#### 2-1. train() 함수 호출

```py
ppn_and.train(X_and, y_and)
```

- X_and: 입력 데이터 배열 (예: [0,0], [1,1] 등)
- y_and: 각 입력에 대한 정답 출력값

#### 2-2. 전체 반복 (epoch) 시작

```py
for epoch in range(self.epochs):  # 총 10번 반복
```

- 한 epoch는 전체 데이터를 한 번 학습하는 주기
- 총 10번 반복하면서 조금씩 가중치를 조정

#### 2-3. 한 epoch 내 샘플 반복

```py
for xi, target in zip(X, y):
```

- 각 데이터 xi와 정답 target을 하나씩 꺼내 순차 학습

#### 2-4. 예측 과정

```py
prediction = self.predict(xi)
```

- predict() 내부에서 다음 순서로 작동:
    - linear_output = w·x + b
    - activation() → 0 또는 1 반환

#### 2-5. 오차 계산 및 가중치/바이어스 업데이트

```py
update = self.lr * (target - prediction)
```

- 예측이 정답보다 작으면 → update > 0: 가중치 증가
- 예측이 정답보다 크면 → update < 0: 가중치 감소
- 예측이 정확하면 → update == 0: 가중치 변화 없음

```py
self.weights += update * xi
self.bias += update
```

- 각 입력 값에 따라 가중치 조정
- 항상 바이어스도 같이 업데이트

#### 2-6. 에러 카운트

```py
total_error += int(update != 0.0)
```

- 예측이 틀렸을 때만 에러로 집계

#### 2-7. 학습 결과 출력

```py
self.errors.append(total_error)
print(f"Epoch {epoch+1}/{self.epochs}, Errors: {total_error}")
```

- 학습이 진행될수록 Errors가 줄어드는지 확인 가능
- 하지만 XOR은 줄지 않음 → 선형 분리 불가능 문제

#### 2-8. 최종 예측 결과 확인

- 각 게이트에 대해 학습이 끝나면 다음을 수행:

```py
for x in X_and:
    print(f"Input: {x}, Predicted Output: {ppn_and.predict(x)}")
```

- 학습된 가중치로 새로운 입력을 테스트해보는 과정

#### 2-9. 요약: 퍼셉트론 학습 흐름

```
입력 X, 정답 y
→ 가중합 계산 (w·x + b)
→ 계단 함수로 예측
→ 오차 계산 (target - predict)
→ w, b 업데이트
→ 에러 기록
→ epoch 반복
→ 학습 완료 후 테스트
```

---

## 3. XOR 게이트가 퍼셉트론으로 안 되는 이유
- 퍼셉트론은 직선 하나로 출력을 나누는 모델
- XOR은 어떤 직선으로도 0과 1을 나눌 수 없음
- 즉, 선형 분리 불가능 문제 → 퍼셉트론 한계

> 해결책: 다층 퍼셉트론 (MLP)
> 비선형성을 처리하기 위해 은닉층 + 비선형 활성화 함수 (예: sigmoid, ReLU)를 활용하고,
오차 역전파(Backpropagation)로 학습함