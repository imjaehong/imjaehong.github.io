---
title: "Day2 : Synthesis"
tags:
    - Study
    - Language
date: "2025-07-15"
thumbnail: "/assets/img/thumbnail/Linux_logo.png"
bookmark: true
---

Synthesis tool : synopsis design tool

simulation 결과는 나와도 Synthesis 되지 않는 경우, 대부분 코드 문제

Synthesis 에서 가장 중요한 것은 Timing 체크 -> Setup, Hold

플리플롭에서 넘어갈때 clock sqew 생길 수도 있음



# Clock Domain Crossing (CDC)과 Metastability
---
### 🟡 Clock Domain Crossing (CDC)란?
- **서로 다른 클럭 도메인**을 사용하는 회로 간에 데이터를 주고받는 상황  
> 예: A 도메인은 `100MHz`, B 도메인은 `25MHz` → 주고받는 타이밍이 다름

### 🔴 Metastability(메타스테빌리티)란?
- **플립플롭이 안정된 상태(0 또는 1)가 아닌 애매한 상태**에 빠지는 현상  
> 주로 **setup time / hold time을 위반**할 때 발생  
> 결과적으로 출력이 예측 불가능하거나 늦게 안정됨

### 🔗 둘의 연관성
- CDC 상황에서는 **타이밍이 맞지 않는 데이터가 전송**되기 쉽고, 이로 인해 **수신 도메인의 플립플롭이 메타스테이블 상태**에 빠질 수 있음
- 따라서 **CDC → Metastability 위험 증가**

### 🛠 해결 방법 (Synchronizer)
- **동기화 회로**를 사용하여 메타스테빌리티를 완화
- 가장 기본적인 구조는 **2단 플립플롭 동기화기**

```verilog
always @(posedge clk_b) begin
    sync1 <= async_signal;
    sync2 <= sync1;  // 여기서 metastability 완화
end
```



