''
''
'' objfwd -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_objfwd_bi__
#define __win_objfwd_bi__

#include once "win/basetyps.bi"

type LPMONIKER as IMoniker ptr
type LPSTREAM as IStream ptr
type LPMARSHAL as IMarshal ptr
type LPMALLOC as IMalloc ptr
type LPMALLOCSPY as IMallocSpy ptr
type LPMESSAGEFILTER as IMessageFilter ptr
type LPPERSIST as IPersist ptr
type LPPERSISTSTREAM as IPersistStream ptr
type LPRUNNINGOBJECTTABLE as IRunningObjectTable ptr
type LPBINDCTX as IBindCtx ptr
type LPBC as IBindCtx ptr
type LPADVISESINK as IAdviseSink ptr
type LPADVISESINK2 as IAdviseSink2 ptr
type LPDATAOBJECT as IDataObject ptr
type LPDATAADVISEHOLDER as IDataAdviseHolder ptr
type LPENUMMONIKER as IEnumMoniker ptr
type LPENUMFORMATETC as IEnumFORMATETC ptr
type LPENUMSTATDATA as IEnumSTATDATA ptr
type LPENUMSTATSTG as IEnumSTATSTG ptr
type LPENUMSTATPROPSTG as IEnumSTATPROPSTG
type LPENUMSTRING as IEnumString ptr
type LPENUMUNKNOWN as IEnumUnknown ptr
type LPSTORAGE as IStorage ptr
type LPPERSISTSTORAGE as IPersistStorage ptr
type LPLOCKBYTES as ILockBytes ptr
type LPSTDMARSHALINFO as IStdMarshalInfo ptr
type LPEXTERNALCONNECTION as IExternalConnection ptr
type LPRUNNABLEOBJECT as IRunnableObject ptr
type LPROTDATA as IROTData ptr
type LPPERSISTFILE as IPersistFile ptr
type LPROOTSTORAGE as IRootStorage ptr
type LPRPCCHANNELBUFFER as IRpcChannelBuffer ptr
type LPRPCPROXYBUFFER as IRpcProxyBuffer ptr
type LPRPCSTUBBUFFER as IRpcStubBuffer ptr
type LPPROPERTYSTORAGE as IPropertyStorage ptr
type LPENUMSTATPROPSETSTG as IEnumSTATPROPSETSTG ptr
type LPPROPERTYSETSTORAGE as IPropertySetStorage ptr
type LPCLIENTSECURITY as IClientSecurity ptr
type LPSERVERSECURITY as IServerSecurity ptr
type LPCLASSACTIVATOR as IClassActivator ptr
type LPFILLLOCKBYTES as IFillLockBytes ptr
type LPPROGRESSNOTIFY as IProgressNotify ptr
type LPLAYOUTSTORAGE as ILayoutStorage ptr

#endif
