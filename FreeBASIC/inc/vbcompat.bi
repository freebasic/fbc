#ifndef __VBCOMPAT_BI__
#define __VBCOMPAT_BI__

''
const vbFalse = 0
const vbTrue = not vbFalse

'' DATE/TIME
#include once "datetime.bi"

#ifndef vbUseSystem
const vbUseSystem       = fbUseSystem
#endif

const vbFirstJan1       = fbFirstJan1
const vbFirstFourDays   = fbFirstFourDays
const vbFirstFullWeek	= fbFirstFullWeek

const vbSunday          = fbSunday
const vbMonday          = fbMonday
const vbTuesday         = fbTuesday
const vbWednesday       = fbWednesday
const vbThursday        = fbThursday
const vbFriday          = fbFriday
const vbSaturday        = fbSaturday

'' STRING
#include once "string.bi"

'' DIR
#include once "dir.bi"

const vbReadOnly		= fbReadOnly
const vbHidden			= fbHidden
const vbSystem			= fbSystem
const vbDirectory		= fbDirectory
const vbArchive			= fbArchive
const vbNormal			= fbNormal

'' CHAR
const vbBack			= chr( 08 )
const vbCr				= chr( 13 )
const vbCrLf			= chr( 13, 10 )
const vbLf				= chr( 10 )
#if defined(__FB_DOS__) or defined(__FB_WIN32__)
const vbNewLine			= vbCrLf
#else
const vbNewLine			= vbLf
#endif
#define vbNullChar		chr( 0 )
const vbNullString		= ""
const vbFormFeed		= chr( 12 )
const vbTab				= chr( 09 )
const vbVerticalTab		= chr( 11 )

'' FILE
#include once "file.bi"

#endif
