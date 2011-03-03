#include <stdio.h>

int lst[] = {10, 9, 8, 4, 5, 6, 7, 3, 2, 1};

void merge(int * lst, int a, int b, int s)
{
	int tmp[10], ti = a, ai = a, bi = b;
	while (ai < b || bi < s)
	{
		if (bi == s)			tmp[ti++] = lst[ai++];
		else if (ai == b)		tmp[ti++] = lst[bi++];
		else if (lst[ai] < lst[bi])	tmp[ti++] = lst[ai++];
		else				tmp[ti++] = lst[bi++];
	}
	
	for (ti = a; ti < s; ti++)
		lst[ti] = tmp[ti];
}

void mergesort(int * lst, int a, int b)
{
	if (b-a < 2)
		return;

	mergesort(lst, a, a + (b-a)/2);
	mergesort(lst, a + (b-a)/2, b);
	merge(lst, a, a + (b-a)/2, b);
}

int main()
{
	int i;
	mergesort(lst, 0, 10);
	for (i = 0; i < 10; i++)
		printf("%d ", lst[i]);

	printf("\n");
	return 0;
}

