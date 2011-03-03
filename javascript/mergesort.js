
function merge(lst, a, m, b) {
	tmp = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
	ai = a;
	bi = m;
	ti = a;

	while (ai < m || bi < b) {
		if (ai == m)			tmp[ti++] = lst[bi++];
		else if (bi == b)		tmp[ti++] = lst[ai++];
		else if (lst[ai] < lst[bi])	tmp[ti++] = lst[ai++];
		else				tmp[ti++] = lst[bi++];
	}

	for (i = a; i < b; i++)
		lst[i] = tmp[i];
}

function mergesort(lst, a, b) {
	if (b - a < 2)
		return;

	m = ((b - a) / 2)|0;
	mergesort(lst, a, a + m);
	mergesort(lst, a + m, b);
	merge(lst, a, a + m, b);
}

lst = [10, 9, 8, 4, 5, 6, 7, 3, 2, 1];
mergesort(lst, 0, 10);
print(lst);

