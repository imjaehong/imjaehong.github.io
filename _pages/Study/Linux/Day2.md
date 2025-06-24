---
title: "Day2 : OpenCV"
tags:
    - Study
    - Language
date: "2025-06-24"
thumbnail: "/assets/img/thumbnail/Linux_logo.png"
bookmark: true
---

# 1. OpenCV란?

OpenCV(Open Source Computer Vision Library)는 실시간 컴퓨터 비전 및 머신러닝을 위한 오픈소스 라이브러리입니다.

---

## 🔧 OpenCV Modules

### 🔹 Main Modules
- **core**: [Core functionality](https://docs.opencv.org/4.x/)
- **imgproc**: [Image Processing](https://docs.opencv.org/4.x/)
- **imgcodecs**: [Image file reading and writing](https://docs.opencv.org/4.x/)
- **videoio**: [Video I/O](https://docs.opencv.org/4.x/)
- **highgui**: [High-level GUI](https://docs.opencv.org/4.x/)
- **video**: [Video Analysis](https://docs.opencv.org/4.x/)
- **calib3d**: [Camera Calibration and 3D Reconstruction](https://docs.opencv.org/4.x/)
- **features2d**: [2D Features Framework](https://docs.opencv.org/4.x/)
- **objdetect**: [Object Detection](https://docs.opencv.org/4.x/)
- **dnn**: [Deep Neural Network module](https://docs.opencv.org/4.x/)
- **ml**: [Machine Learning](https://docs.opencv.org/4.x/)
- **flann**: [Clustering and Search in Multi-Dimensional Spaces](https://docs.opencv.org/4.x/)
- **photo**: [Computational Photography](https://docs.opencv.org/4.x/)
- **stitching**: [Images Stitching](https://docs.opencv.org/4.x/)
- **gapi**: [Graph API](https://docs.opencv.org/4.x/)

---

### 🔹 Extra Modules
- **alphamat**: [Alpha Matting](https://docs.opencv.org/4.x/)
- **aruco**: [Aruco markers (moved to objdetect)](https://docs.opencv.org/4.x/)
- **bgsegm**: [Improved Background-Foreground Segmentation Methods](https://docs.opencv.org/4.x/)
- **bioinspired**: [Biologically inspired vision models](https://docs.opencv.org/4.x/)
- **ccalib**: [Custom Calibration Pattern for 3D reconstruction](https://docs.opencv.org/4.x/)
- **cudaarithm**: [Operations on Matrices (CUDA)](https://docs.opencv.org/4.x/)
- **cudabgsegm**: [Background Segmentation (CUDA)](https://docs.opencv.org/4.x/)
- **cudacodec**: [Video Encoding/Decoding (CUDA)](https://docs.opencv.org/4.x/)
- **cudafeatures2d**: [Feature Detection and Description (CUDA)](https://docs.opencv.org/4.x/)

### cuda 모듈의 역할?
- 이미지 처리


# 오늘 작업할 디렉토리  생성
---
mkdir opencv: 디렉토리 이름 = opencv

cd opencv: 생성한 디렉토리로 이동

python3 -m venv .env : 가상 환경 생성 (폴더이름: .env)

source .env/bin/activate : 가상 환경 활성화  

pip install opencv-python : OpenCV 기본 기능(core, imgproc 등)을 포함한 패키지 설치

pip install opencv-contrib-python : opencv-python + 추가 모듈(contrib 모듈)까지 포함한 패키지 설치

pip install -U pip : pip 자체를 최신 버전으로 업그레이드

python
```
>>> import numpy as np
>>> import cv2

>>> np.__version__
'2.2.6'

>>> cv2.__version__
'4.11.0'

>>> exit()
```

# 🎨 색상 정보
---

## 🔗 참고 사이트
- [W3Schools - RGB Colors](https://www.w3schools.com/colors/colors_rgb.asp)

---

## 🌈 RGB (Red, Green, Blue)
- 각 색상 채널: **0~255 (8bit)**
  - R (Red): 8bit
  - G (Green): 8bit
  - B (Blue): 8bit
- 픽셀 1개 = **24bit (8bit × 3)**

---

## 🎨 HSL (Hue, Saturation, Lightness)
- **H**: 색상 (Hue) → 0 ~ 360°
- **S**: 채도 (Saturation) → 0 ~ 100%
- **L**: 밝기 (Lightness) → 0 ~ 100%

---

## 🔄 RGB vs HSL 차이점

| 항목       | RGB                              | HSL                                      |
|------------|----------------------------------|-------------------------------------------|
| 구성       | Red, Green, Blue (각 0~255)      | Hue (0~360), Saturation & Lightness (0~100%) |
| 직관성     | 컴퓨터에서 사용하기 적합         | 사람이 색을 이해하기 쉬움                 |
| 색 조절    | 색상 조정이 복잡함               | 채도/밝기 조절이 용이함                   |
| 용도       | 디스플레이, 이미지 처리 등       | 디자인, 색상 선택 도구 등에 유용          |

---

✅ **요약**:  
- RGB는 화면 출력/처리에 적합한 **디지털 색 표현 방식**  
- HSL은 색상 구성요소를 분리해 **사람이 이해하거나 조절하기 쉬운 방식**

