
list_head(_, 0, []).
list_head([H|T], N, [H|Sub]) :-
	N1 is N-1,
	list_head(T, N1, Sub).

list_tail(T, 0, T).
list_tail([_|T], N, R) :-
	N1 is N-1,
	list_tail(T, N1, R).

merge(A, [], A).
merge([], B, B).
merge([Ha|Ta], [Hb|Tb], [Ha|Sub]) :-
	Ha < Hb,
	merge(Ta, [Hb|Tb], Sub).

merge([Ha|Ta], [Hb|Tb], [Hb|Sub]) :-
	Ha >= Hb,
	merge([Ha|Ta], Tb, Sub).

mergesort([H], [H]).
mergesort(List, Sorted) :-
			length(List, Number),
			Half is Number // 2,
			list_head(List, Half, H),
			list_tail(List, Half, T),
			mergesort(H, A),
			mergesort(T, B),
			merge(A, B, Sorted).

test(Sorted) :-
  mergesort([10, 9, 8, 4, 5, 6, 7, 3, 2, 1], Sorted).
