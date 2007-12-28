''
''
'' ntdef -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_ntdef_bi__
#define __win_ntdef_bi__

#define OBJ_INHERIT 2L
#define OBJ_PERMANENT 16L
#define OBJ_EXCLUSIVE 32L
#define OBJ_CASE_INSENSITIVE 64L
#define OBJ_OPENIF 128L
#define OBJ_OPENLINK 256L
#define OBJ_VALID_ATTRIBUTES 498L
#define InitializeObjectAttributes(p,n,a,r,s) _
  (p)->Length = sizeof(OBJECT_ATTRIBUTES) :_
  (p)->RootDirectory = (r) :_
  (p)->Attributes = (a) :_
  (p)->ObjectName = (n) :_
  (p)->SecurityDescriptor = (s) :_
  (p)->SecurityQualityOfService = NULL

type NTSTATUS as LONG
type PNTSTATUS as LONG ptr

#ifndef NT_SUCCESS
#define NT_SUCCESS(x) ((x)>=0)
#define STATUS_SUCCESS cint(0)
#endif

#ifndef UNICODE_STRING
type UNICODE_STRING
	Length as USHORT
	MaximumLength as USHORT
	Buffer as PWSTR
end type

type PUNICODE_STRING as UNICODE_STRING ptr
type PCUNICODE_STRING as UNICODE_STRING ptr

type STRING_
	Length as USHORT
	MaximumLength as USHORT
	Buffer as PCHAR
end type
type PSTRING as STRING_ ptr
#endif

type ANSI_STRING as STRING_
type PANSI_STRING as PSTRING
type OEM_STRING as STRING_
type POEM_STRING as PSTRING

type PHYSICAL_ADDRESS as LARGE_INTEGER
type PPHYSICAL_ADDRESS as LARGE_INTEGER ptr

enum SECTION_INHERIT
	ViewShare = 1
	ViewUnmap = 2
end enum

#ifndef OBJECT_ATTRIBUTES
type OBJECT_ATTRIBUTES
	Length as ULONG
	RootDirectory as HANDLE
	ObjectName as PUNICODE_STRING
	Attributes as ULONG
	SecurityDescriptor as PVOID
	SecurityQualityOfService as PVOID
end type

type POBJECT_ATTRIBUTES as OBJECT_ATTRIBUTES ptr
#endif

#endif
