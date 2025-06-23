---
title: "Day1 : Linux start"
tags:
    - Study
    - Language
date: "2025-06-23"
thumbnail: "/assets/img/thumbnail/Linux_logo.png"
bookmark: true
---
# 📂 1. 리눅스 시스템 기본 명령어
---

```
python3 : Python 3 버전 확인 (예: 3.10.12)  
df -h : 디스크 파티션 사용량 확인 (사이즈 단위 human-readable)  
ifconfig : IP 주소 및 네트워크 정보 확인 (net-tools 필요)  
htop : CPU 및 메모리 실시간 모니터링  
clear : 터미널 화면을 깨끗하게 지움  
echo : 문자열이나 변수 값을 출력 (스크립트 디버깅에 자주 사용)  
uname -a : 커널 및 시스템 정보 전체 출력  
sudo : 관리자 권한(superuser)으로 명령어 실행  
```

# 🧰 2. 패키지 설치 및 환경 구성
---

```
sudo apt install python3-venv : venv 모듈 설치  
sudo apt install net-tools htop : ifconfig와 htop 명령어를 사용하기 위한 패키지 설치  
sudo apt install vim : vim 텍스트 편집기 설치  
sudo apt install curl : URL 통신 도구 curl 설치  
sudo apt install plocate : locate 명령어 대체 패키지 설치  
sudo apt install ncal : 달력 출력 명령어(ncal) 설치 (확장된 cal)
```

# 🐍 3. Python 가상환경 및 pip 관련 명령어
---

```
python3 -m venv .env : 가상 환경 생성 (.env 폴더에)  
source .env/bin/activate : 가상 환경 활성화  
deactivate : 가상 환경 종료  
pip install -U pip : pip을 최신 버전으로 업그레이드
```

# ⚙️ 4. 시스템 조작 명령어
---

```
ps : 현재 실행 중인 프로세스 정보 확인  
kill : 특정 프로세스를 종료 (예: kill PID)  
service : 백그라운드 서비스 시작/중지/재시작 등 관리  
batch : 시스템 부하가 적을 때 명령어를 실행 (지연 실행)  
shutdown : 시스템 종료 또는 재부팅 예약 (예: shutdown -h now)
```

# 📁 5. 파일 관리 명령어
---

```
touch : 새로운 빈 파일 생성  
cat : 파일 내용을 출력하거나 여러 파일을 연결  
head : 파일의 처음 몇 줄을 출력 (기본 10줄)  
tail : 파일의 마지막 몇 줄을 출력 (기본 10줄)  
cp : 파일이나 디렉토리를 복사  
mv : 파일이나 디렉토리를 이동하거나 이름 변경  
comm : 두 개의 정렬된 파일을 비교하여 공통/차이 출력  
cmp : 두 파일을 바이트 단위로 비교 (다른 위치 출력)  
dd : 저수준 복사 명령어 (디스크 백업, ISO 굽기 등 활용됨)  
ln : 링크 파일 생성 (기본은 하드링크, `-s`는 심볼릭 링크)  
less : 긴 파일을 한 화면씩 읽기 (스크롤 가능, cat보다 편함)  
sort : 파일 내용을 알파벳 또는 숫자 순으로 정렬  
chmod : 파일 권한 설정 (예: 실행 권한 부여)  
chown : 파일이나 디렉토리의 소유자(user)나 그룹 변경
```

# 🌐 6. 네트워크 관련 명령어
---

```
wget : URL로부터 파일 다운로드 (예: 이미지, 문서 등)  
curl : URL로부터 데이터 전송 또는 수신 (API 테스트에 자주 사용)  
traceroute : 목적지까지 거치는 라우터 경로 추적 (네트워크 문제 진단에 사용)  
iptables : 리눅스 방화벽 설정 및 패킷 필터링 제어
```

# 🔍 7. 검색 및 정규 표현식
---

```
find : 파일이나 디렉토리를 조건 기준으로 검색  
which : 명령어의 실행 파일 경로 확인 (PATH에서 검색)  
locate : 인덱스 기반으로 빠르게 파일 경로 검색 (`updatedb` 필요)  
grep : 텍스트에서 특정 문자열 검색 및 출력 (정규 표현식 지원)  
sed : 문자열 치환/삭제 등 스트림 편집에 사용
```

# 🧩 8. 기타 명령어
---

```
man : 명령어 사용법, 옵션 등을 설명하는 매뉴얼 페이지 보기  
whatis : 명령어의 짧은 설명 출력 (man 페이지 요약)  
cal : 월간 달력 출력 (예: cal 2025 6)  
banner : 입력한 문자열을 큰 아스키 아트 텍스트로 출력  
rev : 문자열이나 파일 내용을 반대로 출력  
tar : 파일 및 디렉토리를 아카이브하거나 압축 해제
```

# 📝 9. Vim 탐색 및 검색 단축키
---

```
Shift + G : 파일의 마지막 줄로 이동  
/문자열 : 문자열 검색 (예: /pip)  
n : 다음 검색 결과로 이동  
N : 이전 검색 결과로 이동  
```

# 💡 10. 메모 및 자주 쓰는 예시
---

```
Ctrl + w + v : Vim에서 수직 창 분할  
:e .         : Vim에서 파일 탐색기 열기  
locate python3 > search.txt : locate 결과를 파일로 저장  
grep -rn 'pip' > result.txt : 현재 디렉토리 내 'pip' 포함 줄을 재귀적으로 검색해 저장
```

# Home Work
---

```
폰 노이만 아키텍처
폰 노이만 병목 현상
캐시 메모리
하버드 아키텍처
파이프라이닝
멀티코어 프로세서
```

> 구글 제미나이: PPT 제작 용이 (.html)