---
title: "Day3 : ?"
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

\[
y = f\left( \sum_{i=0}^{m} w_i x_i \right)
\]

- 여기서 \( x_0 = 1 \) (바이어스), \( w_0 \)는 바이어스 항에 대한 가중치  
- \( f(z) = \begin{cases}
1 & \text{if } z \geq 0 \\
0 & \text{if } z < 0
\end{cases} \)

---

### ✅ 요약

- 퍼셉트론은 **이진 분류 문제**를 해결할 수 있는 가장 기본적인 신경망 구조이다.
- 학습을 통해 입력 신호의 중요도를 나타내는 **가중치**가 조정된다.
- 단층 퍼셉트론은 **선형 분리 가능한 문제**만 해결할 수 있다.
