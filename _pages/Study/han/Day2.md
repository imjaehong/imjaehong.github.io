---
title: "Day1 : System Verilog Review"
tags:
    - Study
    - Language
date: "2025-07-14"
thumbnail: "/assets/img/thumbnail/Linux_logo.png"
bookmark: true
---

# initial vs. always

- initial
시간 0에서 시작, simulation 동안 한 번만 수행
순차적으로 들어감
위아래 2개 있으면 동시에 들어감
한 번만 돌고 맘
내부에서 sqen
시컨셜 컴프

- always
시간 0에서 시작, always block 문장을 ?
testbench에서 쓸 수 있음
계속 돔
