#include once "ustring.bi"
#INCLUDE ONCE "/crt/string.bi"
#INCLUDE ONCE "/crt/stdlib.bi"


#pragma once


'***********************************************************************************************
' Copyright (c) 2019 Juergen Kuehlwein
' Freeware. Use at your own risk.
' THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
' EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
' MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
' ****************************************************************************************


' array_sort    - sort all kinds of arrays in many ways including custom sort
' array_insert  - insert an element into an one-dimensional array an assign a value to it
' array_delete  - delete an element of an one-dimensional array and close the gap


'***********************************************************************************************
' prototype of a custom sort procedure:
' it must be CDECL, and you must choose the corresponding data type (zstring is just an example)
'***********************************************************************************************


'PRIVATE FUNCTION CustomSortProc CDECL (BYVAL a AS zstring PTR, BYVAL b AS zstring PTR) AS LONG
''***********************************************************************************************
'' qsort custom comparison function
'' return  1, if a should precede b in sorting
'' return -1, if b should precede a in sorting
'' return  0, if both are equal
'' for UDT: compare member variable(s) to get the desired order
''***********************************************************************************************
'
'  if ucase(*a) > ucase(*b) then                       'make it case insensitive
'  if *a > *b then                                     'case sensitive
'    return 1
'  elseif *a < *b then
'    return -1
'  else
'    return 0
'  end if  
'
'
'END FUNCTION


' You may implement other predefined string sorting functions like: CompareStringEx

' CompareStringEx returns one of the following values if successful: 1,2,3 To maintain the C runtime
' convention of comparing strings, the value 2 can be subtracted from a nonzero return value.
' Then, the meaning of <0, ==0, and >0 is consistent with the C runtime.
' CSTR_LESS_THAN (-1). The string indicated by a is less in lexical value than the string indicated by b.
' CSTR_EQUAL (0). The string indicated by a is equivalent in lexical value to the string indicated by b.
' The two strings are equivalent for sorting purposes, although not necessarily identical.
' CSTR_GREATER_THAN (1). The string indicated by a is greater in lexical value than the string indicated by b.

' The function returns 0 if it does not succeed. To get extended error information, the application
' can call GetLastError, which can return one of the following error codes:
' ERROR_INVALID_FLAGS. The values supplied for flags were invalid.
' ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.

'***********************************************************************************************
'***********************************************************************************************


#macro AC_SORT(a, b)
  if *a > *b then
    return 1
  elseif *a < *b then
    return -1
  else
    return 0
  end if  
#endmacro


PRIVATE FUNCTION AC_Byte CDECL (BYVAL a AS Byte PTR, BYVAL b AS Byte PTR) AS LONG
  AC_SORT(a, b)
end function

PRIVATE FUNCTION AC_UByte CDECL (BYVAL a AS uByte PTR, BYVAL b AS uByte PTR) AS LONG
  AC_SORT(a, b)
end function

PRIVATE FUNCTION AC_Short CDECL (BYVAL a AS Short PTR, BYVAL b AS Short PTR) AS LONG
  AC_SORT(a, b)
end function

PRIVATE FUNCTION AC_UShort CDECL (BYVAL a AS UShort PTR, BYVAL b AS UShort PTR) AS LONG
  AC_SORT(a, b)
end function

PRIVATE FUNCTION AC_Integer CDECL (BYVAL a AS Integer PTR, BYVAL b AS Integer PTR) AS LONG
  AC_SORT(a, b)
end function

PRIVATE FUNCTION AC_UInteger CDECL (BYVAL a AS UInteger PTR, BYVAL b AS UInteger PTR) AS LONG
  AC_SORT(a, b)
end function

PRIVATE FUNCTION AC_Long CDECL (BYVAL a AS Long PTR, BYVAL b AS Long PTR) AS LONG
  AC_SORT(a, b)
end function

PRIVATE FUNCTION AC_ULong CDECL (BYVAL a AS ULong PTR, BYVAL b AS ULong PTR) AS LONG
  AC_SORT(a, b)
end function

PRIVATE FUNCTION AC_Longint CDECL (BYVAL a AS Longint PTR, BYVAL b AS Longint PTR) AS LONG
  AC_SORT(a, b)
end function

