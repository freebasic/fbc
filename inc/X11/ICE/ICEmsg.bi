'' FreeBASIC binding for libICE-1.0.9
''
'' based on the C header files:
''   ****************************************************************************
''
''
''   Copyright 1993, 1998  The Open Group
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation.
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
''   AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
''   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of The Open Group shall not be
''   used in advertising or otherwise to promote the sale, use or other dealings
''   in this Software without prior written authorization from The Open Group.
''
''   Author: Ralph Mor, X Consortium
''   *****************************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/ICE/ICEconn.bi"

extern "C"

#define _ICEMSG_H_
declare function _IceRead(byval as IceConn, byval as culong, byval as zstring ptr) as long
declare sub _IceReadSkip(byval as IceConn, byval as culong)
declare sub _IceWrite(byval as IceConn, byval as culong, byval as zstring ptr)
declare sub _IceErrorBadMinor(byval as IceConn, byval as long, byval as long, byval as long)
declare sub _IceErrorBadState(byval as IceConn, byval as long, byval as long, byval as long)
declare sub _IceErrorBadLength(byval as IceConn, byval as long, byval as long, byval as long)
declare sub _IceErrorBadValue(byval as IceConn, byval as long, byval as long, byval as long, byval as long, byval as IcePointer)
declare function _IcePoMagicCookie1Proc(byval as IceConn, byval as IcePointer ptr, byval as long, byval as long, byval as long, byval as IcePointer, byval as long ptr, byval as IcePointer ptr, byval as zstring ptr ptr) as IcePoAuthStatus
declare function _IcePaMagicCookie1Proc(byval as IceConn, byval as IcePointer ptr, byval as long, byval as long, byval as IcePointer, byval as long ptr, byval as IcePointer ptr, byval as zstring ptr ptr) as IcePaAuthStatus

#define IceValidIO(_iceConn) _iceConn->io_ok
#macro IceGetHeader(_iceConn, _major, _minor, _headerSize, _msgType, _pMsg)
	scope
		if (_iceConn->outbufptr + _headerSize) > _iceConn->outbufmax then
			IceFlush(_iceConn)
		end if
		_pMsg = cptr(_msgType ptr, _iceConn->outbufptr)
		_pMsg->majorOpcode = _major
		_pMsg->minorOpcode = _minor
		_pMsg->length = (_headerSize - XSIZEOF(iceMsg)) shr 3
		_iceConn->outbufptr += _headerSize
		_iceConn->send_sequence += 1
	end scope
#endmacro
#macro IceGetHeaderExtra(_iceConn, _major, _minor, _headerSize, _extra, _msgType, _pMsg, _pData)
	scope
		if ((_iceConn->outbufptr + _headerSize) + ((_extra) shl 3)) > _iceConn->outbufmax then
			IceFlush(_iceConn)
		end if
		_pMsg = cptr(_msgType ptr, _iceConn->outbufptr)
		if ((_iceConn->outbufptr + _headerSize) + ((_extra) shl 3)) <= _iceConn->outbufmax then
			_pData = cptr(any ptr, _pMsg) + _headerSize
		else
			_pData = NULL
		end if
		_pMsg->majorOpcode = _major
		_pMsg->minorOpcode = _minor
		_pMsg->length = ((_headerSize - XSIZEOF(iceMsg)) shr 3) + (_extra)
		_iceConn->outbufptr += _headerSize + ((_extra) shl 3)
		_iceConn->send_sequence += 1
	end scope
#endmacro
#macro IceSimpleMessage(_iceConn, _major, _minor)
	scope
		dim _pMsg as iceMsg ptr
		IceGetHeader(_iceConn, _major, _minor, XSIZEOF(iceMsg), iceMsg, _pMsg)
	end scope
#endmacro
#macro IceErrorHeader(_iceConn, _offendingMajorOpcode, _offendingMinorOpcode, _offendingSequenceNum, _severity, _errorClass, _dataLength)
	scope
		dim _pMsg as iceErrorMsg ptr
		IceGetHeader(_iceConn, _offendingMajorOpcode, ICE_Error, XSIZEOF(iceErrorMsg), iceErrorMsg, _pMsg)
		_pMsg->length += (_dataLength)
		_pMsg->offendingMinorOpcode = cast(CARD8, _offendingMinorOpcode)
		_pMsg->severity = cast(CARD8, _severity)
		_pMsg->offendingSequenceNum = cast(CARD32, _offendingSequenceNum)
		_pMsg->errorClass = cast(CARD16, _errorClass)
	end scope
