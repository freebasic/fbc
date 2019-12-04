''**********************************************************************************************
'' Copyright (c) 2019 Juergen Kuehlwein
''
'' License: GNU Lesser General Public License version 2.1 (or any later version)
''
'' THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
'' EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
'' MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
''**********************************************************************************************

' naming convention: "array" is reserved for array main macro, all others are prefixed by
'                    "array_..."  or "ax_..."

'***********************************************************************************************
' syntax:
'***********************************************************************************************
' array(sort, array)
' array(sort, array, down [, (i1 [, i2 [, ...]]) | pos(i), [, count]])
' array(sort, (array, nocase))
' array(sort, (array1, array2, nocase) [, (i1 [, i2 [, ...]]) | pos(i), [, count]])
' array(sort, (array, nocase), down [, (i1 [, i2 [, ...]]) | pos(i), [, count]])
' array(sort, array, @customsortproc [, (i1 [, i2 [, ...]]) | pos(i), [, count]])
'***********************************************************************************************
    
'***********************************************************************************************
' array(insert, array, value [, (i1 [, i2 [, ...]]) | pos(i), [, count]])
'***********************************************************************************************
  
'***********************************************************************************************
' array(delete, array [, (i1 [, i2 [, ...]]) | pos(i), [, count]])
'***********************************************************************************************
  
'***********************************************************************************************
' i = array(scan, array, for()[, (i1 [, i2 [, ...]]) | pos(i), [, count]]), returns linear index
' for(searchterm [,nocase])
' for(@customproc)
'***********************************************************************************************

'***********************************************************************************************
' i = array(specifier, array), returns requested value as uinteger, any ptr or boolean
'***********************************************************************************************
' data                                      'pointer to the first array element in memory
' dimensions                                '# of dimensions (same as UBOUND(array, 0)
' total_size                                'in bytes
' total_count                               'total # of elements in all dimensions
' sizeof                                    'same as sizeof(array)
' is_fixed_len                              'fixed size array
' is_fixed_dim                              'fixed dimension array
' is_dynamic                                'dynamic array
' is_attached                               'attached array
'***********************************************************************************************

'***********************************************************************************************
' i = array(pos, array, (i1 [, i2 [,...]])) returns linear (one based) position from (array)index
' i = array(ptr, array, (i1 [, i2 [,...]])) returns memory ptr for this index
' u = array(index, array, pos)              returns array_index
' u = array(index, array, ptr)              returns array_index
'***********************************************************************************************
  
'***********************************************************************************************
' array(attach, array, redim(1 to 5[, 1 to 6 [1,  ...]]), memory ptr)
' array(reset, array)
'***********************************************************************************************


#pragma once
#include once "ustring.bi"


type array_index                                      'return type for array(index, ...)
  n as integer                                        '# of valid index entries, 0 -> no indices given

  li as integer                                       'linear index (one based), 0 = invalid
  i1 as integer                                       'index 1
  i2 as integer                                       '...
  i3 as integer
  i4 as integer
  i5 as integer
  i6 as integer
  i7 as integer
  i8 as integer
end type


namespace array_                                      'array extension namespace

enum ae_                                              'data types
  ADT_BYTE         = 1  
  ADT_UBYTE
  ADT_SHORT
  ADT_USHORT
  ADT_INTEGER
  ADT_UINTEGER
  ADT_LONG
  ADT_ULONG
  ADT_LONGINT
  ADT_ULONGINT
   
  ADT_SINGLE       = 20
  ADT_DOUBLE
   
  ADT_ZSTRING      = 30
  ADT_FIXSTRING
  ADT_STRING
  ADT_WSTRING
  ADT_USTRING
   
  ADT_STRUCT       = 40
  ADT_FUNCTION     = 50

                                                      'enums for retrieving array descriptor information
  DESC             = 60                               'get descriptor information
  DATA                                                'pointer to the first array element in memory
  DIMENSIONS                                          '# of dimensions (same as UBOUND(array, 0)
  TOTAL_SIZE                                          'in bytes
  TOTAL_COUNT                                         'total # of elements in all dimensions
  SIZE                                                'same as sizeof(array)
  IS_FIXED_LEN                                        'fixed size array
  IS_FIXED_DIM                                        'fixed dimension array
  IS_DYNAMIC                                          'dynamic array
  IS_ATTACHED                                         'attached array

  NOCASEFLAG       = 0                                '"nocase" check for array(scan, ...)
  NOCASEFLAGNOCASE = 100

end enum


type array_index_type
  i1s as integer
  i1e as integer

  i2s as integer
  i2e as integer

  i3s as integer
  i3e as integer

  i4s as integer
  i4e as integer

  i5s as integer
  i5e as integer

  i6s as integer
  i6e as integer

  i7s as integer
  i7e as integer

  i8s as integer
  i8e as integer
end type


union array_index_union
  t as array_index_type
  u(1 to 16) as integer 
end union


type array_scan_type
  t as long                                           'data type
  p as any ptr                                        'data ptr
  c as long                                           'case flag
end type


type array_data_type
  p  as any ptr                                       'data ptr
  li as integer                                       'linear index
end type


'***********************************************************************************************


private function ax_data__(p as any ptr) as array_data_type
'***********************************************************************************************
' return data ptr (memory pointer)
'***********************************************************************************************
dim i as array_data_type


  i.p = p
  return i
   
   
end function   


private function ax_data() as array_data_type
'***********************************************************************************************
' return empty data ptr (dummy for no pointer or position given)
'***********************************************************************************************
dim i as array_data_type


  return i
   
   
end function   


private function ax_datapos(li as integer) as array_data_type
'***********************************************************************************************
' return data ptr (linear index)
'***********************************************************************************************
dim i as array_data_type


  i.li = li
  return i
   
   
