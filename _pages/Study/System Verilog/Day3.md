---
title: "Day3 : Low-pass Filter"
tags:
    - Study
    - Language
date: "2025-07-16"
thumbnail: "/assets/img/thumbnail/Linux_logo.png"
bookmark: true
---

# Project #1
---

![alt text](<../../../assets/img/System Verilog/pj01.png>)
![alt text](<../../../assets/img/System Verilog/pj02.png>)
![alt text](<../../../assets/img/System Verilog/pj03.png>)
![alt text](<../../../assets/img/System Verilog/pj04.png>)

$z^-1$ : 지연

$y[n] = b_0 x[n] + b_1 x[n-1] + \cdots + b_N x[n - N]$

$y[n] = \sum_{i=0}^{N} b_i \cdot x[n - i]$


![alt text](<../../../assets/img/System Verilog/pj05.png>)
![alt text](<../../../assets/img/System Verilog/pj06.png>)
![alt text](<../../../assets/img/System Verilog/pj07.png>)
![alt text](<../../../assets/img/System Verilog/pj08.png>)
![alt text](<../../../assets/img/System Verilog/pj09.png>)
![alt text](<../../../assets/img/System Verilog/pj10.png>)
![alt text](<../../../assets/img/System Verilog/pj11.png>)
![alt text](<../../../assets/img/System Verilog/pj12.png>)
![alt text](<../../../assets/img/System Verilog/pj13.png>)

# MobaXterm
---

### Code : rrc_filter.sv

```verilog
// Created on 2025/07/15 by jaehong

`timescale 1ns / 1ps

module rrc_filter #(
    parameter WIDTH = 7
)(
    input         clk,
    input         rstn,

    input  [WIDTH-1:0]        data_in,   // format : <1.6>
    output logic signed [WIDTH-1:0] data_out
);

// coeff -3, -1.8, -7, -14, 24, 19, -62, -23, 225, 387, 225, -23, -62, 19, 24, -14, -7, 8, -1, -3
// format : <1.8>

logic signed [WIDTH+9-1:0] mul_00, mul_01, mul_02, mul_03;
logic signed [WIDTH+9-1:0] mul_04, mul_05, mul_06, mul_07;
logic signed [WIDTH+9-1:0] mul_08, mul_09, mul_10, mul_11;
logic signed [WIDTH+9-1:0] mul_12, mul_13, mul_14, mul_15;
logic signed [WIDTH+9-1:0] mul_16, mul_17, mul_18, mul_19;
logic signed [WIDTH+9-1:0] mul_20, mul_21, mul_22, mul_23;
logic signed [WIDTH+9-1:0] mul_24, mul_25, mul_26, mul_27;
logic signed [WIDTH+9-1:0] mul_28, mul_29, mul_30, mul_31;
logic signed [WIDTH+9-1:0] mul_32;

logic signed [WIDTH-1:0] shift_din [32:0];
integer i;
always@(posedge clk or negedge rstn) begin
    if (~rstn) begin
        for(i = 32; i >= 0; i=i-1) begin
            shift_din[i] <= 0;
        end
    end
    else begin
        for(i = 32; i > 0; i=i-1) begin
            shift_din[i] <= shift_din[i-1];
        end
        shift_din[0] <= data_in;
    end
end

