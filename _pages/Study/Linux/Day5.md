---
title: "Day5 : ??"
tags:
    - Study
    - Language
date: "2025-06-27"
thumbnail: "/assets/img/thumbnail/Linux_logo.png"
bookmark: true
---

# 🧠 딥러닝 개요
---

딥러닝은 인간의 뇌를 모방한 **인공신경망(ANN)**을 기반으로 한 기계학습 기술로, **다층 구조의 신경망**을 통해 복잡한 패턴을 학습하고 예측하는 데 사용된다.

---

### 🔍 인공신경망(ANN)의 개념

- **생물학적 뉴런 구조**에서 착안.
- 입력 → 가중치 → 활성화 함수 → 출력 흐름으로 동작.
- 각 신호의 강도는 **가중치(Weight)**로 표현됨.

---

### 🧬 딥러닝(Deep Learning)이란?

- 은닉층이 여러 개인 **심층 신경망(Deep Neural Network, DNN)**을 통해 학습하는 방식.
- **심층 학습(Deep Learning)**이라고도 함.

---

### 🛠️ 신경망 구성 요소

| 구성 요소 | 설명 |
| :--: | :--: |
| 입력층 | 학습 데이터가 들어오는 층 |
| 은닉층 | 가중합 계산 및 비선형 변환 수행 |
| 출력층 | 최종 예측값을 출력 |
| 가중치 | 입력의 중요도를 결정 |
| 편향 | 가중합에 더해지는 상수로 출력 조절 |

---

### ➕ 가중합 (Weighted Sum)

- 각 입력값 × 가중치 + 편향  
- 수식: **z = w₁x₁ + w₂x₂ + ... + b**

---

### ⚙️ 활성화 함수 (Activation Function)

| 함수명 | 특징 |
| :--: | :--: |
| **Sigmoid** | S자 형태, 출력값 [0, 1], 기울기 소실 문제 |
| **Tanh** | 출력 [-1, 1], 평균 0, sigmoid보다 우수 |
| **ReLU** | 0 이하 → 0, 0 초과 → 그대로 출력, 빠른 학습 |
| **LeakyReLU** | ReLU의 음수 입력 무반응 문제 해결 |
| **Softmax** | 확률 분포 출력, 다중 클래스 분류에 사용 |

---

### 🧭 학습 과정 (Training Flow)

1️⃣ 순전파 (Forward Propagation)
- 입력 → 은닉층 → 출력층으로 예측값 도출

2️⃣ 손실 함수 (Loss Function)
- 예측값과 실제값의 차이를 계산
  - 회귀: MSE
  - 분류: Cross Entropy

3️⃣ 옵티마이저 (Optimizer)
- 경사하강법 기반으로 **가중치 최적화**
- 전체/미니 배치 방식 사용

4️⃣ 역전파 (Backpropagation)
- 오차를 **역방향 전파**해 가중치 업데이트
- 각 층의 가중치에 대해 **미분값 기반 보정**

---

### 🧱 딥러닝 모델의 유형

| 유형 | 설명 |
| :--: | :--: |
| **DFN** (순방향 신경망) | 기본 구조, 고정 입력 처리 |
| **RNN** (순환 신경망) | 시계열 데이터 처리, 과거 정보 반영 |
| **LSTM** | RNN 개선, 장기 기억 유지 |
| **CNN** | 이미지 분석 특화, 합성곱 및 풀링 활용 |

---

### 🧠 CNN의 구조

- **합성곱층**: 필터를 통해 특징 추출
- **풀링층**: 데이터 크기 축소, 핵심 정보 보존
- **완전연결층**: 최종 분류 수행

---

### 🔄 비교 요약 (DFN vs RNN vs CNN)

| 항목 | DFN | RNN | CNN |
| :--: | :--: | :--: | :--: |
| 입력 | 정적 | 시계열 | 이미지/시계열 |
| 특징 | 단방향 | 순환 연결 | 지역적 특징 |
| 학습 | 쉬움 | 어려움 | 중간 |
| 효율 | 낮음 | 낮음 | 높음 |

---

### 💬 워드 임베딩 (Word Embedding)

| 방식 | 설명 |
| :--: | :--: |
| **One-hot Encoding** | 희소 벡터, 단순 구조 |
| **Word2Vec** | 주변 문맥 → 중심 단어 예측 (CBOW/Skip-gram) |
| **TF-IDF** | 단어 중요도 가중치 부여 |
| **FastText** | 부분 단어 기반, OOV 문제 해결 |
| **GloVe** | 단어 동시 등장 통계 기반 |
| **ELMo** | 문맥에 따라 벡터가 달라지는 동적 임베딩 |

---

### 🎨 적대적 생성 신경망 (GAN)

- 두 네트워크가 경쟁:
  - **Generator**: 진짜 같은 가짜 데이터 생성
  - **Discriminator**: 진짜와 가짜 구별
- 예술, 이미지 생성 등에서 강력한 성능

---

### ✅ 요약