PRIVATE FUNCTION AC_ULongint CDECL (BYVAL a AS ULongint PTR, BYVAL b AS ULongint PTR) AS LONG
  AC_SORT(a, b)
end function

PRIVATE FUNCTION AC_Single CDECL (BYVAL a AS Single PTR, BYVAL b AS Single PTR) AS LONG
  AC_SORT(a, b)
end function

PRIVATE FUNCTION AC_Double CDECL (BYVAL a AS Double PTR, BYVAL b AS Double PTR) AS LONG
  AC_SORT(a, b)
end function

PRIVATE FUNCTION AC_ZString CDECL (BYVAL a AS ZString PTR, BYVAL b AS ZString PTR) AS LONG
  AC_SORT(a, b)
end function

PRIVATE FUNCTION AC_String CDECL (BYVAL a AS String PTR, BYVAL b AS String PTR) AS LONG
  AC_SORT(a, b)
end function

PRIVATE FUNCTION AC_WString CDECL (BYVAL a AS WString PTR, BYVAL b AS WString PTR) AS LONG
  AC_SORT(a, b)
end function

PRIVATE FUNCTION AC_UString CDECL (BYVAL a AS UString PTR, BYVAL b AS UString PTR) AS LONG
  AC_SORT(a, b)
end function

#ifdef AFX                                            'include José´s "CBstr" if WinFBX is present
PRIVATE FUNCTION AC_CBstr CDECL (BYVAL a AS CBstr PTR, BYVAL b AS CBstr PTR) AS LONG
  AC_SORT(a, b)
end function
#endif


#macro DC_SORT(a, b)
  if *a < *b then
    return 1
  elseif *a > *b then
    return -1
  else
    return 0
  end if  
#endmacro


PRIVATE FUNCTION DC_Byte CDECL (BYVAL a AS Byte PTR, BYVAL b AS Byte PTR) AS LONG
  DC_SORT(a, b)
end function

PRIVATE FUNCTION DC_UByte CDECL (BYVAL a AS uByte PTR, BYVAL b AS uByte PTR) AS LONG
  DC_SORT(a, b)
end function

PRIVATE FUNCTION DC_Short CDECL (BYVAL a AS Short PTR, BYVAL b AS Short PTR) AS LONG
  DC_SORT(a, b)
end function

PRIVATE FUNCTION DC_UShort CDECL (BYVAL a AS UShort PTR, BYVAL b AS UShort PTR) AS LONG
  DC_SORT(a, b)
end function

PRIVATE FUNCTION DC_Integer CDECL (BYVAL a AS Integer PTR, BYVAL b AS Integer PTR) AS LONG
  DC_SORT(a, b)
end function

PRIVATE FUNCTION DC_UInteger CDECL (BYVAL a AS UInteger PTR, BYVAL b AS UInteger PTR) AS LONG
  DC_SORT(a, b)
end function

PRIVATE FUNCTION DC_Long CDECL (BYVAL a AS Long PTR, BYVAL b AS Long PTR) AS LONG
  DC_SORT(a, b)
end function

PRIVATE FUNCTION DC_ULong CDECL (BYVAL a AS ULong PTR, BYVAL b AS ULong PTR) AS LONG
  DC_SORT(a, b)
end function

PRIVATE FUNCTION DC_Longint CDECL (BYVAL a AS Longint PTR, BYVAL b AS Longint PTR) AS LONG
  DC_SORT(a, b)
end function

PRIVATE FUNCTION DC_ULongint CDECL (BYVAL a AS ULongint PTR, BYVAL b AS ULongint PTR) AS LONG
  DC_SORT(a, b)
end function

PRIVATE FUNCTION DC_Single CDECL (BYVAL a AS Single PTR, BYVAL b AS Single PTR) AS LONG
  DC_SORT(a, b)
end function

PRIVATE FUNCTION DC_Double CDECL (BYVAL a AS Double PTR, BYVAL b AS Double PTR) AS LONG
  DC_SORT(a, b)
end function

PRIVATE FUNCTION DC_ZString CDECL (BYVAL a AS ZString PTR, BYVAL b AS ZString PTR) AS LONG
  DC_SORT(a, b)
end function

