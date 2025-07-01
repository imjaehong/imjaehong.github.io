---
title: "Day7 : HARIBO_Mini_Project"
tags:
    - Study
    - Language
date: "2025-07-01"
thumbnail: "/assets/img/thumbnail/Linux_logo.png"
bookmark: true
---

# 구글 코랩에서 코드 작성

기존 모델에서
1. 데이터 증강 적용
2. 전이학습 (Transfer Learning) 도입
3. 모델 개선 (Dropout 추가 / 레이어 확장)
4. EarlyStopping, ModelCheckpoint 적용
5. 데이터 증강 강화
적용

```py
import matplotlib.pyplot as plt
import numpy as np
import os
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from tensorflow.keras.applications import MobileNetV2
from tensorflow.keras import models, layers
from tensorflow.keras.optimizers import RMSprop
from tensorflow.keras.callbacks import EarlyStopping, ModelCheckpoint

# ✅ 구글 드라이브 마운트
from google.colab import drive
drive.mount('/content/drive')

# ✅ 경로 설정
dataset_path = '/content/drive/MyDrive/haribo_dataset'
model_save_path = '/content/drive/MyDrive/haribo_model.h5'

# ✅ 데이터 증강 설정
datagen = ImageDataGenerator(
    rescale=1./255,              # 픽셀 값을 0~1 범위로 정규화
    validation_split=0.2,        # 전체 데이터 중 20%를 검증용으로 사용
    rotation_range=90,           # 최대 ±90도 범위 내에서 무작위 회전
    width_shift_range=0.1,       # 전체 너비의 10%만큼 좌우 이동
    height_shift_range=0.1,      # 전체 높이의 10%만큼 상하 이동
    shear_range=0.1,             # 전단 변환 (이미지를 기울이는 효과)
    zoom_range=0.1,              # 10% 범위 내 무작위 확대/축소
    horizontal_flip=True,        # 이미지를 좌우로 무작위 반전
    fill_mode='nearest'          # 변환 후 생긴 빈 영역을 가장 가까운 픽셀로 채움
)

# ✅ 데이터 로딩
train_generator = datagen.flow_from_directory(
    dataset_path,
    target_size=(96, 96),
    batch_size=32,
    class_mode='categorical',
    subset='training',
    shuffle=True
)

val_generator = datagen.flow_from_directory(
    dataset_path,
    target_size=(96, 96),
    batch_size=32,
    class_mode='categorical',
    subset='validation',
    shuffle=True
)

# ✅ 클래스 이름 자동 추출
class_names = list(train_generator.class_indices.keys())
print("클래스 인덱스:", train_generator.class_indices)

# ✅ MobileNetV2 기반 모델 구성
base_model = MobileNetV2(input_shape=(96, 96, 3), include_top=False, weights='imagenet')
base_model.trainable = False

model = models.Sequential([
    base_model,
    layers.GlobalAveragePooling2D(),
    layers.Dense(128, activation='relu'),
    layers.Dropout(0.5),
    layers.Dense(len(class_names), activation='softmax')  # 클래스 수 자동 반영
])

model.compile(optimizer=Adam(learning_rate=1e-4),
              loss='categorical_crossentropy',
              metrics=['accuracy'])

# ✅ 콜백 설정
early_stop = EarlyStopping(monitor='val_loss', patience=5, restore_best_weights=True)
checkpoint = ModelCheckpoint('best_model.h5', save_best_only=True)

# ✅ 학습 실행
history = model.fit(
    train_generator,
    validation_data=val_generator,
    epochs=50,
    callbacks=[early_stop, checkpoint],
    verbose=2
)

# ✅ 결과 시각화
acc = history.history['accuracy']
val_acc = history.history['val_accuracy']
loss = history.history['loss']
val_loss = history.history['val_loss']
epochs = range(len(acc))

plt.plot(epochs, acc, 'bo', label='Training acc')
plt.plot(epochs, val_acc, 'b', label='Validation acc')
plt.title('Training and Validation Accuracy')
plt.legend()
plt.show()

plt.plot(epochs, loss, 'bo', label='Training loss')
plt.plot(epochs, val_loss, 'b', label='Validation loss')
plt.title('Training and Validation Loss')
plt.legend()
plt.show()

# ✅ 학습 이미지 예시
x_batch, y_batch = next(train_generator)
plt.figure(figsize=(10, 10))
for i in range(25):
    plt.subplot(5, 5, i + 1)
    plt.xticks([]); plt.yticks([]); plt.grid(False)
    plt.imshow(x_batch[i])
    label_idx = np.argmax(y_batch[i])
    plt.xlabel(class_names[label_idx])
plt.tight_layout()
plt.show()

# ✅ 모델 저장 (.h5 파일)
model.save(model_save_path)
print(f"모델이 저장되었습니다: {model_save_path}")
```

![alt text](../../../assets/img/Linux/epoch32.png)



# 터미널 작업 적어야됨




![alt text](<../../../assets/img/Linux/validation accuracy.png>)
![alt text](<../../../assets/img/Linux/validation loss.png>)
![alt text](<../../../assets/img/Linux/image ex.png>)


































# 결과

![alt text](../../../assets/img/Linux/haribo.jpg)
![alt text](../../../assets/img/Linux/heart.png)
![alt text](../../../assets/img/Linux/heart_b.png)
![alt text](../../../assets/img/Linux/ring.png)
![alt text](../../../assets/img/Linux/ring_b.png)
![alt text](../../../assets/img/Linux/cola.png)
![alt text](../../../assets/img/Linux/cola_b.png)
![alt text](../../../assets/img/Linux/egg.png)
![alt text](../../../assets/img/Linux/egg_b.png)
![alt text](../../../assets/img/Linux/bear.png)
![alt text](../../../assets/img/Linux/bear_b.png)