end function   


'***********************************************************************************************


private function ax_indexpos(byval n as integer) as array_index
'***********************************************************************************************
' linear index given
'***********************************************************************************************
dim i as array_index


  i.n  = 0
  i.li = n
  return i
  
  
end function  


private function ax_index overload () as array_index
'***********************************************************************************************
' no index given
'***********************************************************************************************
dim i as array_index


  i.n = 0
  return i                                            'return "no index"
  
  
end function  


private function ax_index overload(ai as array_index) as array_index
'***********************************************************************************************
' array_index given
'***********************************************************************************************


  return ai
  
  
end function  


private function ax_index overload(byval i1 as integer) as array_index
'***********************************************************************************************
' one index given
'***********************************************************************************************
dim i as array_index


  i.n  = 1
  i.i1 = i1
  return i
  
  
end function  


private function ax_index overload(byval i1 as integer, _
                                          byval i2 as integer _
                                                              ) as array_index
'***********************************************************************************************
' 2 indices given
'***********************************************************************************************
dim i as array_index


  i.n  = 2
  i.i1 = i1
  i.i2 = i2
  return i
  
  
end function  


private function ax_index overload(byval i1 as integer, _
                                          byval i2 as integer, _
                                          byval i3 as integer _
                                                              ) as array_index
'***********************************************************************************************
' 3 indices given
'***********************************************************************************************
dim i as array_index


  i.n  = 3
  i.i1 = i1
  i.i2 = i2
  i.i3 = i3
  return i
  
  
end function  


private function ax_index overload(byval i1 as integer, _
                                          byval i2 as integer, _
                                          byval i3 as integer, _
                                          byval i4 as integer _
                                                              ) as array_index
'***********************************************************************************************
' 4 indices given
'***********************************************************************************************
dim i as array_index


  i.n  = 4
  i.i1 = i1
  i.i2 = i2
  i.i3 = i3
  i.i4 = i4
  return i
  
  
end function  


private function ax_index overload(byval i1 as integer, _
                                          byval i2 as integer, _
                                          byval i3 as integer, _
                                          byval i4 as integer, _
                                          byval i5 as integer _
                                                              ) as array_index
'***********************************************************************************************
' 5 indices given
'***********************************************************************************************
dim i as array_index


  i.n  = 5
  i.i1 = i1
  i.i2 = i2
  i.i3 = i3
  i.i4 = i4
  i.i5 = i5
  return i
  
  
end function  


private function ax_index overload(byval i1 as integer, _
                                          byval i2 as integer, _
                                          byval i3 as integer, _
                                          byval i4 as integer, _
                                          byval i5 as integer, _
                                          byval i6 as integer _
                                                              ) as array_index
'***********************************************************************************************
' 6 indices given
'***********************************************************************************************
dim i as array_index


  i.n  = 6
  i.i1 = i1
  i.i2 = i2
  i.i3 = i3
  i.i4 = i4
  i.i5 = i5
  i.i6 = i6
  return i
  
  
end function  


private function ax_index overload(byval i1 as integer, _
                                          byval i2 as integer, _
                                          byval i3 as integer, _
                                          byval i4 as integer, _
                                          byval i5 as integer, _
                                          byval i6 as integer, _
                                          byval i7 as integer _
                                                              ) as array_index
'***********************************************************************************************
' 7 indices given
'***********************************************************************************************
dim i as array_index


  i.n  = 7
  i.i1 = i1
  i.i2 = i2
  i.i3 = i3
  i.i4 = i4
  i.i5 = i5
  i.i6 = i6
  i.i7 = i7
  return i
  
  
end function  


private function ax_index overload(byval i1 as integer, _
                                          byval i2 as integer, _
                                          byval i3 as integer, _
                                          byval i4 as integer, _
                                          byval i5 as integer, _
                                          byval i6 as integer, _
                                          byval i7 as integer, _
                                          byval i8 as integer _
                                                              ) as array_index
'***********************************************************************************************
' 8 indices given
'***********************************************************************************************
dim i as array_index


  i.n  = 8
  i.i1 = i1
  i.i2 = i2
  i.i3 = i3
  i.i4 = i4
  i.i5 = i5
  i.i6 = i6
  i.i7 = i7
  i.i8 = i8
  return i
  
  
end function  


'***********************************************************************************************


private function ax_calc_pos__(byval p as any ptr, pptr as any ptr) as uinteger
'***********************************************************************************************
' calc linear (one based) position from index, do some out of bounds checking
'***********************************************************************************************


  function = fb_ArrayCalcPos(byval p, byval pptr)


end function


private function ax_calc_ptr__(byval p as any ptr, pptr as any ptr) as any ptr
'***********************************************************************************************
' return memory ptr from index, do some out of bounds checking
'***********************************************************************************************
dim i as uinteger


  i = fb_ArrayCalcPos(byval p, byval pptr)            'only for out of bounds check
  if i = 0 then
    return 0
  else
    return pptr
  end if  


end function


private function ax_calc_index__ overload(byval p as any ptr, byval li as integer) as array_index
'***********************************************************************************************
' calc indices from linear (one based) position
'***********************************************************************************************
dim i as array_index


  fb_ArrayCalcIdxPos(byval p, byval li, i)
  function = i


end function


private function ax_calc_index__ overload(byval p as any ptr, byval ppos as any ptr = 0) as array_index
'***********************************************************************************************
' calc indices from memory ptr
'***********************************************************************************************
dim i as array_index


  fb_ArrayCalcIdxPtr(byval p, byval ppos, i)
  function = i


end function


'***********************************************************************************************


