---
title: "Day1 : System Verilog Review"
tags:
    - Study
    - Language
date: "2025-07-14"
thumbnail: "/assets/img/thumbnail/Linux_logo.png"
bookmark: true
---

# initial vs always
---
### 🟢 initial
- 시뮬레이션 **시간 0에 시작**됨
- **딱 한 번만** 실행되고 종료됨
- 블록 안의 코드가 **순차적으로 실행**
- 여러 개 있으면 **동시에 병렬 실행**
- 주로 **테스트벤치, 초기화, 시퀀스 제어** 등에 사용
- 내부에 `#10`, `sqen` 같은 **시퀀셜 흐름 표현** 가능 (시뮬레이션 전용)

> ✅ 예: 시뮬레이션 중 한 번만 특정 동작을 수행할 때

### 🔵 always
- 시뮬레이션 **시간 0부터 시작**
- **조건이 참일 때마다 계속 실행**됨 (영구 루프처럼 동작)
- 회로 내 **동작을 지속적으로 감지하거나 수행**할 때 사용
- **설계 블록과 테스트벤치 모두에서 사용 가능**
- 하드웨어 합성 가능 (동기/조합 회로 구현)

> ✅ 예: 클럭 엣지마다 레지스터 값을 갱신하거나, 입력 변화에 반응

### ✅ 요약
- `initial`은 **한 번만** 실행 → 주로 **시뮬레이션 제어**
- `always`는 **계속 반복** 실행 → 주로 **회로 동작 구현**

# = vs <= (Blocking vs Non-blocking)
---
### ⏱️ 시간 흐름 차이 정리
- `=` (Blocking):
  - **즉시 할당됨** → 시간 흐름 없음
  - 다음 문장 실행 전에 값이 바로 반영됨
- `<=` (Non-blocking):
  - **예약 후 나중에 반영** → 시간 흐름 있음
  - 같은 시뮬레이션 사이클 내에서 값이 동시에 업데이트됨

# 비동기 리셋 vs 동기 리셋 (Power / Area / Cost)
---
### 🟢 비동기 리셋 (Asynchronous Reset)
- 🔋 **전력**: 낮음  
  → 클럭 없이 즉시 리셋되므로 전력 소모가 적음
- 📐 **면적**: 작음  
  → 리셋 로직이 간단해서 하드웨어 자원 적게 사용
- 💰 **비용**: 낮음  
  → 구현이 단순하여 게이트 수가 적고 비용 절감 가능

### 🔵 동기 리셋 (Synchronous Reset)
- 🔋 **전력**: 높음  
  → 클럭 신호가 필요하여 클럭 관련 전력 소모 발생
- 📐 **면적**: 큼  
  → 조건 제어 로직 추가로 인해 하드웨어 자원이 더 들어감
- 💰 **비용**: 높음  
  → 논리 회로가 복잡해지며 설계 및 구현 비용 증가

### ✅ 요약
- **Async 리셋**: 리소스 절약 (저전력, 저면적, 저비용), 하지만 타이밍 민감도 ↑
- **Sync 리셋**: 설계 안정성 ↑, 그러나 자원 소모 ↑

# 조합 논리 vs 순차 논리
---
### 🟢 Combinational Logic (조합 논리)
- 출력이 **입력에만 의존**
- **메모리(상태 저장)** 요소 없음
- 클럭 신호 없이 동작
- 입력이 바뀌면 즉시 출력도 바뀜
- 예: 가산기, 인코더, 디코더, 멀티플렉서 등

```verilog
assign y = a & b;
```

### 🔵 Sequential Logic (순차 논리)
- 출력이 **입력 + 이전 상태(메모리)**에 의존
- 레지스터, 플립플롭 등 상태 저장 소자 사용
- 클럭 신호를 기준으로 상태가 갱신됨
- 시간 개념(순서, 타이밍)이 중요
- 예: 레지스터, 카운터, FSM 등

```verilog
always @(posedge clk) begin
  q <= d;
end
```

### ✅ 요약
- 조합 논리: 현재 입력만으로 결정 → 메모리 없음, 클럭 필요 없음
- 순차 논리: 현재 입력 + 이전 상태로 결정 → 메모리 있음, 클럭 필요

# Equality Operator 요약
---
### ⬛ `==`, `!=`
- **x, z 무시 못함 → 결과가 x 될 수 있음**
- 일반적인 값 비교에 사용

