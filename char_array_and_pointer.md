```
#include <stdio.h>

int main(int argc, const char* argv[])
{
	char *states[] = {
		"jang", "yang",
		"jing", "shan"
	};
	char name[] = "janghuan";
	char *name_pt = "safd";

	printf("size of states is %zu.\n", sizeof(states)); // 数组中每个元素是一个指向 char 的指针，指针都是 8 个字节，所以一共 32 个字节
	printf("size of name is %zu.\n", sizeof(name)); // 每个 char 类型占 1 个自己，字符数组还有最后一个 \0 字符，所以一共 9 个字节
	printf("size of name_pt is %zu.\n", sizeof(name_pt)); // 指针都是 8 个字节，在 64 位机器上
	printf("size of char pointer is %zu.\n", sizeof(char *)); // 同上
	printf("size of int pointer is %zu.\n", sizeof(int *)); // 同上
	return 0;
}
```