private function ax_typeof__(t as string) as long 'integer
'***********************************************************************************************
' return variable type as number
'***********************************************************************************************


  if instr(t, " * ") then                             '(w/z)string * ...
    select case left(t, 9)
      case "ZSTRING *"
        return array_.ae_.adt_zstring                 '30
      case "STRING * "
        return array_.ae_.adt_fixstring               '31 
      case "WSTRING *"
        return array_.ae_.adt_wstring                 '33
      case else                                       'everything else
        return array_.ae_.adt_struct                  '40
    end select
    
  else  

    select case t
      case "BYTE"
        return array_.ae_.adt_byte                    '1
      case "UBYTE"
        return array_.ae_.adt_ubyte                   '2
      case "SHORT"
        return array_.ae_.adt_short                   '3
      case "USHORT"
        return array_.ae_.adt_ushort                  '4
      case "INTEGER"
        return array_.ae_.adt_integer                 '5
      case "UINTEGER"
        return array_.ae_.adt_uinteger                '6
      case "LONG"
        return array_.ae_.adt_long                    '7
      case "ULONG"
        return array_.ae_.adt_ulong                   '8
      case "LONGINT"
        return array_.ae_.adt_longint                 '9
      case "ULONGINT"
        return array_.ae_.adt_ulongint                '10

      case "SINGLE"
        return array_.ae_.adt_single                  '20
      case "DOUBLE"
        return array_.ae_.adt_double                  '21

      case "STRING"
        return array_.ae_.adt_string                  '32
      case typeof(USTRING) 
        return array_.ae_.adt_ustring                 '34

      case "ANY PTR"
        return array_.ae_.adt_function                '50

      case else                                    
        if left(t, 8) = "FUNCTION" then               '@proc
          return array_.ae_.adt_function              '50
        else
          return array_.ae_.adt_struct                '40 (everything else)
        end if
    end select
  end if  

end function


''***********************************************************************************************
'' sort callback sample      
''***********************************************************************************************
'
'
'private Function sort_wstring (byref a as wstring, byref b as wstring, byval flag as integer) as long
''***********************************************************************************************
'' sample custom WSTRING sort proc, flag > 0 -> sort up, flag <= 0 -> sort down
''***********************************************************************************************
'
'  if flag > 0 then
'    if a > b then
'        return 1
'    end if
'
'  else          
'    if a < b then
'        return 1
'    end if
'  end if
'
'  return 0
'
'end function
'
'
''***********************************************************************************************


private function ax_sort__ (byval t as long, byval ap as any ptr, byval sa as any ptr, byval cp as any ptr, _
                            ai as array_data_type, byval n as integer = 0) as long
'***********************************************************************************************
' array sort function: t = array data type, ap = array ptr, sa = sort along array ptr, 
'                      cp = callback procedure (if any), ai = array index to start sorting, 
'                      n = count of elements to sort
'***********************************************************************************************
dim u as ustring = "abc"
dim b as byte ptr
dim i as integer ptr
dim o as integer
dim x as long


  if t = array_.ae_.adt_ustring then                  'ustring array -> find data offset
    b = cast(byte ptr, @u)
    o = cast(integer, strptr(u))

    
    for x = 0 to sizeof(u) - sizeof(integer)          'scan udt for WSTRING address
      i = cast(integer ptr, b + x)

      if *i = o then
        o = x                                         'byte offset of wstring ptr from base ptr
        goto found
      end if
    next x

    err = 1                                           'set error
    exit function                                     'no offset found -> incompatible type
  end if


found:
  function = fb_ArraySort( byval ap, byval sa, byval t, byval cp, byval ai.p, byval ai.li, byval n, byval o)


end function


'***********************************************************************************************


private function ax_info__(byval p as any ptr) as uinteger
'***********************************************************************************************
' return array information (uinteger)
'***********************************************************************************************
dim i as uinteger

    
  i = cast(uinteger, p)
  return i


end function


private function ax_info__p(byval p as any ptr) as any ptr
'***********************************************************************************************
' return array information (ptr)
'***********************************************************************************************

    
  return p


end function


private function ax_info__b(byval p as any ptr) as boolean
'***********************************************************************************************
' return array information (boolean)
'***********************************************************************************************

  if p = 0 then
    return false
  else
    return true
  end if    


end function


'***********************************************************************************************


private sub ax_sub_redim overload(byval n as integer, u() as integer, byval i1 as integer, byval i2 as integer)
'***********************************************************************************************
' save dimension parameters: "x to y" (start + end)
'***********************************************************************************************

  u(n*2-1) = i1
  u(n*2)   = i2


end sub


private sub ax_sub_redim(byval n as integer, u() as integer, byval i2 as integer)
'***********************************************************************************************
' save dimension parameters: "y" (implicit start = 0, y)
'***********************************************************************************************

  u(n*2-1) = 0
  u(n*2)   = i2

end sub


'***********************************************************************************************


private function ax_attach__ (byval p as any ptr, u as array_.array_index_union, _
                              n as integer, mp as any ptr) as integer
'***********************************************************************************************
' array attach: p = array desc ptr, u = index data, n = # of dims, mp = memory location (ptr)
'***********************************************************************************************


  function = fb_ArrayAttach(byval p, u, n, byval mp)


end function


'***********************************************************************************************


private function ax_reset__ (byval p as any ptr) as integer
'***********************************************************************************************
' array reset, detach attached array
'***********************************************************************************************


  function = fb_ArrayReset(byval p)


end function


'***********************************************************************************************


function ax_insert__(byval p as any ptr, vname as string, ai as array_data_type, n as uinteger = 0) as any ptr
'***********************************************************************************************
' array insert:  p = array desc ptr, ai = array_index, n = # of elements to shift
'***********************************************************************************************


  function = fb_ArrayShift(byval p, byval ai.p, byval ai.li, byval n, 1)


end function


'***********************************************************************************************


