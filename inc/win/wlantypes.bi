'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#if _WIN32_WINNT >= &h0600
	#include once "winapifamily.bi"

	#define _INC_WLANTYPES
	const DOT11_SSID_MAX_LENGTH = 32

	type _DOT11_AUTH_ALGORITHM as long
	enum
		DOT11_AUTH_ALGO_80211_OPEN = 1
		DOT11_AUTH_ALGO_80211_SHARED_KEY = 2
		DOT11_AUTH_ALGO_WPA = 3
		DOT11_AUTH_ALGO_WPA_PSK = 4
		DOT11_AUTH_ALGO_WPA_NONE = 5
		DOT11_AUTH_ALGO_RSNA = 6
		DOT11_AUTH_ALGO_RSNA_PSK = 7
		DOT11_AUTH_ALGO_IHV_START = &h80000000
		DOT11_AUTH_ALGO_IHV_END = &hffffffff
	end enum

	const DOT11_AUTH_ALGORITHM_RSNA_PSK = DOT11_AUTH_ALGO_RSNA_PSK
	const DOT11_AUTH_ALGORITHM_RSNA = DOT11_AUTH_ALGO_RSNA
	const DOT11_AUTH_ALGORITHM_WPA_NONE = DOT11_AUTH_ALGO_WPA_NONE
	const DOT11_AUTH_ALGORITHM_WPA_PSK = DOT11_AUTH_ALGO_WPA_PSK
	const DOT11_AUTH_ALGORITHM_WPA = DOT11_AUTH_ALGO_WPA
	const DOT11_AUTH_ALGORITHM_SHARED_KEY = DOT11_AUTH_ALGO_80211_SHARED_KEY
	const DOT11_AUTH_ALGORITHM_OPEN_SYSTEM = DOT11_AUTH_ALGO_80211_OPEN
	type DOT11_AUTH_ALGORITHM as _DOT11_AUTH_ALGORITHM
	type PDOT11_AUTH_ALGORITHM as DOT11_AUTH_ALGORITHM ptr

	type _DOT11_CIPHER_ALGORITHM as long
	enum
		DOT11_CIPHER_ALGO_NONE = &h00
		DOT11_CIPHER_ALGO_WEP40 = &h01
		DOT11_CIPHER_ALGO_TKIP = &h02
		DOT11_CIPHER_ALGO_CCMP = &h04
		DOT11_CIPHER_ALGO_WEP104 = &h05
		DOT11_CIPHER_ALGO_WPA_USE_GROUP = &h100
		DOT11_CIPHER_ALGO_RSN_USE_GROUP = &h100
		DOT11_CIPHER_ALGO_WEP = &h101
		DOT11_CIPHER_ALGO_IHV_START = &h80000000
		DOT11_CIPHER_ALGO_IHV_END = &hffffffff
	end enum

	type DOT11_CIPHER_ALGORITHM as _DOT11_CIPHER_ALGORITHM
	type PDOT11_CIPHER_ALGORITHM as DOT11_CIPHER_ALGORITHM ptr

	type _DOT11_BSS_TYPE as long
	enum
		dot11_BSS_type_infrastructure = 1
		dot11_BSS_type_independent = 2
		dot11_BSS_type_any = 3
	end enum

	type DOT11_BSS_TYPE as _DOT11_BSS_TYPE
	type PDOT11_BSS_TYPE as _DOT11_BSS_TYPE ptr

	type _DOT11_AUTH_CIPHER_PAIR
		AuthAlgoId as DOT11_AUTH_ALGORITHM
		CipherAlgoId as DOT11_CIPHER_ALGORITHM
	end type

	type DOT11_AUTH_CIPHER_PAIR as _DOT11_AUTH_CIPHER_PAIR
	type PDOT11_AUTH_CIPHER_PAIR as _DOT11_AUTH_CIPHER_PAIR ptr

	type _DOT11_SSID
		uSSIDLength as ULONG
		ucSSID(0 to 31) as UCHAR
	end type

	type DOT11_SSID as _DOT11_SSID
	type PDOT11_SSID as _DOT11_SSID ptr
#endif
