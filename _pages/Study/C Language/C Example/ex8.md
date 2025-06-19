---
title: "[ex8] 100원 미만을 반올림 하는 코드를 구현"
tags:
    - Study
    - Language
date: "2025-03-18"
thumbnail: "/assets/img/thumbnail/C.png"
bookmark: true
---
# 문제 설명
---
입력받은 4자리 이상 정수에서 100원 미만을 반올림 하는 코드를 구현하시오
즉, 50원 이상이면 올림처리하고 49원 이하이면 내림처리를 한다
예를들어, 1249원이면 100원 미만이 49원이므로 1200원이 된다. 4350원이면 100원 미만이 50원이므로 4400원이 된다

```c
#include <stdio.h>
int main(void) 
{
	int A;
	scanf("%d", &A);

	

	printf("%d\n", A);
	return 0;
}
```

# 입력 설명
---

```
4자리 이상의 정수 입력
```

# 출력 설명
---

```
100원 미만을 반올림 처리한 결과를 출력
```

# 입력 예시
---

```
1249
```

# 출력 예시
---

```
1200
```

# 정답 코드
---

```c
#include <stdio.h>
int main(void) {
	int A;
	scanf("%d", &A);

	A = (A + 50) / 100 * 100;

	printf("%d\n", A);
	return 0;
}
```

# 메모
---
> printf 내부의 **\n** 습관화 필요