function ax_delete__(byval p as any ptr, ai as array_data_type, n as uinteger = 0) as any ptr
'***********************************************************************************************
' array delete:  p = array desc ptr, ai = array_index, n = # of elements to shift
'***********************************************************************************************


  function = fb_ArrayShift(byval p, byval ai.p, byval ai.li, byval n, 0)


end function


'***********************************************************************************************


private function ax_for__ overload (byref b as byte, byval cflag as integer) as array_scan_type
'***********************************************************************************************
' scan for byte
'***********************************************************************************************
dim ast as array_scan_type


  ast.t = array_.ae_.adt_byte
  ast.p = @b
  ast.c = cflag

  function = ast


end function


private function ax_for__ (byref b as ubyte, byval cflag as integer) as array_scan_type
'***********************************************************************************************
' scan for ubyte
'***********************************************************************************************
dim ast as array_scan_type


  ast.t = array_.ae_.adt_ubyte
  ast.p = @b
  ast.c = cflag

  function = ast


end function


private function ax_for__ (byref b as short, byval cflag as integer) as array_scan_type
'***********************************************************************************************
' scan for short
'***********************************************************************************************
dim ast as array_scan_type


  ast.t = array_.ae_.adt_short
  ast.p = @b
  ast.c = cflag

  function = ast


end function


private function ax_for__ (byref b as ushort, byval cflag as integer) as array_scan_type
'***********************************************************************************************
' scan for ushort
'***********************************************************************************************
dim ast as array_scan_type


  ast.t = array_.ae_.adt_ushort
  ast.p = @b
  ast.c = cflag

  function = ast


end function


private function ax_for__ (byref b as integer, byval cflag as integer) as array_scan_type
'***********************************************************************************************
' scan for integer
'***********************************************************************************************
dim ast as array_scan_type


  ast.t = array_.ae_.adt_integer
  ast.p = @b
  ast.c = cflag

  function = ast


end function


private function ax_for__ (byref b as uinteger, byval cflag as integer) as array_scan_type
'***********************************************************************************************
' scan for uinteger
'***********************************************************************************************
dim ast as array_scan_type


  ast.t = array_.ae_.adt_uinteger
  ast.p = @b
  ast.c = cflag

  function = ast


end function


private function ax_for__ (byref b as long, byval cflag as integer) as array_scan_type
'***********************************************************************************************
' scan for long
'***********************************************************************************************
dim ast as array_scan_type


  ast.t = array_.ae_.adt_long
  ast.p = @b
  ast.c = cflag

  function = ast


end function


private function ax_for__ (byref b as ulong, byval cflag as integer) as array_scan_type
'***********************************************************************************************
' scan for ulong
'***********************************************************************************************
dim ast as array_scan_type


  ast.t = array_.ae_.adt_ulong
  ast.p = @b
  ast.c = cflag

  function = ast


end function


private function ax_for__ (byref b as longint, byval cflag as integer) as array_scan_type
'***********************************************************************************************
' scan for longint
'***********************************************************************************************
dim ast as array_scan_type


  ast.t = array_.ae_.adt_longint
  ast.p = @b
  ast.c = cflag

  function = ast


end function


private function ax_for__ (byref b as ulongint, byval cflag as integer) as array_scan_type
'***********************************************************************************************
' scan for ulongint
'***********************************************************************************************
dim ast as array_scan_type


  ast.t = array_.ae_.adt_ulongint
  ast.p = @b
  ast.c = cflag

  function = ast


end function


private function ax_for__ (byref b as single, byval cflag as integer) as array_scan_type
'***********************************************************************************************
' scan for single
'***********************************************************************************************
dim ast as array_scan_type


  ast.t = array_.ae_.adt_single
  ast.p = @b
  ast.c = cflag

  function = ast


end function


private function ax_for__ (byref b as double, byval cflag as integer) as array_scan_type
'***********************************************************************************************
' scan for double
'***********************************************************************************************
dim ast as array_scan_type


  ast.t = array_.ae_.adt_double
  ast.p = @b
  ast.c = cflag

  function = ast


end function


private function ax_for__ (byval b as zstring ptr, byval cflag as integer) as array_scan_type
'***********************************************************************************************
' scan for string * / zstring / string
'***********************************************************************************************
dim ast as array_scan_type


  ast.t = array_.ae_.adt_zstring
  ast.p = b
  ast.c = cflag

  function = ast


end function


private function ax_for__ (byval b as wstring ptr, byval cflag as integer) as array_scan_type
'***********************************************************************************************
' scan for wstring
'***********************************************************************************************
dim ast as array_scan_type


  ast.t = array_.ae_.adt_wstring
  ast.p = b
  ast.c = cflag

  function = ast


end function


private function ax_for__ (byref b as ustring, byval cflag as integer) as array_scan_type
'***********************************************************************************************
' scan for ustring
'***********************************************************************************************
dim ast as array_scan_type


  ast.t = array_.ae_.adt_wstring
  ast.p = strptr(b)
  ast.c = cflag

  function = ast


end function


private function ax_for__ (b as any ptr, byval cflag as integer) as array_scan_type
'***********************************************************************************************
' nocase 
'***********************************************************************************************
dim ast as array_scan_type


  ast.t = array_.ae_.adt_function
  ast.p = b
  ast.c = cflag

  function = ast


end function


'***********************************************************************************************
' sample custom scan function
'***********************************************************************************************


'private Function ustring_instr (byref u as ustring) as long
''***********************************************************************************************
'' sample compare user callback: parameter byref, return long
'' return a match for the first array element, which has "asdf" as substring
''***********************************************************************************************
'
'
'  if instr(u, "asdf") then return 1
'  return 0
'
'
'end function


'***********************************************************************************************


private function ax_scan__(byval t as integer, byval p as any ptr, ast as array_.array_scan_type, _
                               ai as array_index, byval n as integer = 0) as integer
