' OpenAL                                                            15/02/2005
' ----------------------------------------------------------------------------
' Header port to FreeBASIC by Chris Davies [shiftLynx].
'
' c.g.davies@gmail.com
' http://www.cdsoft.co.uk/
'
'

#ifndef ALUT_BI
#define ALUT_BI


'$INCLUDE: 'al/al.bi'
'$INCLUDE: 'al/alu.bi'
#ifndef FB__LINUX
'$INCLIB: 'ALut'
#endif

declare sub alutInit cdecl ALIAS "alutInit" (byval argc as ALint ptr, byval argv as ALbyte ptr ptr)
declare sub alutExit cdecl ALIAS "alutExit" ()
declare sub alutLoadWAVFile cdecl alias "alutLoadWAVFile" (byVAL file as string, byval format as ALenum ptr, byval dat as any ptr ptr, byval size as ALsizei ptr, byval freq as ALsizei ptr, byval wavloop as ALboolean ptr)
declare sub alutLoadWAVMemory cdecl alias "alutLoadWAVMemory" (byval memory as ALbyte ptr, byval format as ALenum ptr, byval dat as any ptr ptr, byval size as ALsizei ptr, byval freq as ALsizei ptr, byval wavloop as ALboolean ptr)
declare sub alutUnloadWAV cdecl alias "alutUnloadWAV" (byval format as ALenum, byval dat as any ptr, byval size as ALsizei, byval freq as ALsizei)


#endif      ' ndef ALUT_BI
