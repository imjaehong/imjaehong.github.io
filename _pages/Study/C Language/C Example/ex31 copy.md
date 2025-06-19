---
title: "[ex31] 시간차 구하기"
tags:
    - Study
    - Language
date: "2025-03-18"
thumbnail: "/assets/img/thumbnail/C.png"
bookmark: true
---
# 문제 설명
---
HH:MM:SS(시:분:초)의 형태로 표시하는 2개의 시간이 주어졌을 때, 시간차를 구하는 프로그램을 작성한다.
2개의 시간은 최대 24시간 차이가 난다고 가정한다.

```c
#include <stdio.h>

int main(void)
{
	int h1, m1, s1, h2, m2, s2;
	int h, m, s;

	// 입력받는 부분
	scanf("%d:%d:%d", &h1, &m1, &s1);
	scanf("%d:%d:%d", &h2, &m2, &s2);

	// 여기서부터 작성


	// 출력하는 부분
	printf("%02d:%02d:%02d", h, m, s);

	return 0;
}
```

# 입력 설명
---

```
입력은 두 개의 시간이 입력된다. 시간이 입력되는 형태는 다음과 같다. "HH:MM:SS"
HH는 시, MM은 분, SS는 초를 뜻한다. 만약 시나 분, 초가 한 자리 숫자일 경우 앞에 0을 붙이게 된다.
(0≤HH≤23, 0≤MM, SS≤59)
앞에 입력된 시간보다 뒤의 입력된 시간이 더 늦은 시간이라고 가정한다
```

# 출력 설명
---

```
입력된 2개의 시간에 대한 시간차를 HH:MM:SS의 형태로 출력한다.
```

# 입력 예시
---

```
20:00:00
04:00:00
```

# 출력 예시
---

```
08:00:00
```

# 정답 코드
---

```c
#include <stdio.h>

int main(void)
{
	int h1, m1, s1, h2, m2, s2;
	int h, m, s;
	int ss, es;

	// 입력받는 부분
	scanf("%d:%d:%d", &h1, &m1, &s1);
	scanf("%d:%d:%d", &h2, &m2, &s2);

	// 여기서부터 작성
	ss = (h1 * 60 + m1) * 60 + s1;
	es = (h2 * 60 + m2) * 60 + s2;

	if (es > ss) ss = es - ss;
	else ss = 3600 * 24 - ss + es;

	h = ss / (60 * 60);
	m = ss % (60 * 60) / 60;
	s = ss % 60;

	// 출력하는 부분
	printf("%02d:%02d:%02d", h, m, s);

	return 0;
}
```

# 메모
---
> printf 내부의 **\n** 습관화 필요