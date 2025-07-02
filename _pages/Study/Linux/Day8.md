---
title: "Day8 : Project_Plan"
tags:
    - Study
    - Language
date: "2025-07-02"
thumbnail: "/assets/img/thumbnail/Linux_logo.png"
bookmark: true
---

# 🧱 라즈베리파이 환경 구축
---

```bash
ctrl + alt + t
→ 터미널 실행 단축키

htop
→ 실시간 시스템 리소스(메모리, CPU 사용량 등) 확인 툴 실행

sudo apt update
→ 패키지 목록 업데이트 (최신 버전 확인용)

sudo apt upgrade
→ 설치된 패키지들을 최신 버전으로 업그레이드

sudo apt install ibus ibus-hangul
→ 한글 입력기(iBus + Hangul) 설치

sudo apt install fonts-nanum fonts-unfonts-core
→ 나눔글꼴, 윤글꼴 등 한글 폰트 설치

sudo update-alternatives --config x-www-browser
→ 기본 웹 브라우저 설정 변경

mkdir YOLO
→ 'YOLO'라는 새 폴더 생성

cd YOLO/
→ YOLO 폴더로 이동

python -m venv .yolo
→ '.yolo'라는 이름의 가상환경(virtualenv) 생성

source .yolo/bin/activate
→ 가상환경 활성화

git clone https://github.com/ultralytics/yolov5
→ YOLOv5 저장소를 GitHub에서 복제

cd yolov5/
→ 복제한 yolov5 디렉토리로 이동

pip install -U pip
→ pip(패키지 관리자) 최신 버전으로 업데이트

pip install ultralytics
→ Ultralytics 패키지 설치 (YOLOv5 실행용 라이브러리 포함)

python detect.py --weights yolov5s.pt --source 0 --img 160
→ YOLOv5s 모델로 웹캠(0번)을 실시간 객체 탐지 (해상도: 160)

sudo apt install openssh-server
→ SSH 서버 설치 (다른 PC에서 원격 접속 가능하게 함)

curl -fsSL https://ollama.com/install.sh | sh
→ Ollama 설치 스크립트 실행 (로컬 AI 모델 실행 도구)

ollama run gemma3:1b
→ Gemma 3 1B 모델 실행 (로컬 LLM 테스트)
```

# 🤝 팀원들과 프로젝트 계획 수립
---
라즈베리파이를 활용한 On-Device AI 프로젝트 방향성 논의
- 김민규: 수어 인식 (Sign Language Recognition, SLR)
- 엄찬하: 머리카락 두께 및 탈모 초기 진단 + 맞춤형 예방 관리 가이드
- 임재홍: 딥페이크 감지 시스템
- 임재홍: 거짓 뉴스 판독 시스템

# 💬 회고
---
- 실시간 객체 탐지와 로컬 AI 모델이 동시에 가능함을 확인함
- 라즈베리파이 환경 세팅 중 허브를 통해 LAN 케이블을 분할하는 과정에서 PC에서 네트워크를 잡지 못하는 문제가 발생했으나, 수업 종료 후 정상적으로 연결되어 IP 충돌 문제였음을 파악함

### 💡 강사님의 조언
> **"CNN 모델을 C++ 수준으로 뽑으면 가장 좋음."**  
> 프로젝트 성공 여부와 상관없이, 구현 수준을 높이는 것이 더 중요하다는 취지의 말씀

---

### ✍️ 해석 및 나의 이해
- 단순히 모델을 "돌리는 것"을 넘어서, **구조를 정확히 이해하고 직접 구현해보는 경험**이 중요하다는 뜻
- PyTorch, TensorFlow 같은 프레임워크를 쓸 수도 있지만, **기초 수학/로직을 바탕으로 CNN을 직접 구현(C++ 수준의 저수준 접근)**해보는 것이 실력 향상에 도움됨
- 실무 또는 온디바이스 환경(Raspberry Pi 등)에서는 최적화된 저수준 코드로 모델을 이식하는 능력도 요구됨

---

### 🔎 앞으로의 학습 방향에 반영
- CNN 레이어 구성 및 연산 방식(ReLU, Conv, Pooling 등)을 직접 구현해보는 연습
- Python으로 구현 → 가능하다면 C++로 구조만이라도 옮겨보기
- PyTorch에서 `.model.eval()`처럼 내부 동작이 어떻게 구성되는지 역으로 살펴보기