- 딥러닝은 **인공신경망을 확장한 구조**로, 다양한 문제 해결에 적용 가능
- **활성화 함수**, **학습 알고리즘**, **모델 구조**에 따라 성능이 좌우됨
- CNN, RNN, GAN, Word Embedding 등은 실전 문제에 맞는 딥러닝 기법 선택의 기준이 된다.

---

# 🛠️ 작업할 디렉토리 생성 및 환경 설정
---

```bash
# 1. 작업 디렉토리 생성
mkdir F_MNIST                  # 디렉토리 이름: F_MNIST
cd F_MNIST                     # 해당 디렉토리로 이동

# 2. 가상 환경 생성 및 활성화
python3 -m venv .fmnist        # 가상 환경 생성 (폴더 이름: .fmnist)
source .fmnist/bin/activate    # 가상 환경 활성화

# 3. 패키지 설치
pip install -U pip             # pip 최신 버전으로 업그레이드
pip install tensorflow         # TensorFlow (딥러닝 프레임워크)
pip install matplotlib         # Matplotlib (시각화 라이브러리)
pip install PyQt5              # PyQt5 (Matplotlib GUI 백엔드용)
pip install scikit_learn       # scikit-learn (머신러닝 및 평가 도구)

# 4. Qt GUI 백엔드 설정 (Wayland 환경에서 필수)
export QT_QPA_PLATFORM=wayland # Qt GUI를 Wayland에서 정상 동작하게 설정
```

# 👨‍💻 실습
---

### 💡 Code : Fashion MNIST

```py
import tensorflow as tf
from tensorflow import keras

import numpy as np
import matplotlib
import matplotlib.pyplot as plt

# dataset load
fashion_mnist = keras.datasets.fashion_mnist

# spilt data (train / test)
(train_images, train_labels), (test_images, test_labels) = fashion_mnist.load_data()

print(train_images.shape)
print(train_labels.shape)
print(test_images.shape)
print(test_labels.shape)

class_names = ['T-shirt/top', 'Trouser', 'Pullover', 'Dress', 'Coat',
               'Sandal', 'Shirt', 'Sneaker', 'Bag', 'Ankle boot']
               
matplotlib.use('Qt5Agg')
NUM=20
plt.figure(figsize=(15,15))
plt.subplots_adjust(hspace=1)
for idx in range(NUM):
    sp = plt.subplot(5,5,idx+1)
    plt.imshow(train_images[idx])
    plt.title(f'{class_names[train_labels[idx]]}')
plt.show()

plt.figure()
plt.imshow(train_images[0])
plt.colorbar()
plt.grid(False)
plt.show()

# 간단한 이미지 전처리 (for ANN)
train_images = train_images / 255.0
test_images = test_images / 255.0

class_names = ['T-shirt/top', 'Trouser', 'Pullover', 'Dress', 'Coat',
               'Sandal', 'Shirt', 'Sneaker', 'Bag', 'Ankle boot']

plt.figure(figsize=(10,8))
for i in range(20):
    plt.subplot(4,5,i+1)
    plt.xticks([])
    plt.yticks([])
    plt.grid(False)
    plt.imshow(train_images[i], cmap=plt.cm.binary)
    plt.xlabel(class_names[train_labels[i]])
plt.show()

model = keras.Sequential ([
    keras.layers.Flatten(input_shape=(28,28)),
    keras.layers.Dense(128, activation='relu'),
    keras.layers.Dense(10, activation='softmax'),
])

model.summary()

model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

model.fit(train_images, train_labels, epochs=20)

predictions = model.predict(test_images)

predictions[0]

np.argmax(predictions[0])

test_labels[0]

def plot_image(i, predictions_array, true_label, img):
  predictions_array, true_label, img = predictions_array[i], true_label[i], img[i]
  plt.grid(False)
  plt.xticks([])
  plt.yticks([])

  plt.imshow(img, cmap=plt.cm.binary)

  predicted_label = np.argmax(predictions_array)
  if predicted_label == true_label:
    color = 'blue'
  else:
    color = 'red'

  plt.xlabel("{} {:2.0f}% ({})".format(class_names[predicted_label],
                                100*np.max(predictions_array),
                                class_names[true_label]),
                                color=color)

def plot_value_array(i, predictions_array, true_label):
  predictions_array, true_label = predictions_array[i], true_label[i]
  plt.grid(False)
  plt.xticks([])
  plt.yticks([])
  thisplot = plt.bar(range(10), predictions_array, color="#777777")
  plt.ylim([0, 1])
  predicted_label = np.argmax(predictions_array)

  thisplot[predicted_label].set_color('red')
  thisplot[true_label].set_color('blue')

num_rows = 5
num_cols = 3
num_images = num_rows*num_cols
plt.figure(figsize=(2*2*num_cols, 2*num_rows))
for i in range(num_images):
  plt.subplot(num_rows, 2*num_cols, 2*i+1)
  plot_image(i, predictions, test_labels, test_images)
  plt.subplot(num_rows, 2*num_cols, 2*i+2)
  plot_value_array(i, predictions, test_labels)
plt.show()

from sklearn.metrics import accuracy_score
print('accuracy score : ', accuracy_score(tf.math.argmax(predictions, -1), test_labels))
```