'***********************************************************************************************
' array scan: t = data type of array, p = array descriptor, ast = scan for, ai = array_index, 
'             n = # of elements to scan  ->  return linear index (one based integer)
'
' we allow for "similar" data types to be compared. That is, all string types may be mixed
' just as all numeric types (byte to ulongint) and floating point types (single and double)
' Mixing string types with numeric of floating point types and numeric types with floating 
' point types doesn´t make sense and therefore is rejected (err = 1).
'***********************************************************************************************
dim cbp  as any ptr                                   'user callback
dim flag as long = 0                                  'flag for deciding what to compare with what (RTL)
dim s    as string
dim u    as ustring
dim o    as integer
dim u2   as ustring = "abc"
dim b    as byte ptr
dim i    as integer ptr
dim x    as long


  err = 0                                             'reset error


  if ast.t = array_.ae_.adt_function then             '50 = callback function
    cbp = ast.p
    flag = 1                                          'callback function
    function = fb_ArrayScan(byval p, byval cbp, byval ast.p, ast.c, ai, flag, n, o)
    exit function
  end if  


  select case t                                       
    case array_.ae_.adt_byte to array_.ae_.adt_ulongint                   '1 to 10 = numbers
      if ast.t > array_.ae_.adt_ulongint then
        err = 1
        return 0
      end if

      flag = 10 * t + ast.t - 1                       '10 to 110  -> combine different types

      
    case array_.ae_.adt_single                        '20 = single
      if (ast.t < array_.ae_.adt_single) and (ast.t > array_.ae_.adt_double) then
        err = 1
        return 0
      end if

      if ast.t = array_.ae_.adt_single then
        flag = 6                                      'single/single
      else
        flag = 7                                      'single/double
      end if    

    case array_.ae_.adt_double                        '21 = double
      if (ast.t < array_.ae_.adt_single) and (ast.t > array_.ae_.adt_double) then
        err = 1
        return 0
      end if

      if ast.t = array_.ae_.adt_single then
        flag = 8                                      'double/single
      else
        flag = 9                                      'double/double
      end if    

      
    case is < array_.ae_.adt_struct                   'strings
      if (ast.t < array_.ae_.adt_struct) and ((ast.t > array_.ae_.adt_ustring)  or (ast.t < array_.ae_.adt_zstring)) then
        err = 1
        return 0
      end if

      if (t = array_.ae_.adt_zstring) or (t = array_.ae_.adt_fixstring) then 'zstring or string *
        flag = 2                                      'zstring
        goto sstring
        
      elseif t = array_.ae_.adt_string then
        flag = 3                                      'string

sstring:
        select case ast.t                             'convert search term to string
          case array_.ae_.adt_zstring, array_.ae_.adt_fixstring
            s = *cast(zstring ptr, ast.p)

          case array_.ae_.adt_string
            s = *cast(string ptr, ast.p)

          case array_.ae_.adt_wstring, array_.ae_.adt_ustring
            s = *cast(wstring ptr, ast.p)
        end select

        if ast.c <> 0 then
          s = lcase(s)                                'convert to lcase, if "nocase" was given
        end if  

        ast.p = strptr(s)                             'make it a zstring ptr


      elseif t = array_.ae_.adt_wstring then          'wstring
        flag = 4                                      'wstring
        goto usstring


      elseif t = array_.ae_.adt_ustring then          'ustring
        err = 0                                       'reset error

        if t = array_.ae_.adt_ustring then            'ustring array -> find data offset
          b = cast(byte ptr, @u2)
          o = cast(integer, strptr(u2))

          
          for x = 0 to sizeof(u2) - sizeof(integer)   'scan udt for WSTRING address
            i = cast(integer ptr, b + x)

            if *i = o then
              o = x
              goto found
            end if
          next x

          err = 1                                     'set error
          exit function                               'no offset found -> incompatible type
        end if

found:

        flag = 5                                      'ustring
usstring:        
        select case ast.t                             'convert search term to string
          case array_.ae_.adt_zstring, array_.ae_.adt_fixstring
            u = *cast(zstring ptr, ast.p)

          case array_.ae_.adt_string
            u = *cast(string ptr, ast.p)

          case array_.ae_.adt_wstring, array_.ae_.adt_ustring
            u = *cast(wstring ptr, ast.p)
        end select

        if ast.c <> 0 then
          u = lcase(u)                                'convert to lcase, if "nocase" was given
        end if  

        ast.p = strptr(u)                             'make it a wstring ptr
      end if

      
    case array_.ae_.adt_struct                        '40 = struct
      if ast.t = array_.ae_.adt_function then         '50 = callback function
        cbp = ast.p
        flag = 1                                      'callback function
      else
        err = 1
        return 0
      end if  

    case else
      err = 1
      return 0
    
  end select


  function = fb_ArrayScan(byval p, byval cbp, byval ast.p, ast.c, ai, flag, n, o)


end function


'***********************************************************************************************
' future extension: more functions ...
'***********************************************************************************************


end namespace


'***********************************************************************************************
' array macros (start with "array_")
'***********************************************************************************************


#macro array_redim1__(p1...)
#redef to ,                                           'redefine "TO" (temporarily) to be replaced by a comma

  array_.ax_sub_redim(1, ax_u.u(), p1)

#undef to                                             'restore "TO" to it´s orginal state
#endmacro
'***********************************************************************************************
#macro array_redim2__(p1, p2...)
#redef to ,

  array_.ax_sub_redim(1, ax_u.u(), p1)
  array_.ax_sub_redim(2, ax_u.u(), p2)

