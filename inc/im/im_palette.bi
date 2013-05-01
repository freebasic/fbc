''
''
'' im_palette -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_palette_bi__
#define __im_palette_bi__

declare function imPaletteFindNearest cdecl alias "imPaletteFindNearest" (byval palette as integer ptr, byval palette_count as integer, byval color as integer) as integer
declare function imPaletteFindColor cdecl alias "imPaletteFindColor" (byval palette as integer ptr, byval palette_count as integer, byval color as integer, byval tol as ubyte) as integer
declare function imPaletteGray cdecl alias "imPaletteGray" () as integer ptr
declare function imPaletteRed cdecl alias "imPaletteRed" () as integer ptr
declare function imPaletteGreen cdecl alias "imPaletteGreen" () as integer ptr
declare function imPaletteBlue cdecl alias "imPaletteBlue" () as integer ptr
declare function imPaletteYellow cdecl alias "imPaletteYellow" () as integer ptr
declare function imPaletteMagenta cdecl alias "imPaletteMagenta" () as integer ptr
declare function imPaletteCian cdecl alias "imPaletteCian" () as integer ptr
declare function imPaletteRainbow cdecl alias "imPaletteRainbow" () as integer ptr
declare function imPaletteHues cdecl alias "imPaletteHues" () as integer ptr
declare function imPaletteBlueIce cdecl alias "imPaletteBlueIce" () as integer ptr
declare function imPaletteHotIron cdecl alias "imPaletteHotIron" () as integer ptr
declare function imPaletteBlackBody cdecl alias "imPaletteBlackBody" () as integer ptr
declare function imPaletteHighContrast cdecl alias "imPaletteHighContrast" () as integer ptr
declare function imPaletteUniform cdecl alias "imPaletteUniform" () as integer ptr
declare function imPaletteUniformIndex cdecl alias "imPaletteUniformIndex" (byval color as integer) as integer
declare function imPaletteUniformIndexHalftoned cdecl alias "imPaletteUniformIndexHalftoned" (byval color as integer, byval x as integer, byval y as integer) as integer

#endif
