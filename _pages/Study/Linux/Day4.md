---
title: "Day4 : Deep Learning"
tags:
    - Study
    - Language
date: "2025-06-26"
thumbnail: "/assets/img/thumbnail/Linux_logo.png"
bookmark: true
---

# 📌 Deep Learning란?
---
퍼셉트론(Perceptron)은 생물학적 뉴런을 수학적으로 모델링한 **인공 뉴런 모델**로,...

---

### 🔧 구조 (Perceptron Structure)

```
입력(x) → 가중치(w) → 가중합(∑) → 활성화 함수(f) → 출력(y)
```






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

aaaaaa