#undef to
#endmacro
'***********************************************************************************************
#macro array_redim3__(p1, p2, p3...)
#redef to ,

  array_.ax_sub_redim(1, ax_u.u(), p1)
  array_.ax_sub_redim(2, ax_u.u(), p2)
  array_.ax_sub_redim(3, ax_u.u(), p3)

#undef to
#endmacro
'***********************************************************************************************
#macro array_redim4__(p1, p2, p3, p4...)
#redef to ,

  array_.ax_sub_redim(1, ax_u.u(), p1)
  array_.ax_sub_redim(2, ax_u.u(), p2)
  array_.ax_sub_redim(3, ax_u.u(), p3)
  array_.ax_sub_redim(4, ax_u.u(), p4)

#undef to
#endmacro
'***********************************************************************************************
#macro array_redim5__(p1, p2, p3, p4, p5...)
#redef to ,

  array_.ax_sub_redim(1, ax_u.u(), p1)
  array_.ax_sub_redim(2, ax_u.u(), p2)
  array_.ax_sub_redim(3, ax_u.u(), p3)
  array_.ax_sub_redim(4, ax_u.u(), p4)
  array_.ax_sub_redim(5, ax_u.u(), p5)

#undef to
#endmacro
'***********************************************************************************************
#macro array_redim6__(p1, p2, p3, p4, p5, p6...)
#redef to ,

  array_.ax_sub_redim(1, ax_u.u(), p1)
  array_.ax_sub_redim(2, ax_u.u(), p2)
  array_.ax_sub_redim(3, ax_u.u(), p3)
  array_.ax_sub_redim(4, ax_u.u(), p4)
  array_.ax_sub_redim(5, ax_u.u(), p5)
  array_.ax_sub_redim(6, ax_u.u(), p6)

#undef to
#endmacro
'***********************************************************************************************
#macro array_redim7__(p1, p2, p3, p4, p5, p6, p7...)
#redef to ,

  array_.ax_sub_redim(1, ax_u.u(), p1)
  array_.ax_sub_redim(2, ax_u.u(), p2)
  array_.ax_sub_redim(3, ax_u.u(), p3)
  array_.ax_sub_redim(4, ax_u.u(), p4)
  array_.ax_sub_redim(5, ax_u.u(), p5)
  array_.ax_sub_redim(6, ax_u.u(), p6)
  array_.ax_sub_redim(7, ax_u.u(), p7)

#undef to
#endmacro
'***********************************************************************************************
#macro array_redim8__(p1, p2, p3, p4, p5, p6, p7, p8...)
#redef to ,

  array_.ax_sub_redim(1, ax_u.u(), p1)
  array_.ax_sub_redim(2, ax_u.u(), p2)
  array_.ax_sub_redim(3, ax_u.u(), p3)
  array_.ax_sub_redim(4, ax_u.u(), p4)
  array_.ax_sub_redim(5, ax_u.u(), p5)
  array_.ax_sub_redim(6, ax_u.u(), p6)
  array_.ax_sub_redim(7, ax_u.u(), p7)
  array_.ax_sub_redim(8, ax_u.u(), p8)

#undef to
#endmacro


#macro array_redim(i...)
'***********************************************************************************************
' parse dimensions (array(attach, array, redim(...))
'***********************************************************************************************
scope

#if ((#i = "") or (#%i > 8))
  #line __prevline__
  #error "(macro expansion) array attach: wrong number of dimensions: "##i
#elseif (#%i = 1)
  array_redim1__(i)
#elseif (#%i = 2)
  array_redim2__(i)
#elseif (#%i = 3)
  array_redim3__(i)
#elseif (#%i = 4)
  array_redim4__(i)
#elseif (#%i = 5)
  array_redim5__(i)
#elseif (#%i = 6)
  array_redim6__(i)
#elseif (#%i = 7)
  array_redim7__(i)
#elseif (#%i = 8)
  array_redim8__(i)
#endif

  ax_n = #%i

end scope
#endmacro


#macro ax_get_typeof__ (array)
  #if TypeOf((array))     = BYTE
    #define ax_typedef__ array_.ae_.adt_byte          '1 (array´s data type)
  #elseif TypeOf((array)) = UBYTE
    #define ax_typedef__ array_.ae_.adt_ubyte         '2
  #else
    #if TypeOf((array)) = SHORT
      #define ax_typedef__ array_.ae_.adt_short       '3
    #elseif TypeOf((array)) = USHORT
      #define ax_typedef__ array_.ae_.adt_ushort      '4
    #elseif TypeOf((array)) = INTEGER
      #define ax_typedef__ array_.ae_.adt_integer     '5
    #elseif TypeOf((array)) = UINTEGER
      #define ax_typedef__ array_.ae_.adt_uinteger    '6
    #elseif TypeOf((array)) = LONG
      #define ax_typedef__ array_.ae_.adt_long        '7
    #elseif TypeOf((array)) = ULONG
      #define ax_typedef__ array_.ae_.adt_ulong       '8
    #elseif TypeOf((array)) = LONGINT
      #define ax_typedef__ array_.ae_.adt_longint     '9
    #elseif TypeOf((array)) = ULONGINT
      #define ax_typedef__ array_.ae_.adt_ulongint    '10

    #elseif TypeOf((array)) = SINGLE
      #define ax_typedef__ array_.ae_.adt_single      '20
    #elseif TypeOf((array)) = DOUBLE
      #define ax_typedef__ array_.ae_.adt_double      '21

    #elseif typeof((array)) = typeof(zstring * sizeof(typeof((array))))
      #define ax_typedef__ array_.ae_.adt_zstring     '30
    #elseif TypeOf((array)) = typeof(string * (sizeof(typeof((array))) - 1))
      #define ax_typedef__ array_.ae_.adt_fixstring   '31
    #elseif TypeOf((array)) = STRING
      #define ax_typedef__ array_.ae_.adt_string      '32
    #elseif typeof((array)) = typeof(Wstring * (sizeof(typeof((array))) / 2))
      #define ax_typedef__ array_.ae_.adt_wstring     '33
    #elseif TypeOf((array)) = Typeof(USTRING)
      #define ax_typedef__ array_.ae_.adt_ustring     '34

    #else
      #define ax_typedef__ array_.ae_.adt_struct      '40
    #endif
  #endif
