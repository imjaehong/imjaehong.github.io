---
title: "Day6 : CNN"
tags:
    - Study
    - Language
date: "2025-06-30"
thumbnail: "/assets/img/thumbnail/Linux_logo.png"
bookmark: true
---

# 📌 CNN란?
---
??
---

### <합성곱 층 - Convolution Layer>
- 적절한 크기의 kernel size를 찾는 게 중요함
- 보통 3x3 kernel 사용 → 작을수록 많은 feature map을 쌓는 경향 있음
- 보폭 stride가 1일 경우 한 칸씩 합성곱 연산 수행
- 즉, kernel 크기가 같아도 보폭 stride에 따라 feature map 크기는 달라짐
- 합성곱 층은 활성화 함수(ReLU)로 비선형성을 도입하여 복잡한 패턴 학습 가능

### <풀링 층 - Pooling Layer>
- feature map의 공간적 크기를 줄임
- 최대풀링층: 풀링 윈도우 내 최대값 리턴
- 평균풀링층: 풀링 윈도우 내 평균값 리턴
- 공간 정보를 요약하여 계산 비용을 줄이고 주요 특징을 보존

### <밀집층 - Fully Connected Layer>
- 가장 마지막에 flatten 층을 배치하여 지역적 특징(local feature map)을 1차원 벡터로 변환
- 변환된 feature vector를 fully_connected layer에 입력하여 최종 출력값 계산

### example flow
- 최종 출력값이 (0.7, 0)인 경우 → 정답이 (1, 0)이라면 0.3 오차 존재 이 오차를 줄이기 위해 kernel들의 가중치를 점진적으로 조정 가중치 변화 
- 알고리즘: 역전파(backpropagation), 경사하강법(gradient descent) 사용

### CNN 모델과 인간의 시각정보 처리과정의 유사점
- 인간의 시각 시스템도 시각 피질을 거치며 상위 영역으로 올라갈수록 feature 복잡도가 증가함
- CNN의 합성곱 층이 깊어질수록 더 복잡한 feature를 처리하는 구조와 유사

---

# 👨‍💻 실습
---

### 💡 Code : CNN Layer 구현

```py
import numpy as np
from PIL import Image
import matplotlib.pyplot as plt

# 합성곱 함수 구현
def conv(a, b): 
    c = np.array(a) * np.array(b)
    return np.sum(c)

# MaxPooling 함수 구현(한 개의 map 계산)
def MaxPooling(nimg):  # 2d input
    nimg = np.array(nimg)
    i0, j0 = nimg.shape  # i0 = nimg.shape[0], j0 = nimg.shape[1]
    i1 = int((i0 + 1) / 2)
    j1 = int((j0 + 1) / 2)
    output = np.zeros((i1, j1))

    if i0 % 2 == 1:
        i0 += 1
        tmp = np.zeros((1, j0))
        nimg = np.concatenate([nimg, tmp], axis=0)

    if j0 % 2 == 1:
        j0 += 1
        tmp = np.zeros((i0, 1))
        nimg = np.concatenate([nimg, tmp], axis=1)

    for i in range(output.shape[0]):
        for j in range(output.shape[1]):
            a = np.array(nimg[2*i:2*i+2, 2*j:2*j+2])
            output[i, j] = a.max()
    
    return output

# 합성곱 출력 층(reature map) 함수 구현(한 개의 filter 계산)
def featuring(nimg, filters):
    feature = np.zeros((nimg.shape[0] - 2, nimg.shape[1] - 2))
    for i in range(feature.shape[0]):
        for j in range(feature.shape[1]):
            a = nimg[i:i+3, j:j+3]
            feature[i, j] = conv(a, filters)
    return feature

# MaxPooling 출력 층 함수 구현(여러 map 계산)
def Pooling(nimg):
    nimg = np.array(nimg)
    pool0 = []
    for i in range(len(nimg)):
        pool0.append(MaxPooling(nimg[i]))
    return pool0

# 배열을 그림으로 변환
def to_img(nimg):
    nimg = np.array(nimg)
    nimg = np.uint8(np.round(nimg))
    fimg = []
    for i in range(len(nimg)):
        fimg.append(Image.fromarray(nimg[i]))
    return fimg

# feature map 생성(여러 filter 계산)
def ConvD(nimg, filters):
    nimg = np.array(nimg)
    feat0 = []
    for i in range(len(filters)):
        feat0.append(featuring(nimg, filters[i]))
    return feat0

# ReLU 활성화 함수
def ReLU(fo):
    fo = np.array(fo)
    fo = (fo > 0) * fo
    return fo

# CNN Layer 함수 : Conv + ReLU + MaxPooling
def ConvMax(nimg, filters):
    nimg = np.array(nimg)
    f0 = ConvD(nimg, filters)
    f0 = ReLU(f0)
    fg = Pooling(f0)
    return f0, fg

# 그림 그리기 : 합성곱 후의 상태와 MaxPooling 후의 상태를 그림으로 그리기
def draw(f0, fg0, size=(12, 8), k=-1):  # size와 k는 기본값 설정
    plt.figure(figsize=size)

    for i in range(len(f0)):
        plt.subplot(2, len(f0), i + 1)
        plt.gca().set_title('Conv' + str(k) + '-' + str(i))
        plt.imshow(f0[i])

    for i in range(len(fg0)):
        plt.subplot(2, len(fg0), len(f0) + i + 1)
        plt.gca().set_title('MaxP' + str(k) + '-' + str(i))
        plt.imshow(fg0[i])

    if k != -1:  # k=-1이 아니면 그림을 저장
        plt.savefig('conv' + str(k) + '.png')

# 3개의 activation map 합치기 : MaxPooling 후의 결과 map들을 하나의 데이터로 통합
def join(mm):
    mm = np.array(mm)
    m1 = np.zeros((mm.shape[1], mm.shape[2], mm.shape[0]))
    for i in range(mm.shape[1]):
        for j in range(mm.shape[2]):
            for k in range(mm.shape[0]):
                m1[i][j][k] = mm[k][i][j]
    return m1

# CNN Layer 과정을 계산하고 결과를 그림으로 출력
def ConvDraw(p0, filters, size=(12, 8), k=-1):
    f0, fg0 = ConvMax(p0, filters)
    f0_img = to_img(f0)
    fg1_img = to_img(fg0)
    draw(f0, fg0, size, k)
    p1 = join(fg0)
    return p1

# 테스트 실행
nimg31 = np.random.rand(10, 10)
filters = [np.ones((3, 3))] * 3

m0 = ConvDraw(nimg31, filters, (12, 10), 0)
```

### ✅ Result : CNN Layer 구현

![alt text](../../../assets/img/Linux/CNN_Layer.png)

---

# 라베파실습
---
sudo apt install rpi-imager : 라즈베리파이 이미지 다운
rpi-imager : 라즈베리파이 이미지 실행
운영체제 : RASPBERRY PI OS (64-BIT)
저장소 : Mass Storage Device - 62.5 GB