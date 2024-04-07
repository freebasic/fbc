'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   FreeBASIC development team

#pragma once

#define _INC_SDKDDKVER

'' _WIN32_WINNT
#define _WIN32_WINNT_NT4        &h0400
#define _WIN32_WINNT_WIN2K      &h0500
#define _WIN32_WINNT_WINXP      &h0501
#define _WIN32_WINNT_WS03       &h0502
#define _WIN32_WINNT_WIN6       &h0600
#define _WIN32_WINNT_VISTA      &h0600
#define _WIN32_WINNT_WS08       &h0600
#define _WIN32_WINNT_LONGHORN   &h0600
#define _WIN32_WINNT_WIN7       &h0601
#define _WIN32_WINNT_WIN8       &h0602

'' _WIN32_IE
#define _WIN32_IE_IE20          &h0200
#define _WIN32_IE_IE30          &h0300
#define _WIN32_IE_IE302         &h0302
#define _WIN32_IE_IE40          &h0400
#define _WIN32_IE_IE401         &h0401
#define _WIN32_IE_IE50          &h0500
#define _WIN32_IE_IE501         &h0501
#define _WIN32_IE_IE55          &h0550
#define _WIN32_IE_IE60          &h0600
#define _WIN32_IE_IE60SP1       &h0601
#define _WIN32_IE_IE60SP2       &h0603
#define _WIN32_IE_IE70          &h0700
#define _WIN32_IE_IE80          &h0800
#define _WIN32_IE_IE90          &h0900
#define _WIN32_IE_IE100         &h0a00

'' Mappings Between IE Version  and Windows Version
#define _WIN32_IE_NT4           _WIN32_IE_IE20
#define _WIN32_IE_NT4SP1        _WIN32_IE_IE20
#define _WIN32_IE_NT4SP2        _WIN32_IE_IE20
#define _WIN32_IE_NT4SP3        _WIN32_IE_IE302
#define _WIN32_IE_NT4SP4        _WIN32_IE_IE401
#define _WIN32_IE_NT4SP5        _WIN32_IE_IE401
#define _WIN32_IE_NT4SP6        _WIN32_IE_IE50
#define _WIN32_IE_WIN98         _WIN32_IE_IE401
#define _WIN32_IE_WIN98SE       _WIN32_IE_IE50
#define _WIN32_IE_WINME         _WIN32_IE_IE55
#define _WIN32_IE_WIN2K         _WIN32_IE_IE501
#define _WIN32_IE_WIN2KSP1      _WIN32_IE_IE501
#define _WIN32_IE_WIN2KSP2      _WIN32_IE_IE501
#define _WIN32_IE_WIN2KSP3      _WIN32_IE_IE501
#define _WIN32_IE_WIN2KSP4      _WIN32_IE_IE501
#define _WIN32_IE_XP            _WIN32_IE_IE60
#define _WIN32_IE_XPSP1         _WIN32_IE_IE60SP1
#define _WIN32_IE_XPSP2         _WIN32_IE_IE60SP2
#define _WIN32_IE_WS03          &h0602
#define _WIN32_IE_WS03SP1       _WIN32_IE_IE60SP2
#define _WIN32_IE_WIN6          _WIN32_IE_IE70
#define _WIN32_IE_LONGHORN      _WIN32_IE_IE70
#define _WIN32_IE_WIN7          _WIN32_IE_IE80
#define _WIN32_IE_WIN8          _WIN32_IE_IE100

'' NTDDI_VERSION
#ifndef NTDDI_WIN2K
#define NTDDI_WIN2K             &h05000000
#endif
#ifndef NTDDI_WIN2KSP1
#define NTDDI_WIN2KSP1          &h05000100
#endif
#ifndef NTDDI_WIN2KSP2
#define NTDDI_WIN2KSP2          &h05000200
#endif
#ifndef NTDDI_WIN2KSP3
#define NTDDI_WIN2KSP3          &h05000300
#endif
#ifndef NTDDI_WIN2KSP4
#define NTDDI_WIN2KSP4          &h05000400
#endif

#ifndef NTDDI_WINXP
#define NTDDI_WINXP             &h05010000
#endif
#ifndef NTDDI_WINXPSP1
#define NTDDI_WINXPSP1          &h05010100
#endif
#ifndef NTDDI_WINXPSP2
#define NTDDI_WINXPSP2          &h05010200
#endif
#ifndef NTDDI_WINXPSP3
#define NTDDI_WINXPSP3          &h05010300
#endif
#ifndef NTDDI_WINXPSP4
#define NTDDI_WINXPSP4          &h05010400
#endif

#define NTDDI_WS03              &h05020000
#define NTDDI_WS03SP1           &h05020100
#define NTDDI_WS03SP2           &h05020200
#define NTDDI_WS03SP3           &h05020300
#define NTDDI_WS03SP4           &h05020400

