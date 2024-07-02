#Pragma Once
#Include Once "Windows.bi"
#include Once "crt/string.bi"
#Include Once "win/olectl.bi"

Type CAIUnknown Extends Object
	Declare Abstract Function QueryInterface (ByVal riid As REFIID, ByVal ppvObject As LPVOID Ptr) As HRESULT
	Declare Abstract Function AddRef         () As ULong
	Declare Abstract Function Release        () As ULong
End Type

Type CAIDispatch Extends CAIUnknown
	Declare Abstract Function GetTypeInfoCount(ByVal pctinfo As UINT Ptr) As HRESULT
	Declare Abstract Function GetTypeInfo     (ByVal iTInfo As UINT, ByVal lcid As LCID, ByVal ppTInfo As ITypeInfo Ptr Ptr) As HRESULT
	Declare Abstract Function GetIDsOfNames   (ByVal riid As REFIID, ByVal rgszNames As LPOLESTR Ptr, ByVal cNames As UINT, ByVal lcid As LCID, ByVal rgDispId As DISPID Ptr) As HRESULT
	Declare Abstract Function Invoke          (ByVal dispIdMember As DISPID, ByVal riid As REFIID, ByVal lcid As LCID, ByVal wFlags As WORD, ByVal pDispParams As DISPPARAMS Ptr, ByVal pVarResult As VARIANT Ptr, ByVal pExcepInfo As EXCEPINFO Ptr, ByVal puArgErr As UINT Ptr) As HRESULT
End Type
