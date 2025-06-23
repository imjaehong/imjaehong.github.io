---
title: "Day1 : Linux start"
tags:
    - Study
    - Language
date: "2025-06-23"
thumbnail: "/assets/img/thumbnail/C.png"
bookmark: true
---
# 리눅스 시스템 기본 명령어
---

```git
python3 : Python 3 버전 확인 (예: 3.10.12)
ifconfig : IP 주소 및 네트워크 정보 확인
htop : CPU 및 메모리 실시간 모니터링
df -h : 디스크 파티션 사용량 확인 (사이즈 단위 human-readable)
sudo : 관리자 권한(superuser)으로 명령어 실행
sudo apt install net-tools htop : net-tools와 htop 패키지 설치
sudo apt install vim : 관리자 권한으로 vim 텍스트 편집기 설치
```

# Python 가상환경 및 pip 관련 명령어
---

```git
python3 -m venv .env : 가상 환경 생성 (.env 폴더에)
sudo apt install python3-venv : venv 모듈 설치
source .env/bin/activate : 가상 환경 활성화
deactivate : 가상 환경 종료
pip install -U pip : pip을 최신 버전으로 업그레이드
```

# 시스템 조작 명령어
---

```git
uname -a : 커널 및 시스템 정보 전체 출력  
ps : 현재 실행 중인 프로세스 정보 확인  
kill : 특정 프로세스를 종료 (예: kill PID)  
service : 백그라운드 서비스 시작/중지/재시작 등 관리  
batch : 시스템 부하가 적을 때 명령어를 실행 (지연 실행)  
shutdown : 시스템 종료 또는 재부팅 예약 (예: shutdown -h now)
```

# 파일 관리를 위한 명령어
---

```git
touch : 새로운 빈 파일 생성  
cat : 파일 내용을 출력하거나 여러 파일을 연결  
head : 파일의 처음 몇 줄을 출력 (기본 10줄)  
tail : 파일의 마지막 몇 줄을 출력 (기본 10줄)  
cp : 파일이나 디렉토리를 복사  
mv : 파일이나 디렉토리를 이동하거나 이름 변경
comm : 
less :
```

# 메모
---
> printf 내부의 **\n** 습관화 필요