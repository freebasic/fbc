#ifndef __BUFER_BI__
#define __BUFER_BI__

#ifndef NULL
#define NULL 0
#endif

type string_item

  _value as string
  _nxt as string_item ptr

  declare constructor()
  declare constructor( byref x as string )
  declare constructor( byref x as string, byval nxt as string_item ptr )
  declare destructor()

end type

type buffer

  _head as string_item ptr
  _count as integer

  declare constructor()
  declare sub clear()
  declare function gettext( byref eol as string ) as string
  declare property text( byref x as string )
  declare property text() as string
  declare property text_lf() as string
  declare property text_crlf() as string
  declare property count() as integer
  declare function insert( byval index as integer, byref x as string ) as integer
  declare sub remove( byval index as integer )
  declare function append( byref x as string ) as integer
  declare property item( byval index as integer, byref x as string )
  declare property item( byval index as integer ) as string

  declare sub dump( byval h as integer = 0 )

private:
  declare function getitem( byval index as integer ) as string_item ptr

end type

#endif
