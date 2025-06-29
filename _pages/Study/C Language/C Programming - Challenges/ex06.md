---
title: "[ex06] 함함수를 함수에 전달하자"
tags:
    - Study
    - Language
date: "2025-03-18"
thumbnail: "/assets/img/thumbnail/C.png"
bookmark: true
---
# 문제 설명
---

```c
#include <stdio.h> 

int add(int a, int b)
{
    return a+b;
}

int sub(int a, int b)
{
    return a-b;
}

void func(                  )
{
    printf("%d\n", p(3,4));
}

void main(void)
{
    func(add);
    func(sub);
}
```

# 출력 예시
---

```
7
-1
```

# 정답 코드
---

```c
#include <stdio.h> 

int add(int a, int b)
{
	return a+b;
}

int sub(int a, int b)
{
	return a-b;
}

void func(int (*p)(int a, int b))
{
	printf("%d\n", p(3,4));
}

void main(void)
{
	func(add);
	func(sub);
}
```

# 메모
---
> printf 내부의 **\n** 습관화 필요