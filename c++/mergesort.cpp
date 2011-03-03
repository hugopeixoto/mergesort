
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

template<typename IT> void merge(IT begin, IT middle, IT end, IT res)
{
	IT a = begin, b = middle, r = res;

	while (a < middle && b < end)
		if (*a < *b) *r++ = *a++;
		else *r++ = *b++;

	while (a < middle) *r++ = *a++;
	while (b < end) *r++ = *b++;
	while (begin < end) *begin++ = *res++;
}

template<typename IT> void mergesort(IT begin, IT end, IT res)
{
	int s = end-begin;
	if (s > 1)
	{
		IT middle = begin+s/2;
		mergesort(begin, middle, res);
		mergesort(middle, end, res);
		merge(begin, middle, end, res);
	}
}

int main()
{
	int lst[] = {10, 9, 8, 4, 5, 6, 7, 3, 2, 1};
    int sorted[10];

	mergesort(lst, lst + 10, sorted);

	for (int i = 0; i < 10; i++)
		cout << sorted[i] << " ";
	cout << endl;
	return 0;
}