#endmacro
#macro IceWriteData(_iceConn, _bytes, _data)
	if (_iceConn->outbufptr + (_bytes)) > _iceConn->outbufmax then
		IceFlush(_iceConn)
		_IceWrite(_iceConn, cast(culong, (_bytes)), _data)
	else
		memcpy(_iceConn->outbufptr, _data, _bytes)
		_iceConn->outbufptr += (_bytes)
	end if
#endmacro
#define IceWriteData16(_iceConn, _bytes, _data) IceWriteData(_iceConn, _bytes, cptr(zstring ptr, _data))
#define IceWriteData32(_iceConn, _bytes, _data) IceWriteData(_iceConn, _bytes, cptr(zstring ptr, _data))
#macro IceSendData(_iceConn, _bytes, _data)
	scope
		if _iceConn->outbufptr > _iceConn->outbuf then
			IceFlush(_iceConn)
		end if
		_IceWrite(_iceConn, cast(culong, (_bytes)), _data)
	end scope
#endmacro
#macro IceWritePad(_iceConn, _bytes)
	if (_iceConn->outbufptr + (_bytes)) > _iceConn->outbufmax then
		dim _dummy(0 to 6) as byte
		IceFlush(_iceConn)
		_IceWrite(_iceConn, cast(culong, (_bytes)), @_dummy(0))
	else
		_iceConn->outbufptr += (_bytes)
	end if
#endmacro
#macro IceReadCompleteMessage(_iceConn, _headerSize, _msgType, _pMsg, _pData)
	scope
		dim _bytes as culong
		IceReadMessageHeader(_iceConn, _headerSize, _msgType, _pMsg)
		_bytes = (_pMsg->length shl 3) - (_headerSize - XSIZEOF(iceMsg))
		if (_iceConn->inbufmax - _iceConn->inbufptr) >= _bytes then
			_IceRead(_iceConn, _bytes, _iceConn->inbufptr)
			_pData = _iceConn->inbufptr
			_iceConn->inbufptr += _bytes
		else
			_pData = malloc(_bytes)
			if _pData then
				_IceRead(_iceConn, _bytes, _pData)
			else
				_IceReadSkip(_iceConn, _bytes)
			end if
		end if
	end scope
#endmacro
#macro IceDisposeCompleteMessage(_iceConn, _pData)
	if (cptr(zstring ptr, _pData) < _iceConn->inbuf) orelse (cptr(zstring ptr, _pData) >= _iceConn->inbufmax) then
		free(_pData)
	end if
#endmacro
#define IceReadSimpleMessage(_iceConn, _msgType, _pMsg) scope : _pMsg = cptr(_msgType ptr, _iceConn->inbuf) : end scope
#macro IceReadMessageHeader(_iceConn, _headerSize, _msgType, _pMsg)
	scope
		_IceRead(_iceConn, cast(culong, _headerSize - XSIZEOF(iceMsg)), _iceConn->inbufptr)
		_pMsg = cptr(_msgType ptr, _iceConn->inbuf)
		_iceConn->inbufptr += _headerSize - XSIZEOF(iceMsg)
	end scope
#endmacro
#define IceReadData(_iceConn, _bytes, _pData) _IceRead(_iceConn, cast(culong, (_bytes)), cptr(zstring ptr, _pData))
#define IceReadData16(_iceConn, _swap, _bytes, _pData) scope : _IceRead(_iceConn, cast(culong, (_bytes)), cptr(zstring ptr, _pData)) : end scope
#define IceReadData32(_iceConn, _swap, _bytes, _pData) scope : _IceRead(_iceConn, cast(culong, (_bytes)), cptr(zstring ptr, _pData)) : end scope
#macro IceReadPad(_iceConn, _bytes)
	scope
		dim _dummy as zstring * 7
		_IceRead(_iceConn, cast(culong, (_bytes)), _dummy)
	end scope
#endmacro

end extern
