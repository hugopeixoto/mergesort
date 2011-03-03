
def merge(a, b):
	if len(a)*len(b) == 0:
		return a+b

	v = (a[0] < b[0] and a or b).pop(0)
	return [v] + merge(a, b)

def mergesort(lst):
	if len(lst) < 2:
		return lst

	m = len(lst)/2
	return merge(mergesort(lst[:m]), mergesort(lst[m:]))

mlst = [10, 9, 8, 4, 5, 6, 7, 3, 2, 1]
sorted = mergesort(mlst)
print sorted
