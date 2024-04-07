'' examples/manual/gfx/put-all.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'PUT (GRAPHICS)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPutgraphics
'' --------

Declare Function checkered_blend( ByVal src As ULong, ByVal dest As ULong, ByVal param As Any Ptr ) As ULong

   Screen 14, 32                                   '' set 320*240*32 gfx mode
   
   Dim As Any Ptr sprite
   Dim As Integer counter = 0
   
   sprite = ImageCreate( 32, 32 )                  '' allocate memory for 32x32 sprite
   
   Line sprite, ( 0, 0 )-( 31, 31 ), RGBA(255, 0, 0, 64), bf  '' draw a sprite ...
   Line sprite, ( 4, 4 )-( 27, 27 ), RGBA(255, 0, 0, 192), bf
   Line sprite, ( 0, 0 )-( 31, 31 ), RGB(0, 255, 0), b
   Line sprite, ( 8, 8 )-( 23, 23 ), RGBA(255, 0, 255, 64), bf
   Line sprite, ( 1, 1 )-( 30, 30 ), RGBA(0, 0, 255, 192)
   Line sprite, ( 30, 1 )-( 1, 30 ), RGBA(0, 0, 255, 192)
   
   Cls
   Dim As Integer i : For i = 0 To 63              '' draw the background
	  Line( i,0 )-( i,240 ), RGB( i * 4, i * 4, i * 4 )
   Next i
   
   '' demonstrate all drawing methods ...
   Put( 8,14 ), sprite, PSet
   Put Step( 16,20 ), sprite, PReset
   Put Step( -16,20 ), sprite, And
   Put Step( 16,20 ), sprite, Or
   Put Step( -16,20 ), sprite, Xor
   Put Step( 16,20 ), sprite, Trans
   Put Step( -16,20 ), sprite, Alpha, 96
   Put Step( 16,20 ), sprite, Alpha
   Put Step( -16,20 ), sprite, Add, 192
   Put Step( 16,20 ), sprite, Custom, @checkered_blend, @counter
   
   '' print a description near each demo
   Draw String (100, 26), "<- pset"
   Draw String Step (0, 20), "<- preset"
   Draw String Step (0, 20), "<- and"
   Draw String Step (0, 20), "<- or"
   Draw String Step (0, 20), "<- xor"
   Draw String Step (0, 20), "<- trans"
   Draw String Step (0, 20), "<- alpha (uniform)"
   Draw String Step (0, 20), "<- alpha (per pixel)"
   Draw String Step (0, 20), "<- add"
   Draw String Step (0, 20), "<- custom"
   
   ImageDestroy( sprite )                          '' free allocated memory for sprite
   Sleep : End 0

'' custom blender function: chequered put
Function checkered_blend( ByVal src As ULong, ByVal dest As ULong, ByVal param As Any Ptr ) As ULong
   Dim As Integer Ptr counter
   Dim As ULong pixel
   
   counter = Cast(Integer Ptr, param)
   pixel = IIf(((*counter And 4) Shr 2) Xor ((*counter And 128) Shr 7), src, dest)
   *counter += 1
   Return pixel
End Function