#define NTDDI_WIN6              &h06000000
#define NTDDI_WIN6SP1           &h06000100
#define NTDDI_WIN6SP2           &h06000200
#define NTDDI_WIN6SP3           &h06000300
#define NTDDI_WIN6SP4           &h06000400

#define NTDDI_VISTA             NTDDI_WIN6
#define NTDDI_VISTASP1          NTDDI_WIN6SP1
#define NTDDI_VISTASP2          NTDDI_WIN6SP2
#define NTDDI_VISTASP3          NTDDI_WIN6SP3
#define NTDDI_VISTASP4          NTDDI_WIN6SP4
#define NTDDI_LONGHORN          NTDDI_VISTA

#define NTDDI_WS08              NTDDI_WIN6SP1
#define NTDDI_WS08SP2           NTDDI_WIN6SP2
#define NTDDI_WS08SP3           NTDDI_WIN6SP3
#define NTDDI_WS08SP4           NTDDI_WIN6SP4

#define NTDDI_WIN7              &h06010000
#define NTDDI_WIN8              &h06020000

'' Version Fields in NTDDI_VERSION
#define OSVERSION_MASK          &hFFFF0000u
#define SPVERSION_MASK          &h0000FF00
#define SUBVERSION_MASK         &h000000FF

'' Macros to Extract Version Fields From NTDDI_VERSION
#define OSVER(Version)          ((Version) and OSVERSION_MASK)
#define SPVER(Version)          (((Version) and SPVERSION_MASK) shr 8)
#define SUBVER(Version)         (((Version) and SUBVERSION_MASK))

'' Macros to get the NTDDI for a given WIN32
#define NTDDI_VERSION_FROM_WIN32_WINNT2(Version)    Version##0000
#define NTDDI_VERSION_FROM_WIN32_WINNT(Version)     NTDDI_VERSION_FROM_WIN32_WINNT2(Version)

'' Select Default WIN32_WINNT Value
#if not defined(_WIN32_WINNT) andalso not defined(_CHICAGO_)
#define _WIN32_WINNT    _WIN32_WINNT_WS03
#endif

'' Choose NTDDI Version
#ifndef NTDDI_VERSION
#ifdef _WIN32_WINNT
#define NTDDI_VERSION   NTDDI_VERSION_FROM_WIN32_WINNT(_WIN32_WINNT)
#else
#define NTDDI_VERSION   NTDDI_WS03
#endif
#endif

'' Choose WINVER Value
#ifndef WINVER
#ifdef _WIN32_WINNT
#define WINVER          _WIN32_WINNT
#else
#define WINVER          &h0502
#endif
#endif

'' Choose IE Version
#ifndef _WIN32_IE
	#ifdef _WIN32_WINNT
		#if (_WIN32_WINNT <= _WIN32_WINNT_NT4)
			#define _WIN32_IE _WIN32_IE_IE50
		#elseif (_WIN32_WINNT <= _WIN32_WINNT_WIN2K)
			#define _WIN32_IE _WIN32_IE_IE501
		#elseif (_WIN32_WINNT <= _WIN32_WINNT_WINXP)
			#define _WIN32_IE _WIN32_IE_IE60
		#elseif (_WIN32_WINNT <= _WIN32_WINNT_WS03)
			#define _WIN32_IE _WIN32_IE_WS03
		#elseif (_WIN32_WINNT <= _WIN32_WINNT_VISTA)
			#define _WIN32_IE _WIN32_IE_LONGHORN
		#elseif (_WIN32_WINNT <= _WIN32_WINNT_WIN7)
			#define _WIN32_IE _WIN32_IE_WIN7
		#elseif (_WIN32_WINNT <= _WIN32_WINNT_WIN8)
			#define _WIN32_IE _WIN32_IE_WIN8
		#else
			#define _WIN32_IE &h0a00
		#endif
	#else
		#define _WIN32_IE &h0700
	#endif
#endif

'' Make Sure NTDDI_VERSION and _WIN32_WINNT Match
#if ((OSVER(NTDDI_VERSION) = NTDDI_WIN2K) andalso (_WIN32_WINNT <> _WIN32_WINNT_WIN2K)) orelse _
	((OSVER(NTDDI_VERSION) = NTDDI_WINXP) andalso (_WIN32_WINNT <> _WIN32_WINNT_WINXP)) orelse _
	((OSVER(NTDDI_VERSION) = NTDDI_WS03) andalso (_WIN32_WINNT <> _WIN32_WINNT_WS03))   orelse _
	((OSVER(NTDDI_VERSION) = NTDDI_WINXP) andalso (_WIN32_WINNT <> _WIN32_WINNT_WINXP))
	#error NTDDI_VERSION and _WIN32_WINNT mismatch!
#endif