### ⬛ `===`, `!==`
- **x, z까지 포함해서 정확히 비교**
- 테스트벤치에서 자주 사용

### ✅ 핵심 정리
- `==`, `!=` → 값 비교, **x/z 있으면 결과도 x**
- `===`, `!==` → **완전 일치 비교**, x/z 포함해서 비교

# signed vs unsigned
---
### 🟢 unsigned
- **부호 없는 수** → 0 이상만 표현
- MSB(최상위 비트)는 **값의 일부**
- 기본값 (아무것도 안 붙이면 unsigned)

> 예: 4'b1000 = 8 (음수가 아님)

### 🔵 signed
- **부호 있는 수** → 양수/음수 모두 표현 가능
- MSB는 **부호비트**로 사용됨 (0: 양수, 1: 음수)
- 비교, 연산 시 signed끼리 계산되어야 정확함

```verilog
reg signed [3:0] a = 4'b1000;  // -8
```

### ✅ 요약
- unsigned → 0 이상만 표현, 기본값
- signed → 음수까지 표현, MSB는 부호비트

# reg vs wire
---
### 🟢 wire
- **값 저장 X**, 연결용
- `assign`으로만 값 지정
- 조합 논리 회로에 사용

### 🔵 reg
- **값 저장 O**, 내부 상태 유지
- `always`, `initial` 블록에서 값 할당
- 순차 논리 회로에 사용

### ✅ 요약
- `wire`: 저장 ❌, 연결만  
- `reg`: 저장 ⭕, 블록 내에서 값 유지

# Clock Gating, else 사용, power 관련
---
### 🟢 local clock gating
- 특정 block만 **선택적으로 클럭 공급**해서 **동작을 제한**
- 사용 목적: **동작 안 하는 회로의 전력 차단** → **저전력 설계**
- 직접 `if (~enable)`로 처리하는 것보다 더 효율적일 수 있음

### 🔵 Flip-Flop (seq logic)에서 `else` 사용
- **항상 `else`를 쓰는 게 원칙은 아님**
- 하지만 `always @(posedge clk)`에서 `if`만 쓰고 `else`가 없으면:
  - **이전 값 유지 안 될 수 있음**
  - synthesis 툴이 latch로 오해할 수도 있음
- **명확한 상태 유지 목적**으로 `else`를 명시하는 게 좋음

> ✅ 하지만 **불필요한 연산(=토글)**이 발생할 수 있어  
> → **power 측면에서 불리**할 수 있음

### 🔷 Combinational Logic에서는?
- `always @(*)`에서는 **`if`에 `else`를 반드시 써야 함**  
  → 모든 조건에서 출력이 정의되지 않으면 **latch 발생 위험**
- **latch를 피하려면 모든 경우를 처리하는 구조 (`else` 포함)** 가 중요함

### ✅ 요약
- **local clock gating**: 클럭을 차단해서 전력 줄이는 기법
- **FF에서 `else`**: 상태 보존 명확히 하려면 좋지만, **불필요한 전력 소모 주의**
- **combinational에서 `else` 누락**: **latch 발생 가능성** 있음 → 반드시 처리 필요

![alt text](<../../../assets/img/System Verilog/f_b.png>)


# Quiz 1
---
### 이 코드는 합법적인가? 컴파일이 될까?

```verilog
program automatic test;
  bit [31:0] count;
  logic [31:0] Count = 'x;

  initial begin
    count = Count;
    $display("Count = %0x count = %0d", Count, count);
  end
endprogram: test
```

> 답변 : 합법적인 SystemVerilog 코드이며 컴파일도 가능함. program automatic은 시뮬레이션 환경에서 사용되는 구조이고 문법적으로 문제 없음.

### logic 타입은 어떤 타입의 다른 이름인가? 'x는 Count를 어떻게 초기화하는가?

> 답변 : logic은 4-state 타입인 reg의 대체 표현 → 0, 1, x, z 저장 가능. 'x는 모든 비트를 unknown(x) 값으로 초기화함.

### 프로그램은 무엇을 출력할까? 왜 count와 Count의 값이 다른가?

> 출력 예시 : Count = xxxxxxxx count = 0 (형식적으로 표현)

> 이유 : Count는 logic이므로 'x 값을 유지함. count는 bit 타입이라 2-state만 가능 → x 값을 0으로 강제 변환해서 저장됨


shift_reg
