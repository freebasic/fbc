''
''
'' glib -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __glib_bi__
#define __glib_bi__

#ifdef __FB_WIN32__
# pragma push(msbitfields)
#endif

extern "c" lib "glib-2.0"

#include once "glib/galloca.bi"
#include once "glib/garray.bi"
#include once "glib/gasyncqueue.bi"
#include once "glib/gatomic.bi"
#include once "glib/gbacktrace.bi"
#include once "glib/gcache.bi"
#include once "glib/gcompletion.bi"
#include once "glib/gconvert.bi"
#include once "glib/gdataset.bi"
#include once "glib/gdate.bi"
#include once "glib/gdir.bi"
#include once "glib/gerror.bi"
#include once "glib/gfileutils.bi"
#include once "glib/ghash.bi"
#include once "glib/ghook.bi"
#include once "glib/giochannel.bi"
#include once "glib/gkeyfile.bi"
#include once "glib/glist.bi"
#include once "glib/gmacros.bi"
#include once "glib/gmain.bi"
#include once "glib/gmarkup.bi"
#include once "glib/gmem.bi"
#include once "glib/gmessages.bi"
#include once "glib/gnode.bi"
#include once "glib/goption.bi"
#include once "glib/gpattern.bi"
#include once "glib/gprimes.bi"
#include once "glib/gqsort.bi"
#include once "glib/gquark.bi"
#include once "glib/gqueue.bi"
#include once "glib/grand.bi"
#include once "glib/grel.bi"
#include once "glib/gscanner.bi"
#include once "glib/gshell.bi"
#include once "glib/gslist.bi"
#include once "glib/gspawn.bi"
#include once "glib/gstrfuncs.bi"
#include once "glib/gstring.bi"
#include once "glib/gthread.bi"
#include once "glib/gthreadpool.bi"
#include once "glib/gtimer.bi"
#include once "glib/gtree.bi"
#include once "glib/gtypes.bi"
#include once "glib/gunicode.bi"
#include once "glib/gutils.bi"
#include once "glib/gwin32.bi"

end extern

#ifdef __FB_WIN32__
# pragma pop(msbitfields)
#endif

#endif