PRIVATE FUNCTION DC_String CDECL (BYVAL a AS String PTR, BYVAL b AS String PTR) AS LONG
  DC_SORT(a, b)
end function

PRIVATE FUNCTION DC_WString CDECL (BYVAL a AS WString PTR, BYVAL b AS WString PTR) AS LONG
  DC_SORT(a, b)
end function

PRIVATE FUNCTION DC_UString CDECL (BYVAL a AS UString PTR, BYVAL b AS UString PTR) AS LONG
  DC_SORT(a, b)
end function

#ifdef AFX                                            'include José´s "CBstr" if WinFBX is present
PRIVATE FUNCTION DC_CBstr CDECL (BYVAL a AS CBstr PTR, BYVAL b AS CBstr PTR) AS LONG
  DC_SORT(a, b)
end function
#endif


private Function arrayDescriptorGetPtrFunction (Byval p As Any Ptr) As Any Ptr    'thanks to fxm
  Return p
End function

#macro arrayDescriptorPtr(array, p)                   'thanks to fxm
  Scope
    Dim As Function (() As Typeof((array))) As Any Ptr f
    f = Cast(Function (() As Typeof((array))) As Any Ptr, @arrayDescriptorGetPtrFunction)
    p = f(array())
  End Scope
#endmacro


#define all(X) A, X, 0                                'sort the whole array or a given dimension
#define ascend AC                                     'sort ascending
#define descend DC                                    'sort descending

#define ascend_ AC, A, 1, 0                           'sort the entire 1. dimension ascending
#define descend_ DC, A, 1, 0                          'sort the entire 1. dimension descending


#macro array_Sort(x, t, D, I, C)
'***********************************************************************************************
' array_sort(array, ascend/descend/@Customsortproc, dimension, index , count)

' Sorts a one-dimensional(!) fixed-size or dynamic array calling the C qsort function. 
' String sorting is case sensitive. Make it case insensitive by using a custom sort (ucase compare)

' 5 Parameters:
' - x: array variable without brackets
' - t: "ac"/"{a}s{c}end", "dc"/"{d}es{c}end" or a pointer to a custom sort function (@customsortproc)
'      "a/descend_" replaces the last 4 parameters and sorts the first dimension entirely

' Example: array_sort(myarray, ascend_)

' - d: dimension
' - i: absolute index to start at (inside dimension)
' - c: count (# of elements to sort)

' the last three argumemts may be replaced by "ALL()", "ALL(1)", "ALL(2)" ...
' where the nimber inside the brackets denominates the dimension to sort entirely
' "ALL()" sorts the entire array over all dimensions

' Example: array_sort(myarray, ac, 2, 3, 4): sorts 4 elements in the 2. dimension
'                                            of myarray starting at myarray(2, 3)
' Example: array_sort(myarray, ac, all(3)) : sorts the 3. dimension of myarray entirely

' Example: array_sort(myarray, ascend_)    : sorts the 1. dimension of myarray entirely ascending

