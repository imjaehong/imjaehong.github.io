---
title: "[ex39] 3,6,9 게임"
tags:
    - Study
    - Language
date: "2025-03-18"
thumbnail: "/assets/img/thumbnail/C.png"
bookmark: true
---
# 문제 설명
---
다음에서 요구하는 3,6,9 게임 프로그램을 설계하라
정수 N을 scanf로 입력 받아서 1부터 N까지 다음과 같이 인쇄하라
3의 배수와 숫자에 3이 들어가는 경우는 모두 값 대신 %를 인쇄한다
3, 6, 9, 12, 13, … 23 등은 모두 숫자대신 %를 인쇄한다
N에 도달하면 N대신 “SUCCESS”를 인쇄하라

```c
#include <stdio.h>

void main(void)
{
	// 코드 작성
}
```

# 입력 설명
---

```
N <= 99
```

# 입력 예시
---

```
12
```

# 출력 예시
---

```
1
2
%
4
5
%
7
8
%
10
11
SUCCESS
```

# 정답 코드
---

```c
#include <stdio.h>

void main(void)
{
	int i, N;
	scanf("%d", &N);

	for (i = 1; i < N; i++)
	{
		if (((i % 3) == 0) || ((i % 10) == 3) || ((i / 10) == 3))
		{
			printf("%%\n");
		}

		else
		{
			printf("%d\n", i);
		}
	}

	printf("SUCCESS\n");
}
```

# 메모
---
> printf 내부의 **\n** 습관화 필요