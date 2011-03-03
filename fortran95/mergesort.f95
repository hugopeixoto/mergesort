program testmergesort
        integer lst(10)
        lst = (/ 10, 9, 8, 4, 5, 6, 7, 3, 2, 1 /)
        call mergesort(lst, 0, 10)
        call show(lst)
end program testmergesort

subroutine _merge(lst, a, middle, b)
        integer a
        integer b
        integer middle
        integer lst(10)
        integer tmp(10)
        integer ai
        integer bi
        integer ti
        integer x
        ai = a
        bi = middle
        ti = a

        do while ((ai .lt. middle) .or. (bi .lt. b))
                if (ai .eq. middle) then
                        tmp(ti+1) = lst(bi+1)
                        bi = bi + 1
                else if (bi .eq. b) then
                        tmp(ti+1) = lst(ai+1)
                        ai = ai + 1
                else if (lst(ai+1) .lt. lst(bi+1)) then
                        tmp(ti+1) = lst(ai+1)
                        ai = ai + 1
                else
                        tmp(ti+1) = lst(bi+1)
                        bi = bi + 1
                end if
                ti = ti + 1
        end do
        do x = a, b - 1
                lst(x + 1) = tmp(x + 1)
        end do
end

recursive subroutine mergesort(lst, a, b)
        integer a
        integer b
        integer lst(10)
        integer diff
        diff = b - a
        if (diff .lt. 2) then
                return
        else
                diff = diff / 2
                call mergesort(lst, a, a + diff)
                call mergesort(lst, a + diff, b)
                call _merge(lst, a, a + diff, b)
        endif
end

subroutine show(lst)
        integer lst(10)
        integer x
        do x = 1, 10
                print 100, lst(x)
        end do

100 format (i0)
end

