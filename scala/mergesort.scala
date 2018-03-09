def mergesort[T](xs: Seq[T])(implicit ord: Ordering[T]): Seq[T] = {
  def merge(left: Seq[T], right: Seq[T]): Seq[T] = {
    (left, right) match {
      case (Seq(), rs) => rs
      case (ls, Seq()) => ls
      case (Seq(l, lr @ _*), Seq(r, rr @ _*)) =>
        if (ord.lt(l, r))
          l +: merge(Seq(lr: _*), right)
        else
          r +: merge(left, Seq(rr: _*))
    }
  }

  val n = xs.length / 2
  if (n == 0)
    xs
  else {
    val (left, right) = xs.splitAt(n)
    merge(mergesort(left), mergesort(right))
  }
}

println(mergesort(Seq(10, 9, 8, 4, 5, 6, 7, 3, 2, 1)).mkString(" "))
