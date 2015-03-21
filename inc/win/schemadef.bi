#pragma once

#define SCHEMADEF_H
#define SCHEMADEF_VERSION 1

type TMPROPINFO
	pszName as LPCWSTR
	sEnumVal as SHORT
	bPrimVal as UBYTE
end type

type TMSCHEMAINFO
	dwSize as DWORD
	iSchemaDefVersion as long
	iThemeMgrVersion as long
	iPropCount as long
	pPropTable as const TMPROPINFO ptr
end type