#endmacro


#macro ax_sort_along_with__(array1, array2, p3...)    'resolve two input arrays + case specifier
  ax_get_typeof__ (array1)

  #if (#p3 = "")                                      'no paramter 3
    #if (###array2 = "NOCASE")                        'string array + nocase
      #if  (ax_typedef__ >= array_.ae_.adt_zstring) and (ax_typedef__ < array_.ae_.adt_struct)
        dim ax_ptr1 as any ptr = fb_ArrayDesc(array1(), array_.ae_.desc)
        dim ax_ptr2 as any ptr = 0
        dim ax_type as integer = array_.ax_typeof__(typeof((array1)))
        dim ax_case as long = 1
      #else
        #line __prevline__
        #error "(macro expansion) array sort: "##only arrays of strings may be sorted case-insensitive: ##array1##()
      #endif
      
    #else
      #if (#array1 = #array2)
        #line __prevline__
        #error "(macro expansion) array sort: "##arrays must be different: ##array1##() ##array2##()
      #endif
      dim ax_ptr1 as any ptr = fb_ArrayDesc(array1(), array_.ae_.desc)
      dim ax_ptr2 as any ptr = fb_ArrayDesc(array2(), array_.ae_.desc)
      dim ax_type as integer = array_.ax_typeof__(typeof((array1)))
      dim ax_case as long = 0
    #endif

  #else                                               'there is a third parameter
    #if (###p3 = "NOCASE")                              'string array + nocase
      #if  (ax_typedef__ >= array_.ae_.adt_zstring) and (ax_typedef__ < array_.ae_.adt_struct)
        #if (#array1 = #array2)
          #line __prevline__
          #error "(macro expansion) array sort: "##arrays must be different: ##array1##() ##array2##()
        #endif
        dim ax_ptr1 as any ptr = fb_ArrayDesc(array1(), array_.ae_.desc)
        dim ax_ptr2 as any ptr = fb_ArrayDesc(array2(), array_.ae_.desc)
        dim ax_type as integer = array_.ax_typeof__(typeof((array1)))
        dim ax_case as long = 1
      #else
        #line __prevline__
        #error "(macro expansion) array sort: "##only arrays of strings may be sorted case-insensitive: ##array1##()
      #endif

    #else                                             'improper third param
      #line __prevline__
      #error "(macro expansion) array sort: improper case specifier: "##p3
    #endif
  #endif
#endmacro


#macro array_first_param(p1, p2...)
  p1
#endmacro