always @(*) begin
    mul_00 = shift_din[00]*0;
    mul_01 = shift_din[01]*-1;
    mul_02 = shift_din[02]*1;
    mul_03 = shift_din[03]*0;
    mul_04 = shift_din[04]*-1;
    mul_05 = shift_din[05]*2;
    mul_06 = shift_din[06]*2;
    mul_07 = shift_din[07]*-2;
    mul_08 = shift_din[08]*2;
    mul_09 = shift_din[09]*0;
    mul_10 = shift_din[10]*-6;
    mul_11 = shift_din[11]*8;
    mul_12 = shift_din[12]*10;
    mul_13 = shift_din[13]*-28;
    mul_14 = shift_din[14]*-14;
    mul_15 = shift_din[15]*111;
    mul_16 = shift_din[16]*196;
    mul_17 = shift_din[17]*111;
    mul_18 = shift_din[18]*-14;
    mul_19 = shift_din[19]*-28;
    mul_20 = shift_din[20]*10;
    mul_21 = shift_din[21]*8;
    mul_22 = shift_din[22]*-6;
    mul_23 = shift_din[23]*0;
    mul_24 = shift_din[24]*2;
    mul_25 = shift_din[25]*-2;
    mul_26 = shift_din[26]*0;
    mul_27 = shift_din[27]*2;
    mul_28 = shift_din[28]*-1;
    mul_29 = shift_din[29]*0;
    mul_30 = shift_din[30]*1;
    mul_31 = shift_din[31]*-1;
    mul_32 = shift_din[32]*0;
end

logic signed [WIDTH+16-1:0] filter_sum;
//always_comb begin
always @(*) begin
    filter_sum = mul_00 + mul_01 + mul_02 + mul_03 +
                 mul_04 + mul_05 + mul_06 + mul_07 +
                 mul_08 + mul_09 + mul_10 + mul_11 +
                 mul_12 + mul_13 + mul_14 + mul_15 +
                 mul_16 + mul_17 + mul_18 + mul_19 +
                 mul_20 + mul_21 + mul_22 + mul_23 +
                 mul_24 + mul_25 + mul_26 + mul_27 +
                 mul_28 + mul_29 + mul_30 + mul_31 +
                 mul_32;
end

logic signed [WIDTH+8-1:0] trunc_filter_sum;
assign trunc_filter_sum = filter_sum[WIDTH+16-1:8];

always_ff @(posedge clk or negedge rstn) begin
    if (~rstn)
        data_out <= 'h0;
    else if (trunc_filter_sum >= 63)
        data_out <= 63;
    else if (trunc_filter_sum < -64)
        data_out <= -64;
    else
        data_out <= trunc_filter_sum[WIDTH-1:0];
end

endmodule
```

---

### code : tb_rrc_filter.sv

```verilog
`timescale 1ns/10ps

module tb_rrc_filter();

logic clk, rstn;
logic signed [6:0] data_in;
logic signed [6:0] data_out;
logic signed [6:0] adc_data_in [0:93695];

initial begin
    clk <= 1'b1;
    rstn <= 1'b0;
    #55 rstn <= 1'b1;
    // #500000 $finish;
end

always #5 clk <= ~clk;

integer fd_adc_di;
integer fd_rrc_do;
integer i;
int data;
initial begin
    //always @(posedge clk) begin
    fd_adc_di = $fopen("./ofdm_i_adc_serial_out_fixed_30dB.txt", "r");
    //fd_adc_di = $fopen("./ofdm_adc_serial_out_fixed_30dB.txt", "r");
    fd_rrc_do = $fopen("./rrc_do.txt", "w");
    i = 0;
    while (!$feof(fd_adc_di)) begin
        void'($fscanf(fd_adc_di,"%d\n",data));
        adc_data_in[i] = data;
        i = i + 1;
    end
    #800000 $finish;
    $fclose(fd_rrc_do);
end

logic [23:0] adc_dcnt;
always_ff @(posedge clk or negedge rstn) begin
    if (~rstn)
        adc_dcnt <= 'h0;
    else
        adc_dcnt <= adc_dcnt + 1'b1;
end

logic [6:0] tmp_data_in;
assign tmp_data_in = adc_data_in[adc_dcnt];
logic [6:0] data_in;
always_ff @(posedge clk or negedge rstn) begin
    if (~rstn)
        data_in <= 'h0;
    else
        data_in <= tmp_data_in;
end

always_ff @(negedge clk) begin
    //$fd_rrc_do = $fopen("./rrc_do.txt", "w");
    $fwrite(fd_rrc_do, "%0d\n", data_out);
end

rrc_filter #(.WIDTH(7)) i_rrc_filter (
    .clk(clk),
    .rstn(rstn),
    .data_in(data_in),
    .data_out(data_out)
);

endmodule
```

