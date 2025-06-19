---
title: "[ex7] 100자리 값을 0으로 만들기"
tags:
    - Study
    - Language
date: "2025-03-18"
thumbnail: "/assets/img/thumbnail/C.png"
bookmark: true
---
# 문제 설명
---
3~9자리 정수를 입력받아 100자리 값을 0으로 만드는 코드를 구현하라
예를들어 1234가 입력되면 100자리 2를 0으로 만들어서 1034가 되게 하시오

```c
#include <stdio.h>
int main(void) 
{
	int A;
	scanf("%d", &A);

	// 코드 작성

	printf("%d\n", A);
	return 0;
}
```

# 입력 설명
---

```
3~9자리 정수 입력
```

# 출력 설명
---

```
100자리 값을 0으로 만들어서 출력
```

# 입력 예시
---

```
1234
```

# 출력 예시
---

```
1034
```

# 정답 코드
---

```c
#include <stdio.h>
 
int main(void) 
{
    int A;
    scanf("%d", &A);
 
    A = A - (A / 100 % 10 * 100);
 
    printf("%d\n", A);
    return 0;
}
```

# 메모
---
> printf 내부의 **\n** 습관화 필요