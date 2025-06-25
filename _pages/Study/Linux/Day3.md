---
title: "Day3 : ?"
tags:
    - Study
    - Language
date: "2025-06-25"
thumbnail: "/assets/img/thumbnail/Linux_logo.png"
bookmark: true
---

# 👨‍💻 실습
---

### 💡 Trackbar

```py
# ex13.py
import cv2

topLeft = (50, 50)
bold = 0
r, g, b = 255, 255, 0  # 초기 텍스트 색상: 노란색 (BGR = (0, 255, 255))

# bold 트랙바 콜백
def on_bold_trackbar(value):
    global bold
    bold = value

    global r
    r = value

def on_g_trackbar(value):
    global g
    g = value

def on_b_trackbar(value):
    global b
    b = value

# 카메라 연결
cap = cv2.VideoCapture(0)

# 윈도우 및 트랙바 생성
cv2.namedWindow("Camera")
cv2.createTrackbar("bold", "Camera", bold, 30, on_bold_trackbar)
cv2.createTrackbar("R", "Camera", r, 255, on_r_trackbar)
cv2.createTrackbar("G", "Camera", g, 255, on_g_trackbar)
cv2.createTrackbar("B", "Camera", b, 255, on_b_trackbar)

# 루프 시작
while cap.isOpened():
    ret, frame = cap.read()
    if not ret:
        print("Can't receive frame (stream end?). Exiting ...")
        break

    # 텍스트 출력 (트랙바에서 받아온 bold, color 값 사용)
    cv2.putText(frame, "hhhong",
                topLeft,
                cv2.FONT_HERSHEY_SIMPLEX,
                2,
                (b, g, r),  # BGR
                1 + bold)

    # 프레임 출력
    cv2.imshow("Camera", frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# 종료 처리
cap.release()
cv2.destroyAllWindows()
```

### ❓ Quiz: Trackbar

```
1. Trackbar를 control해서 TEXT의 굵기가 변하는 것을 확인해 보자.

2. Trackbar를 추가해서 font size를 변경 / 적용해 보자.

3. R/G/B Trackbar를 각각 추가해서 글자의 font color를 변경해 보자.
```

---

###### ggggggggg
# 📌 OpenCV란?
---
OpenCV(Open Source Computer Vision Library)는 **실시간 컴퓨터 비전** 및 **머신러닝**을 위한 오픈소스 라이브러리입니다.  
다양한 이미지/비디오 처리 기능을 제공하며, Python, C++, Java 등 다양한 언어에서 사용 가능합니다.

# 🚀 CUDA 모듈의 역할
---
- GPU 가속을 활용한 **고속 이미지 처리** 수행
- OpenCV의 일부 함수들은 CUDA를 통해 **병렬 처리**되어 성능을 향상시킴
- 사용 예: `cv2.cuda.GpuMat`, `cv2.cuda.filter2D()`, `cv2.cuda.resize()` 등

# 🛠️ 작업할 디렉토리 생성 및 환경 설정
---

```bash
# 1. 작업 디렉토리 생성
mkdir opencv                 # 디렉토리 이름: opencv
cd opencv                   # 해당 디렉토리로 이동

# 2. 가상 환경 생성 및 활성화
python3 -m venv .env        # 가상 환경 생성 (폴더 이름: .env)
source .env/bin/activate    # 가상 환경 활성화

# 3. 패키지 설치
pip install opencv-python          # OpenCV 기본 기능(core, imgproc 등)
pip install opencv-contrib-python # 추가 모듈(contrib 포함)
pip install -U pip                 # pip 최신 버전으로 업그레이드
```

# ✅ 설치 확인 (Python 인터프리터 실행)
---

```py
>>> import numpy as np
>>> import cv2

>>> np.__version__
'2.2.6'          # 설치된 NumPy 버전 출력

>>> cv2.__version__
'4.11.0'         # 설치된 OpenCV 버전 출력

>>> exit()       # Python 인터프리터 종료
```

# 🎨 색상 정보
---

### 🔗 참고 사이트
- [W3Schools - RGB Colors](https://www.w3schools.com/colors/colors_rgb.asp)

---

### 🌈 RGB (Red, Green, Blue)
- 각 색상 채널: **0~255 (8bit)**
  - R (Red): 8bit
  - G (Green): 8bit
  - B (Blue): 8bit
- 픽셀 1개 = **24bit (8bit × 3)**

---

### 🎨 HSL (Hue, Saturation, Lightness)
- **H**: 색상 (Hue) → 0 ~ 360°
- **S**: 채도 (Saturation) → 0 ~ 100%
- **L**: 밝기 (Lightness) → 0 ~ 100%

---

### 🔄 RGB vs HSL 차이점

| 항목 | RGB | HSL |
| :--: | :--: | :--: |
| 구성 | Red, Green, Blue (각 0~255) | Hue (0~360), Saturation & Lightness (0~100%) |
| 직관성 | 컴퓨터에서 사용하기 적합 | 사람이 색을 이해하기 쉬움 |
| 색 조절 | 색상 조정이 복잡함 | 채도/밝기 조절이 용이함 |
| 용도 | 디스플레이, 이미지 처리 등 | 디자인, 색상 선택 도구 등에 유용 |

---

### ✅ **요약**:  
- RGB는 화면 출력/처리에 적합한 **디지털 색 표현 방식**  
- HSL은 색상 구성요소를 분리해 **사람이 이해하거나 조절하기 쉬운 방식**

---

### 📝 메모
- vi ex1.py : python 스크립트 생성
- python ex1.py : 생성된 스크립트 실행
- jpg : 파일이 작고 속도가 빠르며, 주로 사진이나 웹 배경 이미지에 사용
- png : 화질 보존, 투명 배경이 필요한 경우 사용