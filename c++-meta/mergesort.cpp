
#include <iostream>
using namespace std;

/* If, then, else. */
template<bool v, typename A, typename B>
struct mif {};

template<typename A, typename B>
struct mif<true, A, B> { typedef A value; };

template<typename A, typename B>
struct mif<false, A, B> { typedef B value; };


/* List definition */
template<int v, typename T>
struct cons { static const int value = v; typedef T rest; };
struct nil { };


/* List size definition */
template<typename T>
struct len { enum { value = 1 + len<typename T::rest>::value }; };

template<>
struct len<nil> { enum { value = 0 }; };


/* First N elements */
template<typename T, int n>
struct head {
  typedef cons<
    T::value,
    typename head<typename T::rest, n - 1>::value
  > value;
};

template<int n>
struct head<nil, n> { typedef nil value; };

template<typename T>
struct head<T, 0> { typedef nil value; };


/* Remove first N elements */
template<typename T, int n>
struct tail { typedef typename tail<typename T::rest, n - 1>::value value; };

template<int n>
struct tail<nil, n> { typedef nil value; };

template<typename T>
struct tail<T, 0> { typedef T value; };


/* Merge two sorted lists */
template<typename A, typename B>
struct merge {
  typedef typename mif<
    (A::value < B::value),
    cons<A::value, typename merge<typename A::rest, B>::value >,
    cons<B::value, typename merge<A, typename B::rest>::value >
    >::value
  value;
};

template<typename A>
struct merge<A, nil> { typedef A value; };

template<typename B>
struct merge<nil, B> { typedef B value; };


/* Sort a list */
template<typename A, bool v = (len<A>::value < 2)>
struct mergesort { typedef A value; };

template<typename A>
struct mergesort<A, false> {
  typedef typename merge<
    typename mergesort<typename head<A, (len<A>::value / 2)>::value>::value,
    typename mergesort<typename tail<A, (len<A>::value / 2)>::value>::value
    >::value
  value;
};


/* Print a list */
template<typename A>
void print() { cout << A::value << endl; print<typename A::rest>(); }

template<>
void print<nil>() {  }


int main()
{
  /* Create a list */
  typedef cons<10, cons<9, cons<8, cons<7, cons<4, cons<5, cons<6, cons<3, cons<2, cons<1, nil> > > > > > > > > > x;

  /* Sort it */
  typedef mergesort<x>::value sorted;

  /* Print it */
  print<sorted>();
	return 0;
}