#macro array_sort__(array, p1, p2, p3...)             '"sort" macro
scope

  #if (#array < ")") and (#array > "'")               'starts with "(" -> sort along or nocase
    ax_sort_along_with__ array
  #else
    dim ax_ptr1 as any ptr = fb_ArrayDesc(array(), array_.ae_.desc)
    dim ax_ptr2 as any ptr = 0
    dim ax_type as integer = array_.ax_typeof__(typeof((array)))
    dim ax_case as long = 0

    ax_get_typeof__ (array)
  #endif

  #if ((###p1 = "UP") or (###p1 = "DOWN"))
    #if (ax_typedef__ = array_.ae_.adt_struct)
      #line __prevline__
      #error "(macro expansion) array sort: "##please use a custom sort function for non-standard types: ##array##()

    #elseif (###p1 = "UP")
      #if (#p2 < ")") and (#p2 > "'")
        #if (#array < ")") and (#array > "'")         'starts with "(" -> sort along or nocase
          array_.ax_sort__(ax_type, ax_ptr1, ax_ptr2, cast(any ptr, 1 + ax_case), array_.ax_data__(@array_first_param##array##p2), p3)
        #else
          array_.ax_sort__(ax_type, ax_ptr1, ax_ptr2, cast(any ptr, 1 + ax_case), array_.ax_data__(@array##p2), p3)
        #endif
      #else
        array_.ax_sort__(ax_type, ax_ptr1, ax_ptr2, cast(any ptr, 1 + ax_case), array_.ax_data##p2, p3)
      #endif

    #elseif (###p1 = "DOWN")
      #if (#p2 < ")") and (#p2 > "'")
        #if (#array < ")") and (#array > "'")         'starts with "(" -> sort along or nocase
          array_.ax_sort__(ax_type, ax_ptr1, ax_ptr2, cast(any ptr, -3 + ax_case), array_.ax_data__(@array_first_param##array##p2), p3)
        #else
          array_.ax_sort__(ax_type, ax_ptr1, ax_ptr2, cast(any ptr, -3 + ax_case), array_.ax_data__(@array##p2), p3)
        #endif
      #else
        array_.ax_sort__(ax_type, ax_ptr1, ax_ptr2, cast(any ptr, -3 + ax_case), array_.ax_data##p2, p3)
      #endif
    #endif 

  #elseif (#p1 = "")                                  'no up/down/@customproc
    #if (ax_typedef__ = array_.ae_.adt_struct)
      #line __prevline__
      #error "(macro expansion) array sort: "##please use a custom sort function for non-standard types: ##array##()
    #else
      array_.ax_sort__(ax_type, ax_ptr1, ax_ptr2, cast(any ptr, 1 + ax_case), array_.ax_data##p2, p3)
    #endif 

  #else                                               '@customsort

    #if (#p2 < ")") and (#p2 > "'")
      array_.ax_sort__(ax_type, ax_ptr1, ax_ptr2, p1, array_.ax_data__(@array##p2), p3)
    #else
      array_.ax_sort__(ax_type, ax_ptr1, ax_ptr2, p1, array_.ax_data##p2, p3)
    #endif
  #endif

end scope
#endmacro


#macro array_data__(array, p1...)                    
  array_.ax_info__p(fb_ArrayDesc(array(), array_.ae_.data))               'data_ptr
#endmacro

#macro array_dimensions__(array, p1...)                 
  array_.ax_info__(fb_ArrayDesc(array(), array_.ae_.dimensions))          'dimensions
#endmacro

#macro array_total_size__(array, p1...)                
  array_.ax_info__(fb_ArrayDesc(array(), array_.ae_.total_size))          'total_size
#endmacro

#macro array_total_count__(array, p1...)                
  array_.ax_info__(fb_ArrayDesc(array(), array_.ae_.total_count))         'total_count
#endmacro

#macro array_sizeof__(array, p1...)                   
  array_.ax_info__(fb_ArrayDesc(array(), array_.ae_.size))                'size
#endmacro

#macro array_is_fixed_len__(array, p1...)                   
  array_.ax_info__b(fb_ArrayDesc(array(), array_.ae_.is_fixed_len))       'fixed len
#endmacro

#macro array_is_fixed_dim__(array, p1...)                   
  array_.ax_info__b(fb_ArrayDesc(array(), array_.ae_.is_fixed_dim))       'fixed dim
#endmacro

#macro array_is_dynamic__(array, p1...)                  
  array_.ax_info__b(fb_ArrayDesc(array(), array_.ae_.is_dynamic))          'dynamic
#endmacro

#macro array_is_attached__(array, p1...)                
  array_.ax_info__b(fb_ArrayDesc(array(), array_.ae_.is_attached))        'attached
#endmacro


#macro array_attach__(array, p1, p2...)               '"attach" macro
  #if ((###p1 < "REDIM)") and (###p1 > "REDIM'"))     'starts with "Redim("
    #if (#p2 <> "")
      scope
        dim ax_u as array_.array_index_union
        dim ax_n as integer
        array_##p1
        array_.ax_attach__(fb_ArrayDesc(array(), array_.ae_.desc), ax_u, ax_n, p2)
      end scope
    #else
      #line __prevline__
      #error "(macro expansion) array attach: missing parameter 4 (memory location)"
    #endif
  #else
    #line __prevline__
    #error "(macro expansion) array attach: invalid parameter 3: "##p1
  #endif
#endmacro


#macro array_reset__(array, p1, p2...)                '"reset" macro
  #if (#p1 <> "")
    #line __prevline__
    #error "(macro expansion) array reset: too much parameters: "##p2
  #else
    array_.ax_reset__(fb_ArrayDesc(array(), array_.ae_.desc))
  #endif
#endmacro


#macro array_insert__(array, p1, p2, p3...)           '"insert" macro
  #if (#p1 = "")
    #line __prevline__
    #error "(macro expansion) array insert: missing parameter 3: value to insert"
  #else
    scope
    #if (#p2 < ")") and (#p2 > "'")                   'starts with "("
      dim p as any ptr = array_.ax_insert__(fb_ArrayDesc(array(), array_.ae_.desc), #p1, array_.ax_data__(@array##p2), p3)
    #else
      dim p as any ptr = array_.ax_insert__(fb_ArrayDesc(array(), array_.ae_.desc), #p1, array_.ax_data##p2, p3)
    #endif

      if p > 0 then
        *cast(typeof((array)) ptr, p) = p1            'assign new element, delete existing
      end if
    end scope
  #endif
#endmacro


#macro array_delete__(array, p1, p2...)               '"delete" macro
  #if (#%p2 > 1)
    #line __prevline__
    #error "(macro expansion) array delete: too much parameters: "##p2
  #else
    scope
    #if (#p1 < ")") and (#p1 > "'")
      dim p as any ptr = array_.ax_delete__(fb_ArrayDesc(array(), array_.ae_.desc), array_.ax_data__(@array##p1), p2)
    #else
      dim p as any ptr = array_.ax_delete__(fb_ArrayDesc(array(), array_.ae_.desc), array_.ax_data##p1, p2)
    #endif

      if p > 0 then
        dim xyz as typeof((array))
        *cast(typeof((array)) ptr, p) = xyz           'default (constructor) for the "deleted" element
      end if
    end scope
  #endif
#endmacro


#macro array_pos__(array, p2, p3...)                  'calculate linear position from index
  array_.ax_calc_pos__(fb_ArrayDesc(array(), array_.ae_.desc), @##array##p2)
#endmacro                                             'errors never go through -> added no error checking

#macro array_ptr__(array, p2, p3...)                       'calculate data ptr from index
  array_.ax_calc_ptr__(fb_ArrayDesc(array(), array_.ae_.desc), @array##p2)
#endmacro                                             'errors never go through -> added no error checking

#macro array_index__(array, p2...)                    'calculate index from linear position
  array_.ax_calc_index__(fb_ArrayDesc(array(), array_.ae_.desc), p2)
#endmacro


#macro array_for(p1, p2, p3...)                       '"for" macro (scan)
  array_.ax_for__(p1, array_.ae_.nocaseflag##p2)
#endmacro

#macro array_scan__(array, p1, p2, p3...)             '"scan" macro
  array_.ax_scan__(array_.ax_typeof__(typeof((array))), fb_ArrayDesc(array(), array_.ae_.desc), array_##p1, array_.ax_index##p2, p3)
#endmacro


#macro array(verb, array, p1, p2...)                  'generic "array" processing macro
  array_##verb##__(array, p1, p2)
#endmacro


'***********************************************************************************************
'***********************************************************************************************
'***********************************************************************************************