---

### code : run_rcc

```bash
vcs -sverilog -full64 -debug_all \
    tb_rrc_filter.sv rrc_filter.sv \
    -o simv && ./simv
```

---

### [aedu34@kccisynop2 /home/aedu34/asic_adu_red/verilog]
- rrc_filter.sv
- tb_rrc_filter.sv
- run_rcc
- ofdm_i_adc_serial_out_fixed_30dB.txt

---

### source run_rcc
rrc_do.txt 생성됨

---

### code : run_rrc_verdi

```matlab
vcs -full64 -sverilog -kdb -debug_access+all+reverse rrc_filter.sv tb_rrc_filter.sv
./simv -verdi &
```

---

### source run_rrc_verdi

![alt text](<../../../assets/img/System Verilog/pj14.png>)

# MATLAB
---

### C:\Users\kccistc\Documents\MATLAB
- rrc_do.txt

---

### Code : matlab graph

```matlab
y = load('rrc_do.txt');     % 데이터 불러오기
plot(y);                    % 파형 그리기
xlabel('Sample');
ylabel('Amplitude');
title('RRC Filter Output');
grid on;
```

---

### Result : matlab graph

![alt text](<../../../assets/img/System Verilog/pj15.png>)

# 고정소수점 FIR 필터의 비트폭 계산 정리
---

### 📌 입력 & 계수 비트폭

- `data` 포맷: `<1.6>` → 총 7비트 (부호 1비트 + 소수 6비트)
- `coeff` 포맷: `<1.8>` → 총 9비트 (부호 1비트 + 소수 8비트)

---

### ✴️ 곱셈 시 비트폭 확장

- `<1.6>` × `<1.8>` = `<2.14>`
- 7bit × 9bit = 16bit
- 정수부: 1비트 + 1비트 = 2비트
- 소수부: 6비트 + 8비트 = 14비트
- 결과: `<2.14>` = 총 16비트

---

### ➕ 덧셈(누적) 시 비트폭 확장

- 고정소수점끼리 더할 때는 **정수부가 1비트 증가**할 수 있음 (Carry 발생 대비)
- 누적해서 더할수록 정수부 비트폭은 `ceil(log2(N))`만큼 늘어남  
  (N은 덧셈 횟수 또는 Tap 수)

#### 📌 예제: 같은 비트폭 `<2.14>` 값을 누적할 경우

| Tap 수 | 누적 결과 비트폭 |
| :---: | :---: |
| 2 tap  | `<3.14>` |
| 16 tap | `<6.14>` |
| 32 tap | `<7.14>` |
| 33 tap | `<8.14>` |

> ※ 소수부는 항상 14비트로 유지, 정수부만 확장됨

---

### 📤 출력 변환 단계

- 누적 결과: `<8.14>`  
→ 출력 포맷 `<1.6>`으로 변환하기 위해 다음 작업 수행:

1. **소수부 절단 (Truncation)**  
   - 하위 8비트(소수부)를 제거  
   - `<8.14>` → `<8.6>`  
   - 소수부 14비트 → 6비트로 축소

2. **정수부 포화 처리 (Saturation)**  
   - 출력 정수부는 1비트만 사용 가능하므로  
     - 값 ≥ 63 → `63`  
     - 값 ≤ -64 → `-64`

3. **최종 출력 포맷**  
   - 결과는 `<1.6>` 형식으로 Flip-Flop에 저장되어 출력 안정화

---

### ✅ 핵심 요약

| 연산 | 정수부 변화 | 소수부 변화 |
| :---: | :---: | :---: |
| 곱셈 `<a.b> × <c.d>` | `a + c` | `b + d` |
| 덧셈 `<a.b> + <a.b>` | `a + 1` | `b` 유지 |
| 누적 덧셈 N번 | `a + ceil(log2(N))` | `b` 유지 |
| 출력 변환 | 정수부 잘라서 포화 | 소수부 `b → 6` |