' ERR = 0 for success, = 6 for invalid index or dimension values, 7 for invalid custon sort proc
' any other value = run time error  
'***********************************************************************************************
scope
dim p__t_r as any ptr
dim n__u_m as ulong = 0


  err = 0

  #if (#D = "A")                                      'all(...)
    #if (#i = "")                                     'whole array
      scope 
        dim l as long                                 'looper
        dim z as long                                 '# of dimensions available
        dim n as long                                 'max. size of dimension
        Dim As Integer Ptr pArrayDescriptor

        z = ubound(x, 0)                              '# of dimensions
        if z <= 0 then
          err = 6

        else
          for l = 1 to z 
            n = UBOUND(x, l) - LBOUND(x, l) + 1
            if n > n__u_m then
              n__u_m = n
            end if  
          next l

          n__u_m = n__u_m * z

          arrayDescriptorPtr(x, pArrayDescriptor)
          p__t_r = Cptr(Integer Ptr Ptr, pArrayDescriptor)[1]
        end if
      end scope
      
    #else                                             'dimension #i
      scope 
        dim l as long                                 'looper
        dim z as long                                 '# of dimensions available
        dim n as long                                 'max. size of dimension
        Dim As Integer Ptr pArrayDescriptor

        z = ubound(x, 0)                              '# of dimensions
        if (z <= 0) or (i < 1) or (i > z) then
          err = 6

        else
          for l = 1 to z 
            n = UBOUND(x, l) - LBOUND(x, l) + 1
            if n > n__u_m then
              n__u_m = n
            end if  
          next l

          n__u_m = n__u_m * (i-1)

          arrayDescriptorPtr(x, pArrayDescriptor)

          p__t_r = Cptr(Integer Ptr Ptr, pArrayDescriptor)[1]
          p__t_r = p__t_r + (n__u_m * sizeof(typeof((x))))
          n__u_m = UBOUND(x, i) - LBOUND(x, i) + 1
        end if
      end scope
      
    #endif
  
  #else                                               'dimension #d, from i, for c
    scope 
      dim l as long                                   'looper
      dim z as long                                   '# of dimensions available
        dim n as long                                 'max. size of dimension
      Dim As Integer Ptr pArrayDescriptor

      z = ubound(x, 0)                                '# of dimensions
      if (z <= 0) or (d < 1) or (d > z) then
        err = 6

      else
        for l = 1 to z 
          n = UBOUND(x, l) - LBOUND(x, l) + 1
          if n > n__u_m then
            n__u_m = n
          end if  
        next l

        n__u_m = n__u_m * (d-1)

        arrayDescriptorPtr(x, pArrayDescriptor)
        p__t_r = Cptr(Integer Ptr Ptr, pArrayDescriptor)[1]
        p__t_r = p__t_r + (n__u_m + i - 1) * sizeof(typeof((x)))
        n__u_m = c
      end if
    end scope
  #endif
  

  #if (#t = "ac") or (#t = "Ac") or (#t = "AC") or (#t = "aC")
    #if TypeOf((x)) = BYTE
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @AC_Byte)
    #elseif TypeOf((x)) = UBYTE
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @AC_UByte)
    #elseif TypeOf((x)) = SHORT
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @AC_Short)
    #elseif TypeOf((x)) = USHORT
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @AC_UShort)
    #elseif TypeOf((x)) = INTEGER
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @AC_Integer)
    #elseif TypeOf((x)) = UINTEGER
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @AC_UInteger)
    #elseif TypeOf((x)) = LONG
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @AC_Long)
    #elseif TypeOf((x)) = ULONG
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @AC_ULong)
    #elseif TypeOf((x)) = LONGINT
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @AC_Longint)
    #elseif TypeOf((x)) = ULONGINT
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @AC_ULongint)

    #elseif TypeOf((x)) = SINGLE
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @AC_Single)
    #elseif TypeOf((x)) = DOUBLE
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @AC_Double)

    #elseif typeof((x)) = typeof(zstring * sizeof(typeof((x))))
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @AC_ZString)
    #elseif TypeOf((x)) = STRING
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @AC_String)
    #elseif typeof((x)) = typeof(Wstring * sizeof(typeof((x))))
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @AC_Wstring)
    #elseif TypeOf((x)) = Typeof(USTRING)
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @AC_UString)
    #elseif TypeOf((x)) = TypeOf(CWSTR)
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @AC_UString)
    #elseif TypeOf((x)) = TypeOf(CBSTR)
      #ifdef AFX
        if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @AC_CBstr)
      #endif
    #else
      #error "Only standard variable types are supported, consider using a custom sort function"
    #endif

  #elseif (#t = "dc") or (#t = "Dc") or (#t = "DC") or (#t = "dC")
    #if TypeOf((x)) = BYTE
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @DC_Byte)
    #elseif TypeOf((x)) = UBYTE
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @DC_UByte)
    #elseif TypeOf((x)) = SHORT
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @DC_Short)
    #elseif TypeOf((x)) = USHORT
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @DC_UShort)
    #elseif TypeOf((x)) = INTEGER
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @DC_Integer)
    #elseif TypeOf((x)) = UINTEGER
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @DC_UInteger)
    #elseif TypeOf((x)) = LONG
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @DC_Long)
    #elseif TypeOf((x)) = ULONG
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @DC_ULong)
    #elseif TypeOf((x)) = LONGINT
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @DC_Longint)
    #elseif TypeOf((x)) = ULONGINT
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @DC_ULongint)

    #elseif TypeOf((x)) = SINGLE
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @DC_Single)
    #elseif TypeOf((x)) = DOUBLE
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @DC_Double)

    #elseif typeof((x)) = typeof(zstring * sizeof(typeof((x))))
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @DC_ZString)
    #elseif TypeOf((x)) = STRING
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @DC_String)
    #elseif typeof((x)) = typeof(Wstring * sizeof(typeof((x))))
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @DC_Wstring)
    #elseif TypeOf((x)) = Typeof(USTRING)
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @DC_UString)
    #elseif TypeOf((x)) = TypeOf(CWSTR)
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @DC_UString)
    #elseif TypeOf((x)) = TypeOf(CBSTR)
      #ifdef AFX
        if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), CPTR(ANY PTR, @DC_CBstr)
      #endif
    #else
      #error "Only standard variable types are supported, consider using a custom sort function"
    #endif

  #else
    if t <> 0 then                                    'prevent null pointer
      if n__u_m > 1 then qsort p__t_r, n__u_m, sizeof(typeof((x))), cast(any ptr, t)

    else
      err = 7
    end if  
  #endif
