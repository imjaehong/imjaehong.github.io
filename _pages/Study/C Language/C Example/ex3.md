---
title: "[ex3] /, % 연산자의 활용 => 10진수 자리수 분리"
tags:
    - Study
    - Language
date: "2025-03-18"
thumbnail: "/assets/img/thumbnail/C.png"
bookmark: true
---
# 문제 설명
---
4자리 정수의 각 자리 값을 추출하여 a4, a3, a2, a1에 저장하라

```c
#include <stdio.h>

void main(void)
{
	int a = 2345;
	int a4, a3, a2, a1;

	a4 = 
	a3 = 
	a2 = 
	a1 = 

	printf("1000자리=%d, 100자리=%d, 10자리=%d, 1자리=%d\n", a4, a3, a2, a1);
}
```

# 출력 예시
---

```
1000자리=2, 100자리=3, 10자리=4, 1자리=5
```

# 정답 코드
---

```c
#include <stdio.h>

void main(void)
{
	int a = 2345;
	int a4, a3, a2, a1;
    // 1의 자리부터 코딩
	a4 = (a / 1000);
	a3 = (a / 100) % 10;
	a2 = (a / 10) % 10;
	a1 = a % 10;

	printf("1000자리=%d, 100자리=%d, 10자리=%d, 1자리=%d\n", a4, a3, a2, a1);
}
```

# 메모
---
> printf 내부의 **\n** 습관화 필요