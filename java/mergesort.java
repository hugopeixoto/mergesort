import java.util.*;

class mergesort
{
	public static void merge(int[] lst, int a, int m, int b)
	{
		int[] tmp = new int[10];
		int ai = a, bi = m, ti = a;

		while (ai < m || bi < b)
		{
			if (ai == m)			tmp[ti++] = lst[bi++];
			else if (bi == b)		tmp[ti++] = lst[ai++];
			else if (lst[ai] < lst[bi])	tmp[ti++] = lst[ai++];
			else				tmp[ti++] = lst[bi++]; 
		}

		for (ti = a; ti < b; ti++)
			lst[ti] = tmp[ti];
	}

	public static void mergesort(int[] lst, int a, int b)
	{
		if (b-a < 2)
			return;
		
		mergesort(lst, a, a + (b-a) / 2);
		mergesort(lst, a + (b-a) / 2, b);
		merge(lst, a, a + (b-a) / 2, b);
	}
	public static void main(String[] args)
	{
		int[] lst = new int[] {10, 9, 8, 4, 5, 6, 7, 3, 2, 1};

		mergesort(lst, 0, 10);
		for (int i = 0; i < 10; i++)
			System.out.print(lst[i] + " ");
		System.out.println("\n");
	}
}