end scope
#endmacro


'***********************************************************************************************


#macro array_insert(a, i, v)                          'array, (absolute) index , value
'***********************************************************************************************
' Inserts a new element at the specified index of a dynamic array and assigns a value to it
' this macro fails for fixed-size arrays (cannot be redimed!)

' 3 Parameters:
' - a: array (without brackets)
' - i: absolute index in the array where the new element will be added.
' - v: value of the new element. 
'      this may be a variable of the same type or constant where applicable
'      for UDTs not supporting the "=" operator, you must pass a variable of
'      the same type, initialzed to whatever is needed

' ERR is set to 0 for success, to 99 for fixed-size array, 6 = invalid index
' any other value = run time error  
'***********************************************************************************************
scope
err = 0                                               'assume success

DIM l__b AS LONG = LBOUND(a)
DIM u__b AS LONG = UBOUND(a)

  IF (i >= l__b) and (i <= u__b + 1) THEN             'a valid index
    scope
      REDIM PRESERVE a(l__b TO u__b + 1)
    END scope                                         'this scope is necessary for correct results of ubound(a)
                                                      'in case of a fixed-size array

    IF UBOUND(a) = u__b + 1 THEN                      'success
      FOR z AS LONG = UBOUND(a) TO i + 1 STEP - 1     'move elements up, last one first
         a(z) = a(z - 1)
      NEXT

      a(i) = v                                        'assign value to new element

    else
      err = 99                                        'return fail (fixed-size array)
    end if

  else
    err = 6                                           'index out of bounds
  end if  
END scope
#endmacro


'***********************************************************************************************


#macro array_delete(a, i)                             'array, (absolute) index
'***********************************************************************************************
' Deletes the element at the specified index of a dynamic array by shifting down all
' following elements, this function works for fixed-size arrays too
' Please note: in case of a fixed-size array the last element will still be present
' (cannot be redimed!) but it will be reinitialzed to it´s default state

' 2 Parameters:
' - a: array (without brackets)
' - i: absolute index in the array which will be deleted

' ERR is set to 0 for success, to 99 for fixed-size array, any other value = run time error  
'***********************************************************************************************
scope
err = 0                                               'assume success

DIM l__b AS LONG = LBOUND(a)
DIM u__b AS LONG = UBOUND(a)

  scope
    IF (i >= l__b) and (i <= u__b + 1) THEN           'a valid index
      FOR z AS LONG = i to u__b - 1                   'move items down
         a(z) = a(z + 1)
      NEXT

      REDIM PRESERVE a(l__b TO u__b - 1)              'try to remove the last element

    else
      u__b += 1                                       'make ubound(a) <> u__b !
    end if  
  END scope                                           'this scope is necessary for correct results of ubound(a)
                                                      'in case of a fixed-size array

  IF UBOUND(a) = u__b THEN                            'a fixed-size array
    dim x as typeof(a)
    a(ubound(a)) = x                                  'reinitialize the variable, because it wasn´t deleted

    err = 99                                          'was a fixed-size array
  end if

end scope
#endmacro


'***********************************************************************************************
'***********************************************************************************************
'***********************************************************************************************
