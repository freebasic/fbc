#ifndef _Common_bi_
#define _Common_bi_ 1

#include once "windows.bi"
#include once "win/exdisp.bi"
#include once "win/mshtmlc.bi"

#include once "CInPlaceFrame.bi"
#include once "CInPlaceSite.bi"
#include once "CClientSite.bi"

#ifdef DOLOG
# define LOG_FUNC() print __FILE__; "::"; __FUNCTION__
#else
# define LOG_FUNC()
#endif

#endif
