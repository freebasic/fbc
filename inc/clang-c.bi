'' FreeBASIC binding for cfe-5.0.0.src
''
'' based on the C header files:
''   University of Illinois/NCSA
''   Open Source License
''
''   Copyright (c) 2007-2016 University of Illinois at Urbana-Champaign.
''   All rights reserved.
''
''   Developed by:
''
''       LLVM Team
''
''       University of Illinois at Urbana-Champaign
''
''       http://llvm.org
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy of
''   this software and associated documentation files (the "Software"), to deal with
''   the Software without restriction, including without limitation the rights to
''   use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
''   of the Software, and to permit persons to whom the Software is furnished to do
''   so, subject to the following conditions:
''
''       * Redistributions of source code must retain the above copyright notice,
''         this list of conditions and the following disclaimers.
''
''       * Redistributions in binary form must reproduce the above copyright notice,
''         this list of conditions and the following disclaimers in the
''         documentation and/or other materials provided with the distribution.
''
''       * Neither the names of the LLVM Team, University of Illinois at
''         Urbana-Champaign, nor the names of its contributors may be used to
''         endorse or promote products derived from this Software without specific
''         prior written permission.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
''   FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
''   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE
''   SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2017 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "crt/time.bi"

extern "C"

#define LLVM_CLANG_C_BUILDSYSTEM_H
#define LLVM_CLANG_C_PLATFORM_H
#define LLVM_CLANG_C_CXERRORCODE_H

type CXErrorCode as long
enum
	CXError_Success = 0
	CXError_Failure = 1
	CXError_Crashed = 2
	CXError_InvalidArguments = 3
	CXError_ASTReadError = 4
end enum

#define LLVM_CLANG_C_CXSTRING_H

type CXString
	data as const any ptr
	private_flags as ulong
end type

type CXStringSet
	Strings as CXString ptr
	Count as ulong
end type

declare function clang_getCString(byval string as CXString) as const zstring ptr
declare sub clang_disposeString(byval string as CXString)
declare sub clang_disposeStringSet(byval set as CXStringSet ptr)
declare function clang_getBuildSessionTimestamp() as ulongint
type CXVirtualFileOverlay as CXVirtualFileOverlayImpl ptr
declare function clang_VirtualFileOverlay_create(byval options as ulong) as CXVirtualFileOverlay
declare function clang_VirtualFileOverlay_addFileMapping(byval as CXVirtualFileOverlay, byval virtualPath as const zstring ptr, byval realPath as const zstring ptr) as CXErrorCode
declare function clang_VirtualFileOverlay_setCaseSensitivity(byval as CXVirtualFileOverlay, byval caseSensitive as long) as CXErrorCode
declare function clang_VirtualFileOverlay_writeToBuffer(byval as CXVirtualFileOverlay, byval options as ulong, byval out_buffer_ptr as zstring ptr ptr, byval out_buffer_size as ulong ptr) as CXErrorCode
declare sub clang_free(byval buffer as any ptr)
declare sub clang_VirtualFileOverlay_dispose(byval as CXVirtualFileOverlay)
type CXModuleMapDescriptor as CXModuleMapDescriptorImpl ptr
declare function clang_ModuleMapDescriptor_create(byval options as ulong) as CXModuleMapDescriptor
declare function clang_ModuleMapDescriptor_setFrameworkModuleName(byval as CXModuleMapDescriptor, byval name as const zstring ptr) as CXErrorCode
declare function clang_ModuleMapDescriptor_setUmbrellaHeader(byval as CXModuleMapDescriptor, byval name as const zstring ptr) as CXErrorCode
declare function clang_ModuleMapDescriptor_writeToBuffer(byval as CXModuleMapDescriptor, byval options as ulong, byval out_buffer_ptr as zstring ptr ptr, byval out_buffer_size as ulong ptr) as CXErrorCode
declare sub clang_ModuleMapDescriptor_dispose(byval as CXModuleMapDescriptor)
#define LLVM_CLANG_C_CXCOMPILATIONDATABASE_H

type CXCompilationDatabase as any ptr
type CXCompileCommands as any ptr
type CXCompileCommand as any ptr

type CXCompilationDatabase_Error as long
enum
	CXCompilationDatabase_NoError = 0
	CXCompilationDatabase_CanNotLoadDatabase = 1
end enum

declare function clang_CompilationDatabase_fromDirectory(byval BuildDir as const zstring ptr, byval ErrorCode as CXCompilationDatabase_Error ptr) as CXCompilationDatabase
declare sub clang_CompilationDatabase_dispose(byval as CXCompilationDatabase)
declare function clang_CompilationDatabase_getCompileCommands(byval as CXCompilationDatabase, byval CompleteFileName as const zstring ptr) as CXCompileCommands
declare function clang_CompilationDatabase_getAllCompileCommands(byval as CXCompilationDatabase) as CXCompileCommands
declare sub clang_CompileCommands_dispose(byval as CXCompileCommands)
declare function clang_CompileCommands_getSize(byval as CXCompileCommands) as ulong
declare function clang_CompileCommands_getCommand(byval as CXCompileCommands, byval I as ulong) as CXCompileCommand
declare function clang_CompileCommand_getDirectory(byval as CXCompileCommand) as CXString
declare function clang_CompileCommand_getFilename(byval as CXCompileCommand) as CXString
declare function clang_CompileCommand_getNumArgs(byval as CXCompileCommand) as ulong
declare function clang_CompileCommand_getArg(byval as CXCompileCommand, byval I as ulong) as CXString
declare function clang_CompileCommand_getNumMappedSources(byval as CXCompileCommand) as ulong
declare function clang_CompileCommand_getMappedSourcePath(byval as CXCompileCommand, byval I as ulong) as CXString
declare function clang_CompileCommand_getMappedSourceContent(byval as CXCompileCommand, byval I as ulong) as CXString

#define LLVM_CLANG_C_DOCUMENTATION_H
#define LLVM_CLANG_C_INDEX_H
const CINDEX_VERSION_MAJOR = 0
const CINDEX_VERSION_MINOR = 43
#define CINDEX_VERSION_ENCODE(major, minor) (((major) * 10000) + ((minor) * 1))
#define CINDEX_VERSION CINDEX_VERSION_ENCODE(CINDEX_VERSION_MAJOR, CINDEX_VERSION_MINOR)
#define CINDEX_VERSION_STRINGIZE_(major, minor) #major "." #minor
#define CINDEX_VERSION_STRINGIZE(major, minor) CINDEX_VERSION_STRINGIZE_(major, minor)
#define CINDEX_VERSION_STRING CINDEX_VERSION_STRINGIZE(CINDEX_VERSION_MAJOR, CINDEX_VERSION_MINOR)

type CXIndex as any ptr
type CXTargetInfo as CXTargetInfoImpl ptr
type CXTranslationUnit as CXTranslationUnitImpl ptr
type CXClientData as any ptr

type CXUnsavedFile
	Filename as const zstring ptr
	Contents as const zstring ptr
	Length as culong
end type

type CXAvailabilityKind as long
enum
	CXAvailability_Available
	CXAvailability_Deprecated
	CXAvailability_NotAvailable
	CXAvailability_NotAccessible
end enum

type CXVersion
	Major as long
	Minor as long
	Subminor as long
end type

type CXCursor_ExceptionSpecificationKind as long
enum
	CXCursor_ExceptionSpecificationKind_None
	CXCursor_ExceptionSpecificationKind_DynamicNone
	CXCursor_ExceptionSpecificationKind_Dynamic
	CXCursor_ExceptionSpecificationKind_MSAny
	CXCursor_ExceptionSpecificationKind_BasicNoexcept
	CXCursor_ExceptionSpecificationKind_ComputedNoexcept
	CXCursor_ExceptionSpecificationKind_Unevaluated
	CXCursor_ExceptionSpecificationKind_Uninstantiated
	CXCursor_ExceptionSpecificationKind_Unparsed
end enum

declare function clang_createIndex(byval excludeDeclarationsFromPCH as long, byval displayDiagnostics as long) as CXIndex
declare sub clang_disposeIndex(byval index as CXIndex)

type CXGlobalOptFlags as long
enum
	CXGlobalOpt_None = &h0
	CXGlobalOpt_ThreadBackgroundPriorityForIndexing = &h1
	CXGlobalOpt_ThreadBackgroundPriorityForEditing = &h2
	CXGlobalOpt_ThreadBackgroundPriorityForAll = CXGlobalOpt_ThreadBackgroundPriorityForIndexing or CXGlobalOpt_ThreadBackgroundPriorityForEditing
end enum

declare sub clang_CXIndex_setGlobalOptions(byval as CXIndex, byval options as ulong)
declare function clang_CXIndex_getGlobalOptions(byval as CXIndex) as ulong
type CXFile as any ptr
declare function clang_getFileName(byval SFile as CXFile) as CXString
declare function clang_getFileTime(byval SFile as CXFile) as time_t

type CXFileUniqueID
	data(0 to 2) as ulongint
end type

declare function clang_getFileUniqueID(byval file as CXFile, byval outID as CXFileUniqueID ptr) as long
declare function clang_isFileMultipleIncludeGuarded(byval tu as CXTranslationUnit, byval file as CXFile) as ulong
declare function clang_getFile(byval tu as CXTranslationUnit, byval file_name as const zstring ptr) as CXFile
declare function clang_File_isEqual(byval file1 as CXFile, byval file2 as CXFile) as long

type CXSourceLocation
	ptr_data(0 to 1) as const any ptr
	int_data as ulong
end type

type CXSourceRange
	ptr_data(0 to 1) as const any ptr
	begin_int_data as ulong
	end_int_data as ulong
end type

declare function clang_getNullLocation() as CXSourceLocation
declare function clang_equalLocations(byval loc1 as CXSourceLocation, byval loc2 as CXSourceLocation) as ulong
declare function clang_getLocation(byval tu as CXTranslationUnit, byval file as CXFile, byval line as ulong, byval column as ulong) as CXSourceLocation
declare function clang_getLocationForOffset(byval tu as CXTranslationUnit, byval file as CXFile, byval offset as ulong) as CXSourceLocation
declare function clang_Location_isInSystemHeader(byval location as CXSourceLocation) as long
declare function clang_Location_isFromMainFile(byval location as CXSourceLocation) as long
declare function clang_getNullRange() as CXSourceRange
declare function clang_getRange(byval begin as CXSourceLocation, byval end as CXSourceLocation) as CXSourceRange
declare function clang_equalRanges(byval range1 as CXSourceRange, byval range2 as CXSourceRange) as ulong
declare function clang_Range_isNull(byval range as CXSourceRange) as long
declare sub clang_getExpansionLocation(byval location as CXSourceLocation, byval file as CXFile ptr, byval line as ulong ptr, byval column as ulong ptr, byval offset as ulong ptr)
declare sub clang_getPresumedLocation(byval location as CXSourceLocation, byval filename as CXString ptr, byval line as ulong ptr, byval column as ulong ptr)
declare sub clang_getInstantiationLocation(byval location as CXSourceLocation, byval file as CXFile ptr, byval line as ulong ptr, byval column as ulong ptr, byval offset as ulong ptr)
declare sub clang_getSpellingLocation(byval location as CXSourceLocation, byval file as CXFile ptr, byval line as ulong ptr, byval column as ulong ptr, byval offset as ulong ptr)
declare sub clang_getFileLocation(byval location as CXSourceLocation, byval file as CXFile ptr, byval line as ulong ptr, byval column as ulong ptr, byval offset as ulong ptr)
declare function clang_getRangeStart(byval range as CXSourceRange) as CXSourceLocation
declare function clang_getRangeEnd(byval range as CXSourceRange) as CXSourceLocation

type CXSourceRangeList
	count as ulong
	ranges as CXSourceRange ptr
end type

declare function clang_getSkippedRanges(byval tu as CXTranslationUnit, byval file as CXFile) as CXSourceRangeList ptr
declare function clang_getAllSkippedRanges(byval tu as CXTranslationUnit) as CXSourceRangeList ptr
declare sub clang_disposeSourceRangeList(byval ranges as CXSourceRangeList ptr)

type CXDiagnosticSeverity as long
enum
	CXDiagnostic_Ignored = 0
	CXDiagnostic_Note = 1
	CXDiagnostic_Warning = 2
	CXDiagnostic_Error = 3
	CXDiagnostic_Fatal = 4
end enum

type CXDiagnostic as any ptr
type CXDiagnosticSet as any ptr
declare function clang_getNumDiagnosticsInSet(byval Diags as CXDiagnosticSet) as ulong
declare function clang_getDiagnosticInSet(byval Diags as CXDiagnosticSet, byval Index as ulong) as CXDiagnostic

type CXLoadDiag_Error as long
enum
	CXLoadDiag_None = 0
	CXLoadDiag_Unknown = 1
	CXLoadDiag_CannotLoad = 2
	CXLoadDiag_InvalidFile = 3
end enum

declare function clang_loadDiagnostics(byval file as const zstring ptr, byval error as CXLoadDiag_Error ptr, byval errorString as CXString ptr) as CXDiagnosticSet
declare sub clang_disposeDiagnosticSet(byval Diags as CXDiagnosticSet)
declare function clang_getChildDiagnostics(byval D as CXDiagnostic) as CXDiagnosticSet
declare function clang_getNumDiagnostics(byval Unit as CXTranslationUnit) as ulong
declare function clang_getDiagnostic(byval Unit as CXTranslationUnit, byval Index as ulong) as CXDiagnostic
declare function clang_getDiagnosticSetFromTU(byval Unit as CXTranslationUnit) as CXDiagnosticSet
declare sub clang_disposeDiagnostic(byval Diagnostic as CXDiagnostic)

type CXDiagnosticDisplayOptions as long
enum
	CXDiagnostic_DisplaySourceLocation = &h01
	CXDiagnostic_DisplayColumn = &h02
	CXDiagnostic_DisplaySourceRanges = &h04
	CXDiagnostic_DisplayOption = &h08
	CXDiagnostic_DisplayCategoryId = &h10
	CXDiagnostic_DisplayCategoryName = &h20
end enum

declare function clang_formatDiagnostic(byval Diagnostic as CXDiagnostic, byval Options as ulong) as CXString
declare function clang_defaultDiagnosticDisplayOptions() as ulong
declare function clang_getDiagnosticSeverity(byval as CXDiagnostic) as CXDiagnosticSeverity
declare function clang_getDiagnosticLocation(byval as CXDiagnostic) as CXSourceLocation
declare function clang_getDiagnosticSpelling(byval as CXDiagnostic) as CXString
declare function clang_getDiagnosticOption(byval Diag as CXDiagnostic, byval Disable as CXString ptr) as CXString
declare function clang_getDiagnosticCategory(byval as CXDiagnostic) as ulong
declare function clang_getDiagnosticCategoryName(byval Category as ulong) as CXString
declare function clang_getDiagnosticCategoryText(byval as CXDiagnostic) as CXString
declare function clang_getDiagnosticNumRanges(byval as CXDiagnostic) as ulong
declare function clang_getDiagnosticRange(byval Diagnostic as CXDiagnostic, byval Range as ulong) as CXSourceRange
declare function clang_getDiagnosticNumFixIts(byval Diagnostic as CXDiagnostic) as ulong
declare function clang_getDiagnosticFixIt(byval Diagnostic as CXDiagnostic, byval FixIt as ulong, byval ReplacementRange as CXSourceRange ptr) as CXString
declare function clang_getTranslationUnitSpelling(byval CTUnit as CXTranslationUnit) as CXString
declare function clang_createTranslationUnitFromSourceFile(byval CIdx as CXIndex, byval source_filename as const zstring ptr, byval num_clang_command_line_args as long, byval clang_command_line_args as const zstring const ptr ptr, byval num_unsaved_files as ulong, byval unsaved_files as CXUnsavedFile ptr) as CXTranslationUnit
declare function clang_createTranslationUnit(byval CIdx as CXIndex, byval ast_filename as const zstring ptr) as CXTranslationUnit
declare function clang_createTranslationUnit2(byval CIdx as CXIndex, byval ast_filename as const zstring ptr, byval out_TU as CXTranslationUnit ptr) as CXErrorCode

type CXTranslationUnit_Flags as long
enum
	CXTranslationUnit_None = &h0
	CXTranslationUnit_DetailedPreprocessingRecord = &h01
	CXTranslationUnit_Incomplete = &h02
	CXTranslationUnit_PrecompiledPreamble = &h04
	CXTranslationUnit_CacheCompletionResults = &h08
	CXTranslationUnit_ForSerialization = &h10
	CXTranslationUnit_CXXChainedPCH = &h20
	CXTranslationUnit_SkipFunctionBodies = &h40
	CXTranslationUnit_IncludeBriefCommentsInCodeCompletion = &h80
	CXTranslationUnit_CreatePreambleOnFirstParse = &h100
	CXTranslationUnit_KeepGoing = &h200
	CXTranslationUnit_SingleFileParse = &h400
end enum

declare function clang_defaultEditingTranslationUnitOptions() as ulong
declare function clang_parseTranslationUnit(byval CIdx as CXIndex, byval source_filename as const zstring ptr, byval command_line_args as const zstring const ptr ptr, byval num_command_line_args as long, byval unsaved_files as CXUnsavedFile ptr, byval num_unsaved_files as ulong, byval options as ulong) as CXTranslationUnit
declare function clang_parseTranslationUnit2(byval CIdx as CXIndex, byval source_filename as const zstring ptr, byval command_line_args as const zstring const ptr ptr, byval num_command_line_args as long, byval unsaved_files as CXUnsavedFile ptr, byval num_unsaved_files as ulong, byval options as ulong, byval out_TU as CXTranslationUnit ptr) as CXErrorCode
declare function clang_parseTranslationUnit2FullArgv(byval CIdx as CXIndex, byval source_filename as const zstring ptr, byval command_line_args as const zstring const ptr ptr, byval num_command_line_args as long, byval unsaved_files as CXUnsavedFile ptr, byval num_unsaved_files as ulong, byval options as ulong, byval out_TU as CXTranslationUnit ptr) as CXErrorCode

type CXSaveTranslationUnit_Flags as long
enum
	CXSaveTranslationUnit_None = &h0
end enum

declare function clang_defaultSaveOptions(byval TU as CXTranslationUnit) as ulong

type CXSaveError as long
enum
	CXSaveError_None = 0
	CXSaveError_Unknown = 1
	CXSaveError_TranslationErrors = 2
	CXSaveError_InvalidTU = 3
end enum

declare function clang_saveTranslationUnit(byval TU as CXTranslationUnit, byval FileName as const zstring ptr, byval options as ulong) as long
declare function clang_suspendTranslationUnit(byval as CXTranslationUnit) as ulong
declare sub clang_disposeTranslationUnit(byval as CXTranslationUnit)

type CXReparse_Flags as long
enum
	CXReparse_None = &h0
end enum

declare function clang_defaultReparseOptions(byval TU as CXTranslationUnit) as ulong
declare function clang_reparseTranslationUnit(byval TU as CXTranslationUnit, byval num_unsaved_files as ulong, byval unsaved_files as CXUnsavedFile ptr, byval options as ulong) as long

type CXTUResourceUsageKind as long
enum
	CXTUResourceUsage_AST = 1
	CXTUResourceUsage_Identifiers = 2
	CXTUResourceUsage_Selectors = 3
	CXTUResourceUsage_GlobalCompletionResults = 4
	CXTUResourceUsage_SourceManagerContentCache = 5
	CXTUResourceUsage_AST_SideTables = 6
	CXTUResourceUsage_SourceManager_Membuffer_Malloc = 7
	CXTUResourceUsage_SourceManager_Membuffer_MMap = 8
	CXTUResourceUsage_ExternalASTSource_Membuffer_Malloc = 9
	CXTUResourceUsage_ExternalASTSource_Membuffer_MMap = 10
	CXTUResourceUsage_Preprocessor = 11
	CXTUResourceUsage_PreprocessingRecord = 12
	CXTUResourceUsage_SourceManager_DataStructures = 13
	CXTUResourceUsage_Preprocessor_HeaderSearch = 14
	CXTUResourceUsage_MEMORY_IN_BYTES_BEGIN = CXTUResourceUsage_AST
	CXTUResourceUsage_MEMORY_IN_BYTES_END = CXTUResourceUsage_Preprocessor_HeaderSearch
	CXTUResourceUsage_First = CXTUResourceUsage_AST
	CXTUResourceUsage_Last = CXTUResourceUsage_Preprocessor_HeaderSearch
end enum

declare function clang_getTUResourceUsageName(byval kind as CXTUResourceUsageKind) as const zstring ptr

type CXTUResourceUsageEntry
	kind as CXTUResourceUsageKind
	amount as culong
end type

type CXTUResourceUsage
	data as any ptr
	numEntries as ulong
	entries as CXTUResourceUsageEntry ptr
end type

declare function clang_getCXTUResourceUsage(byval TU as CXTranslationUnit) as CXTUResourceUsage
declare sub clang_disposeCXTUResourceUsage(byval usage as CXTUResourceUsage)
declare function clang_getTranslationUnitTargetInfo(byval CTUnit as CXTranslationUnit) as CXTargetInfo
declare sub clang_TargetInfo_dispose(byval Info as CXTargetInfo)
declare function clang_TargetInfo_getTriple(byval Info as CXTargetInfo) as CXString
declare function clang_TargetInfo_getPointerWidth(byval Info as CXTargetInfo) as long

type CXCursorKind as long
enum
	CXCursor_UnexposedDecl = 1
	CXCursor_StructDecl = 2
	CXCursor_UnionDecl = 3
	CXCursor_ClassDecl = 4
	CXCursor_EnumDecl = 5
	CXCursor_FieldDecl = 6
	CXCursor_EnumConstantDecl = 7
	CXCursor_FunctionDecl = 8
	CXCursor_VarDecl = 9
	CXCursor_ParmDecl = 10
	CXCursor_ObjCInterfaceDecl = 11
	CXCursor_ObjCCategoryDecl = 12
	CXCursor_ObjCProtocolDecl = 13
	CXCursor_ObjCPropertyDecl = 14
	CXCursor_ObjCIvarDecl = 15
	CXCursor_ObjCInstanceMethodDecl = 16
	CXCursor_ObjCClassMethodDecl = 17
	CXCursor_ObjCImplementationDecl = 18
	CXCursor_ObjCCategoryImplDecl = 19
	CXCursor_TypedefDecl = 20
	CXCursor_CXXMethod = 21
	CXCursor_Namespace = 22
	CXCursor_LinkageSpec = 23
	CXCursor_Constructor = 24
	CXCursor_Destructor = 25
	CXCursor_ConversionFunction = 26
	CXCursor_TemplateTypeParameter = 27
	CXCursor_NonTypeTemplateParameter = 28
	CXCursor_TemplateTemplateParameter = 29
	CXCursor_FunctionTemplate = 30
	CXCursor_ClassTemplate = 31
	CXCursor_ClassTemplatePartialSpecialization = 32
	CXCursor_NamespaceAlias = 33
	CXCursor_UsingDirective = 34
	CXCursor_UsingDeclaration = 35
	CXCursor_TypeAliasDecl = 36
	CXCursor_ObjCSynthesizeDecl = 37
	CXCursor_ObjCDynamicDecl = 38
	CXCursor_CXXAccessSpecifier = 39
	CXCursor_FirstDecl = CXCursor_UnexposedDecl
	CXCursor_LastDecl = CXCursor_CXXAccessSpecifier
	CXCursor_FirstRef = 40
	CXCursor_ObjCSuperClassRef = 40
	CXCursor_ObjCProtocolRef = 41
	CXCursor_ObjCClassRef = 42
	CXCursor_TypeRef = 43
	CXCursor_CXXBaseSpecifier = 44
	CXCursor_TemplateRef = 45
	CXCursor_NamespaceRef = 46
	CXCursor_MemberRef = 47
	CXCursor_LabelRef = 48
	CXCursor_OverloadedDeclRef = 49
	CXCursor_VariableRef = 50
	CXCursor_LastRef = CXCursor_VariableRef
	CXCursor_FirstInvalid = 70
	CXCursor_InvalidFile = 70
	CXCursor_NoDeclFound = 71
	CXCursor_NotImplemented = 72
	CXCursor_InvalidCode = 73
	CXCursor_LastInvalid = CXCursor_InvalidCode
	CXCursor_FirstExpr = 100
	CXCursor_UnexposedExpr = 100
	CXCursor_DeclRefExpr = 101
	CXCursor_MemberRefExpr = 102
	CXCursor_CallExpr = 103
	CXCursor_ObjCMessageExpr = 104
	CXCursor_BlockExpr = 105
	CXCursor_IntegerLiteral = 106
	CXCursor_FloatingLiteral = 107
	CXCursor_ImaginaryLiteral = 108
	CXCursor_StringLiteral = 109
	CXCursor_CharacterLiteral = 110
	CXCursor_ParenExpr = 111
	CXCursor_UnaryOperator = 112
	CXCursor_ArraySubscriptExpr = 113
	CXCursor_BinaryOperator = 114
	CXCursor_CompoundAssignOperator = 115
	CXCursor_ConditionalOperator = 116
	CXCursor_CStyleCastExpr = 117
	CXCursor_CompoundLiteralExpr = 118
	CXCursor_InitListExpr = 119
	CXCursor_AddrLabelExpr = 120
	CXCursor_StmtExpr = 121
	CXCursor_GenericSelectionExpr = 122
	CXCursor_GNUNullExpr = 123
	CXCursor_CXXStaticCastExpr = 124
	CXCursor_CXXDynamicCastExpr = 125
	CXCursor_CXXReinterpretCastExpr = 126
	CXCursor_CXXConstCastExpr = 127
	CXCursor_CXXFunctionalCastExpr = 128
	CXCursor_CXXTypeidExpr = 129
	CXCursor_CXXBoolLiteralExpr = 130
	CXCursor_CXXNullPtrLiteralExpr = 131
	CXCursor_CXXThisExpr = 132
	CXCursor_CXXThrowExpr = 133
	CXCursor_CXXNewExpr = 134
	CXCursor_CXXDeleteExpr = 135
	CXCursor_UnaryExpr = 136
	CXCursor_ObjCStringLiteral = 137
	CXCursor_ObjCEncodeExpr = 138
	CXCursor_ObjCSelectorExpr = 139
	CXCursor_ObjCProtocolExpr = 140
	CXCursor_ObjCBridgedCastExpr = 141
	CXCursor_PackExpansionExpr = 142
	CXCursor_SizeOfPackExpr = 143
	CXCursor_LambdaExpr = 144
	CXCursor_ObjCBoolLiteralExpr = 145
	CXCursor_ObjCSelfExpr = 146
	CXCursor_OMPArraySectionExpr = 147
	CXCursor_ObjCAvailabilityCheckExpr = 148
	CXCursor_LastExpr = CXCursor_ObjCAvailabilityCheckExpr
	CXCursor_FirstStmt = 200
	CXCursor_UnexposedStmt = 200
	CXCursor_LabelStmt = 201
	CXCursor_CompoundStmt = 202
	CXCursor_CaseStmt = 203
	CXCursor_DefaultStmt = 204
	CXCursor_IfStmt = 205
	CXCursor_SwitchStmt = 206
	CXCursor_WhileStmt = 207
	CXCursor_DoStmt = 208
	CXCursor_ForStmt = 209
	CXCursor_GotoStmt = 210
	CXCursor_IndirectGotoStmt = 211
	CXCursor_ContinueStmt = 212
	CXCursor_BreakStmt = 213
	CXCursor_ReturnStmt = 214
	CXCursor_GCCAsmStmt = 215
	CXCursor_AsmStmt = CXCursor_GCCAsmStmt
	CXCursor_ObjCAtTryStmt = 216
	CXCursor_ObjCAtCatchStmt = 217
	CXCursor_ObjCAtFinallyStmt = 218
	CXCursor_ObjCAtThrowStmt = 219
	CXCursor_ObjCAtSynchronizedStmt = 220
	CXCursor_ObjCAutoreleasePoolStmt = 221
	CXCursor_ObjCForCollectionStmt = 222
	CXCursor_CXXCatchStmt = 223
	CXCursor_CXXTryStmt = 224
	CXCursor_CXXForRangeStmt = 225
	CXCursor_SEHTryStmt = 226
	CXCursor_SEHExceptStmt = 227
	CXCursor_SEHFinallyStmt = 228
	CXCursor_MSAsmStmt = 229
	CXCursor_NullStmt = 230
	CXCursor_DeclStmt = 231
	CXCursor_OMPParallelDirective = 232
	CXCursor_OMPSimdDirective = 233
	CXCursor_OMPForDirective = 234
	CXCursor_OMPSectionsDirective = 235
	CXCursor_OMPSectionDirective = 236
	CXCursor_OMPSingleDirective = 237
	CXCursor_OMPParallelForDirective = 238
	CXCursor_OMPParallelSectionsDirective = 239
	CXCursor_OMPTaskDirective = 240
	CXCursor_OMPMasterDirective = 241
	CXCursor_OMPCriticalDirective = 242
	CXCursor_OMPTaskyieldDirective = 243
	CXCursor_OMPBarrierDirective = 244
	CXCursor_OMPTaskwaitDirective = 245
	CXCursor_OMPFlushDirective = 246
	CXCursor_SEHLeaveStmt = 247
	CXCursor_OMPOrderedDirective = 248
	CXCursor_OMPAtomicDirective = 249
	CXCursor_OMPForSimdDirective = 250
	CXCursor_OMPParallelForSimdDirective = 251
	CXCursor_OMPTargetDirective = 252
	CXCursor_OMPTeamsDirective = 253
	CXCursor_OMPTaskgroupDirective = 254
	CXCursor_OMPCancellationPointDirective = 255
	CXCursor_OMPCancelDirective = 256
	CXCursor_OMPTargetDataDirective = 257
	CXCursor_OMPTaskLoopDirective = 258
	CXCursor_OMPTaskLoopSimdDirective = 259
	CXCursor_OMPDistributeDirective = 260
	CXCursor_OMPTargetEnterDataDirective = 261
	CXCursor_OMPTargetExitDataDirective = 262
	CXCursor_OMPTargetParallelDirective = 263
	CXCursor_OMPTargetParallelForDirective = 264
	CXCursor_OMPTargetUpdateDirective = 265
	CXCursor_OMPDistributeParallelForDirective = 266
	CXCursor_OMPDistributeParallelForSimdDirective = 267
	CXCursor_OMPDistributeSimdDirective = 268
	CXCursor_OMPTargetParallelForSimdDirective = 269
	CXCursor_OMPTargetSimdDirective = 270
	CXCursor_OMPTeamsDistributeDirective = 271
	CXCursor_OMPTeamsDistributeSimdDirective = 272
	CXCursor_OMPTeamsDistributeParallelForSimdDirective = 273
	CXCursor_OMPTeamsDistributeParallelForDirective = 274
	CXCursor_OMPTargetTeamsDirective = 275
	CXCursor_OMPTargetTeamsDistributeDirective = 276
	CXCursor_OMPTargetTeamsDistributeParallelForDirective = 277
	CXCursor_OMPTargetTeamsDistributeParallelForSimdDirective = 278
	CXCursor_OMPTargetTeamsDistributeSimdDirective = 279
	CXCursor_LastStmt = CXCursor_OMPTargetTeamsDistributeSimdDirective
	CXCursor_TranslationUnit = 300
	CXCursor_FirstAttr = 400
	CXCursor_UnexposedAttr = 400
	CXCursor_IBActionAttr = 401
	CXCursor_IBOutletAttr = 402
	CXCursor_IBOutletCollectionAttr = 403
	CXCursor_CXXFinalAttr = 404
	CXCursor_CXXOverrideAttr = 405
	CXCursor_AnnotateAttr = 406
	CXCursor_AsmLabelAttr = 407
	CXCursor_PackedAttr = 408
	CXCursor_PureAttr = 409
	CXCursor_ConstAttr = 410
	CXCursor_NoDuplicateAttr = 411
	CXCursor_CUDAConstantAttr = 412
	CXCursor_CUDADeviceAttr = 413
	CXCursor_CUDAGlobalAttr = 414
	CXCursor_CUDAHostAttr = 415
	CXCursor_CUDASharedAttr = 416
	CXCursor_VisibilityAttr = 417
	CXCursor_DLLExport = 418
	CXCursor_DLLImport = 419
	CXCursor_LastAttr = CXCursor_DLLImport
	CXCursor_PreprocessingDirective = 500
	CXCursor_MacroDefinition = 501
	CXCursor_MacroExpansion = 502
	CXCursor_MacroInstantiation = CXCursor_MacroExpansion
	CXCursor_InclusionDirective = 503
	CXCursor_FirstPreprocessing = CXCursor_PreprocessingDirective
	CXCursor_LastPreprocessing = CXCursor_InclusionDirective
	CXCursor_ModuleImportDecl = 600
	CXCursor_TypeAliasTemplateDecl = 601
	CXCursor_StaticAssert = 602
	CXCursor_FriendDecl = 603
	CXCursor_FirstExtraDecl = CXCursor_ModuleImportDecl
	CXCursor_LastExtraDecl = CXCursor_FriendDecl
	CXCursor_OverloadCandidate = 700
end enum

type CXCursor
	kind as CXCursorKind
	xdata as long
	data(0 to 2) as const any ptr
end type

declare function clang_getNullCursor() as CXCursor
declare function clang_getTranslationUnitCursor(byval as CXTranslationUnit) as CXCursor
declare function clang_equalCursors(byval as CXCursor, byval as CXCursor) as ulong
declare function clang_Cursor_isNull(byval cursor as CXCursor) as long
declare function clang_hashCursor(byval as CXCursor) as ulong
declare function clang_getCursorKind(byval as CXCursor) as CXCursorKind
declare function clang_isDeclaration(byval as CXCursorKind) as ulong
declare function clang_isReference(byval as CXCursorKind) as ulong
declare function clang_isExpression(byval as CXCursorKind) as ulong
declare function clang_isStatement(byval as CXCursorKind) as ulong
declare function clang_isAttribute(byval as CXCursorKind) as ulong
declare function clang_Cursor_hasAttrs(byval C as CXCursor) as ulong
declare function clang_isInvalid(byval as CXCursorKind) as ulong
declare function clang_isTranslationUnit(byval as CXCursorKind) as ulong
declare function clang_isPreprocessing(byval as CXCursorKind) as ulong
declare function clang_isUnexposed(byval as CXCursorKind) as ulong

type CXLinkageKind as long
enum
	CXLinkage_Invalid
	CXLinkage_NoLinkage
	CXLinkage_Internal
	CXLinkage_UniqueExternal
	CXLinkage_External
end enum

declare function clang_getCursorLinkage(byval cursor as CXCursor) as CXLinkageKind

type CXVisibilityKind as long
enum
	CXVisibility_Invalid
	CXVisibility_Hidden
	CXVisibility_Protected
	CXVisibility_Default
end enum

declare function clang_getCursorVisibility(byval cursor as CXCursor) as CXVisibilityKind
declare function clang_getCursorAvailability(byval cursor as CXCursor) as CXAvailabilityKind

type CXPlatformAvailability
	Platform as CXString
	Introduced as CXVersion
	Deprecated as CXVersion
	Obsoleted as CXVersion
	Unavailable as long
	Message as CXString
end type

declare function clang_getCursorPlatformAvailability(byval cursor as CXCursor, byval always_deprecated as long ptr, byval deprecated_message as CXString ptr, byval always_unavailable as long ptr, byval unavailable_message as CXString ptr, byval availability as CXPlatformAvailability ptr, byval availability_size as long) as long
declare sub clang_disposeCXPlatformAvailability(byval availability as CXPlatformAvailability ptr)

type CXLanguageKind as long
enum
	CXLanguage_Invalid = 0
	CXLanguage_C
	CXLanguage_ObjC
	CXLanguage_CPlusPlus
end enum

declare function clang_getCursorLanguage(byval cursor as CXCursor) as CXLanguageKind
declare function clang_Cursor_getTranslationUnit(byval as CXCursor) as CXTranslationUnit
type CXCursorSet as CXCursorSetImpl ptr
declare function clang_createCXCursorSet() as CXCursorSet
declare sub clang_disposeCXCursorSet(byval cset as CXCursorSet)
declare function clang_CXCursorSet_contains(byval cset as CXCursorSet, byval cursor as CXCursor) as ulong
declare function clang_CXCursorSet_insert(byval cset as CXCursorSet, byval cursor as CXCursor) as ulong
declare function clang_getCursorSemanticParent(byval cursor as CXCursor) as CXCursor
declare function clang_getCursorLexicalParent(byval cursor as CXCursor) as CXCursor
declare sub clang_getOverriddenCursors(byval cursor as CXCursor, byval overridden as CXCursor ptr ptr, byval num_overridden as ulong ptr)
declare sub clang_disposeOverriddenCursors(byval overridden as CXCursor ptr)
declare function clang_getIncludedFile(byval cursor as CXCursor) as CXFile
declare function clang_getCursor(byval as CXTranslationUnit, byval as CXSourceLocation) as CXCursor
declare function clang_getCursorLocation(byval as CXCursor) as CXSourceLocation
declare function clang_getCursorExtent(byval as CXCursor) as CXSourceRange

type CXTypeKind as long
enum
	CXType_Invalid = 0
	CXType_Unexposed = 1
	CXType_Void = 2
	CXType_Bool = 3
	CXType_Char_U = 4
	CXType_UChar = 5
	CXType_Char16 = 6
	CXType_Char32 = 7
	CXType_UShort = 8
	CXType_UInt = 9
	CXType_ULong = 10
	CXType_ULongLong = 11
	CXType_UInt128 = 12
	CXType_Char_S = 13
	CXType_SChar = 14
	CXType_WChar = 15
	CXType_Short = 16
	CXType_Int = 17
	CXType_Long = 18
	CXType_LongLong = 19
	CXType_Int128 = 20
	CXType_Float = 21
	CXType_Double = 22
	CXType_LongDouble = 23
	CXType_NullPtr = 24
	CXType_Overload = 25
	CXType_Dependent = 26
	CXType_ObjCId = 27
	CXType_ObjCClass = 28
	CXType_ObjCSel = 29
	CXType_Float128 = 30
	CXType_Half = 31
	CXType_FirstBuiltin = CXType_Void
	CXType_LastBuiltin = CXType_Half
	CXType_Complex = 100
	CXType_Pointer = 101
	CXType_BlockPointer = 102
	CXType_LValueReference = 103
	CXType_RValueReference = 104
	CXType_Record = 105
	CXType_Enum = 106
	CXType_Typedef = 107
	CXType_ObjCInterface = 108
	CXType_ObjCObjectPointer = 109
	CXType_FunctionNoProto = 110
	CXType_FunctionProto = 111
	CXType_ConstantArray = 112
	CXType_Vector = 113
	CXType_IncompleteArray = 114
	CXType_VariableArray = 115
	CXType_DependentSizedArray = 116
	CXType_MemberPointer = 117
	CXType_Auto = 118
	CXType_Elaborated = 119
	CXType_Pipe = 120
	CXType_OCLImage1dRO = 121
	CXType_OCLImage1dArrayRO = 122
	CXType_OCLImage1dBufferRO = 123
	CXType_OCLImage2dRO = 124
	CXType_OCLImage2dArrayRO = 125
	CXType_OCLImage2dDepthRO = 126
	CXType_OCLImage2dArrayDepthRO = 127
	CXType_OCLImage2dMSAARO = 128
	CXType_OCLImage2dArrayMSAARO = 129
	CXType_OCLImage2dMSAADepthRO = 130
	CXType_OCLImage2dArrayMSAADepthRO = 131
	CXType_OCLImage3dRO = 132
	CXType_OCLImage1dWO = 133
	CXType_OCLImage1dArrayWO = 134
	CXType_OCLImage1dBufferWO = 135
	CXType_OCLImage2dWO = 136
	CXType_OCLImage2dArrayWO = 137
	CXType_OCLImage2dDepthWO = 138
	CXType_OCLImage2dArrayDepthWO = 139
	CXType_OCLImage2dMSAAWO = 140
	CXType_OCLImage2dArrayMSAAWO = 141
	CXType_OCLImage2dMSAADepthWO = 142
	CXType_OCLImage2dArrayMSAADepthWO = 143
	CXType_OCLImage3dWO = 144
	CXType_OCLImage1dRW = 145
	CXType_OCLImage1dArrayRW = 146
	CXType_OCLImage1dBufferRW = 147
	CXType_OCLImage2dRW = 148
	CXType_OCLImage2dArrayRW = 149
	CXType_OCLImage2dDepthRW = 150
	CXType_OCLImage2dArrayDepthRW = 151
	CXType_OCLImage2dMSAARW = 152
	CXType_OCLImage2dArrayMSAARW = 153
	CXType_OCLImage2dMSAADepthRW = 154
	CXType_OCLImage2dArrayMSAADepthRW = 155
	CXType_OCLImage3dRW = 156
	CXType_OCLSampler = 157
	CXType_OCLEvent = 158
	CXType_OCLQueue = 159
	CXType_OCLReserveID = 160
end enum

type CXCallingConv as long
enum
	CXCallingConv_Default = 0
	CXCallingConv_C = 1
	CXCallingConv_X86StdCall = 2
	CXCallingConv_X86FastCall = 3
	CXCallingConv_X86ThisCall = 4
	CXCallingConv_X86Pascal = 5
	CXCallingConv_AAPCS = 6
	CXCallingConv_AAPCS_VFP = 7
	CXCallingConv_X86RegCall = 8
	CXCallingConv_IntelOclBicc = 9
	CXCallingConv_Win64 = 10
	CXCallingConv_X86_64Win64 = CXCallingConv_Win64
	CXCallingConv_X86_64SysV = 11
	CXCallingConv_X86VectorCall = 12
	CXCallingConv_Swift = 13
	CXCallingConv_PreserveMost = 14
	CXCallingConv_PreserveAll = 15
	CXCallingConv_Invalid = 100
	CXCallingConv_Unexposed = 200
end enum

type CXType
	kind as CXTypeKind
	data(0 to 1) as any ptr
end type

declare function clang_getCursorType(byval C as CXCursor) as CXType
declare function clang_getTypeSpelling(byval CT as CXType) as CXString
declare function clang_getTypedefDeclUnderlyingType(byval C as CXCursor) as CXType
declare function clang_getEnumDeclIntegerType(byval C as CXCursor) as CXType
declare function clang_getEnumConstantDeclValue(byval C as CXCursor) as longint
declare function clang_getEnumConstantDeclUnsignedValue(byval C as CXCursor) as ulongint
declare function clang_getFieldDeclBitWidth(byval C as CXCursor) as long
declare function clang_Cursor_getNumArguments(byval C as CXCursor) as long
declare function clang_Cursor_getArgument(byval C as CXCursor, byval i as ulong) as CXCursor

type CXTemplateArgumentKind as long
enum
	CXTemplateArgumentKind_Null
	CXTemplateArgumentKind_Type
	CXTemplateArgumentKind_Declaration
	CXTemplateArgumentKind_NullPtr
	CXTemplateArgumentKind_Integral
	CXTemplateArgumentKind_Template
	CXTemplateArgumentKind_TemplateExpansion
	CXTemplateArgumentKind_Expression
	CXTemplateArgumentKind_Pack
	CXTemplateArgumentKind_Invalid
end enum

declare function clang_Cursor_getNumTemplateArguments(byval C as CXCursor) as long
declare function clang_Cursor_getTemplateArgumentKind(byval C as CXCursor, byval I as ulong) as CXTemplateArgumentKind
declare function clang_Cursor_getTemplateArgumentType(byval C as CXCursor, byval I as ulong) as CXType
declare function clang_Cursor_getTemplateArgumentValue(byval C as CXCursor, byval I as ulong) as longint
declare function clang_Cursor_getTemplateArgumentUnsignedValue(byval C as CXCursor, byval I as ulong) as ulongint
declare function clang_equalTypes(byval A as CXType, byval B as CXType) as ulong
declare function clang_getCanonicalType(byval T as CXType) as CXType
declare function clang_isConstQualifiedType(byval T as CXType) as ulong
declare function clang_Cursor_isMacroFunctionLike(byval C as CXCursor) as ulong
declare function clang_Cursor_isMacroBuiltin(byval C as CXCursor) as ulong
declare function clang_Cursor_isFunctionInlined(byval C as CXCursor) as ulong
declare function clang_isVolatileQualifiedType(byval T as CXType) as ulong
declare function clang_isRestrictQualifiedType(byval T as CXType) as ulong
declare function clang_getAddressSpace(byval T as CXType) as ulong
declare function clang_getTypedefName(byval CT as CXType) as CXString
declare function clang_getPointeeType(byval T as CXType) as CXType
declare function clang_getTypeDeclaration(byval T as CXType) as CXCursor
declare function clang_getDeclObjCTypeEncoding(byval C as CXCursor) as CXString
declare function clang_Type_getObjCEncoding(byval type as CXType) as CXString
declare function clang_getTypeKindSpelling(byval K as CXTypeKind) as CXString
declare function clang_getFunctionTypeCallingConv(byval T as CXType) as CXCallingConv
declare function clang_getResultType(byval T as CXType) as CXType
declare function clang_getExceptionSpecificationType(byval T as CXType) as long
declare function clang_getNumArgTypes(byval T as CXType) as long
declare function clang_getArgType(byval T as CXType, byval i as ulong) as CXType
declare function clang_isFunctionTypeVariadic(byval T as CXType) as ulong
declare function clang_getCursorResultType(byval C as CXCursor) as CXType
declare function clang_getCursorExceptionSpecificationType(byval C as CXCursor) as long
declare function clang_isPODType(byval T as CXType) as ulong
declare function clang_getElementType(byval T as CXType) as CXType
declare function clang_getNumElements(byval T as CXType) as longint
declare function clang_getArrayElementType(byval T as CXType) as CXType
declare function clang_getArraySize(byval T as CXType) as longint
declare function clang_Type_getNamedType(byval T as CXType) as CXType
declare function clang_Type_isTransparentTagTypedef(byval T as CXType) as ulong

type CXTypeLayoutError as long
enum
	CXTypeLayoutError_Invalid = -1
	CXTypeLayoutError_Incomplete = -2
	CXTypeLayoutError_Dependent = -3
	CXTypeLayoutError_NotConstantSize = -4
	CXTypeLayoutError_InvalidFieldName = -5
end enum

declare function clang_Type_getAlignOf(byval T as CXType) as longint
declare function clang_Type_getClassType(byval T as CXType) as CXType
declare function clang_Type_getSizeOf(byval T as CXType) as longint
declare function clang_Type_getOffsetOf(byval T as CXType, byval S as const zstring ptr) as longint
declare function clang_Cursor_getOffsetOfField(byval C as CXCursor) as longint
declare function clang_Cursor_isAnonymous(byval C as CXCursor) as ulong

type CXRefQualifierKind as long
enum
	CXRefQualifier_None = 0
	CXRefQualifier_LValue
	CXRefQualifier_RValue
end enum

declare function clang_Type_getNumTemplateArguments(byval T as CXType) as long
declare function clang_Type_getTemplateArgumentAsType(byval T as CXType, byval i as ulong) as CXType
declare function clang_Type_getCXXRefQualifier(byval T as CXType) as CXRefQualifierKind
declare function clang_Cursor_isBitField(byval C as CXCursor) as ulong
declare function clang_isVirtualBase(byval as CXCursor) as ulong

type CX_CXXAccessSpecifier as long
enum
	CX_CXXInvalidAccessSpecifier
	CX_CXXPublic
	CX_CXXProtected
	CX_CXXPrivate
end enum

declare function clang_getCXXAccessSpecifier(byval as CXCursor) as CX_CXXAccessSpecifier

type CX_StorageClass as long
enum
	CX_SC_Invalid
	CX_SC_None
	CX_SC_Extern
	CX_SC_Static
	CX_SC_PrivateExtern
	CX_SC_OpenCLWorkGroupLocal
	CX_SC_Auto
	CX_SC_Register
end enum

declare function clang_Cursor_getStorageClass(byval as CXCursor) as CX_StorageClass
declare function clang_getNumOverloadedDecls(byval cursor as CXCursor) as ulong
declare function clang_getOverloadedDecl(byval cursor as CXCursor, byval index as ulong) as CXCursor
declare function clang_getIBOutletCollectionType(byval as CXCursor) as CXType

type CXChildVisitResult as long
enum
	CXChildVisit_Break
	CXChildVisit_Continue
	CXChildVisit_Recurse
end enum

type CXCursorVisitor as function(byval cursor as CXCursor, byval parent as CXCursor, byval client_data as CXClientData) as CXChildVisitResult
declare function clang_visitChildren(byval parent as CXCursor, byval visitor as CXCursorVisitor, byval client_data as CXClientData) as ulong
declare function clang_getCursorUSR(byval as CXCursor) as CXString
declare function clang_constructUSR_ObjCClass(byval class_name as const zstring ptr) as CXString
declare function clang_constructUSR_ObjCCategory(byval class_name as const zstring ptr, byval category_name as const zstring ptr) as CXString
declare function clang_constructUSR_ObjCProtocol(byval protocol_name as const zstring ptr) as CXString
declare function clang_constructUSR_ObjCIvar(byval name as const zstring ptr, byval classUSR as CXString) as CXString
declare function clang_constructUSR_ObjCMethod(byval name as const zstring ptr, byval isInstanceMethod as ulong, byval classUSR as CXString) as CXString
declare function clang_constructUSR_ObjCProperty(byval property as const zstring ptr, byval classUSR as CXString) as CXString
declare function clang_getCursorSpelling(byval as CXCursor) as CXString
declare function clang_Cursor_getSpellingNameRange(byval as CXCursor, byval pieceIndex as ulong, byval options as ulong) as CXSourceRange
declare function clang_getCursorDisplayName(byval as CXCursor) as CXString
declare function clang_getCursorReferenced(byval as CXCursor) as CXCursor
declare function clang_getCursorDefinition(byval as CXCursor) as CXCursor
declare function clang_isCursorDefinition(byval as CXCursor) as ulong
declare function clang_getCanonicalCursor(byval as CXCursor) as CXCursor
declare function clang_Cursor_getObjCSelectorIndex(byval as CXCursor) as long
declare function clang_Cursor_isDynamicCall(byval C as CXCursor) as long
declare function clang_Cursor_getReceiverType(byval C as CXCursor) as CXType

type CXObjCPropertyAttrKind as long
enum
	CXObjCPropertyAttr_noattr = &h00
	CXObjCPropertyAttr_readonly = &h01
	CXObjCPropertyAttr_getter = &h02
	CXObjCPropertyAttr_assign = &h04
	CXObjCPropertyAttr_readwrite = &h08
	CXObjCPropertyAttr_retain = &h10
	CXObjCPropertyAttr_copy = &h20
	CXObjCPropertyAttr_nonatomic = &h40
	CXObjCPropertyAttr_setter = &h80
	CXObjCPropertyAttr_atomic = &h100
	CXObjCPropertyAttr_weak = &h200
	CXObjCPropertyAttr_strong = &h400
	CXObjCPropertyAttr_unsafe_unretained = &h800
	CXObjCPropertyAttr_class = &h1000
end enum

declare function clang_Cursor_getObjCPropertyAttributes(byval C as CXCursor, byval reserved as ulong) as ulong

type CXObjCDeclQualifierKind as long
enum
	CXObjCDeclQualifier_None = &h0
	CXObjCDeclQualifier_In = &h1
	CXObjCDeclQualifier_Inout = &h2
	CXObjCDeclQualifier_Out = &h4
	CXObjCDeclQualifier_Bycopy = &h8
	CXObjCDeclQualifier_Byref = &h10
	CXObjCDeclQualifier_Oneway = &h20
end enum

declare function clang_Cursor_getObjCDeclQualifiers(byval C as CXCursor) as ulong
declare function clang_Cursor_isObjCOptional(byval C as CXCursor) as ulong
declare function clang_Cursor_isVariadic(byval C as CXCursor) as ulong
declare function clang_Cursor_isExternalSymbol(byval C as CXCursor, byval language as CXString ptr, byval definedIn as CXString ptr, byval isGenerated as ulong ptr) as ulong
declare function clang_Cursor_getCommentRange(byval C as CXCursor) as CXSourceRange
declare function clang_Cursor_getRawCommentText(byval C as CXCursor) as CXString
declare function clang_Cursor_getBriefCommentText(byval C as CXCursor) as CXString
declare function clang_Cursor_getMangling(byval as CXCursor) as CXString
declare function clang_Cursor_getCXXManglings(byval as CXCursor) as CXStringSet ptr
type CXModule as any ptr
declare function clang_Cursor_getModule(byval C as CXCursor) as CXModule
declare function clang_getModuleForFile(byval as CXTranslationUnit, byval as CXFile) as CXModule
declare function clang_Module_getASTFile(byval Module as CXModule) as CXFile
declare function clang_Module_getParent(byval Module as CXModule) as CXModule
declare function clang_Module_getName(byval Module as CXModule) as CXString
declare function clang_Module_getFullName(byval Module as CXModule) as CXString
declare function clang_Module_isSystem(byval Module as CXModule) as long
declare function clang_Module_getNumTopLevelHeaders(byval as CXTranslationUnit, byval Module as CXModule) as ulong
declare function clang_Module_getTopLevelHeader(byval as CXTranslationUnit, byval Module as CXModule, byval Index as ulong) as CXFile
declare function clang_CXXConstructor_isConvertingConstructor(byval C as CXCursor) as ulong
declare function clang_CXXConstructor_isCopyConstructor(byval C as CXCursor) as ulong
declare function clang_CXXConstructor_isDefaultConstructor(byval C as CXCursor) as ulong
declare function clang_CXXConstructor_isMoveConstructor(byval C as CXCursor) as ulong
declare function clang_CXXField_isMutable(byval C as CXCursor) as ulong
declare function clang_CXXMethod_isDefaulted(byval C as CXCursor) as ulong
declare function clang_CXXMethod_isPureVirtual(byval C as CXCursor) as ulong
declare function clang_CXXMethod_isStatic(byval C as CXCursor) as ulong
declare function clang_CXXMethod_isVirtual(byval C as CXCursor) as ulong
declare function clang_EnumDecl_isScoped(byval C as CXCursor) as ulong
declare function clang_CXXMethod_isConst(byval C as CXCursor) as ulong
declare function clang_getTemplateCursorKind(byval C as CXCursor) as CXCursorKind
declare function clang_getSpecializedCursorTemplate(byval C as CXCursor) as CXCursor
declare function clang_getCursorReferenceNameRange(byval C as CXCursor, byval NameFlags as ulong, byval PieceIndex as ulong) as CXSourceRange

type CXNameRefFlags as long
enum
	CXNameRange_WantQualifier = &h1
	CXNameRange_WantTemplateArgs = &h2
	CXNameRange_WantSinglePiece = &h4
end enum

type CXTokenKind as long
enum
	CXToken_Punctuation
	CXToken_Keyword
	CXToken_Identifier
	CXToken_Literal
	CXToken_Comment
end enum

type CXToken
	int_data(0 to 3) as ulong
	ptr_data as any ptr
end type

declare function clang_getTokenKind(byval as CXToken) as CXTokenKind
declare function clang_getTokenSpelling(byval as CXTranslationUnit, byval as CXToken) as CXString
declare function clang_getTokenLocation(byval as CXTranslationUnit, byval as CXToken) as CXSourceLocation
declare function clang_getTokenExtent(byval as CXTranslationUnit, byval as CXToken) as CXSourceRange
declare sub clang_tokenize(byval TU as CXTranslationUnit, byval Range as CXSourceRange, byval Tokens as CXToken ptr ptr, byval NumTokens as ulong ptr)
declare sub clang_annotateTokens(byval TU as CXTranslationUnit, byval Tokens as CXToken ptr, byval NumTokens as ulong, byval Cursors as CXCursor ptr)
declare sub clang_disposeTokens(byval TU as CXTranslationUnit, byval Tokens as CXToken ptr, byval NumTokens as ulong)
declare function clang_getCursorKindSpelling(byval Kind as CXCursorKind) as CXString
declare sub clang_getDefinitionSpellingAndExtent(byval as CXCursor, byval startBuf as const zstring ptr ptr, byval endBuf as const zstring ptr ptr, byval startLine as ulong ptr, byval startColumn as ulong ptr, byval endLine as ulong ptr, byval endColumn as ulong ptr)
declare sub clang_enableStackTraces()
declare sub clang_executeOnThread(byval fn as sub(byval as any ptr), byval user_data as any ptr, byval stack_size as ulong)
type CXCompletionString as any ptr

type CXCompletionResult
	CursorKind as CXCursorKind
	CompletionString as CXCompletionString
end type

type CXCompletionChunkKind as long
enum
	CXCompletionChunk_Optional
	CXCompletionChunk_TypedText
	CXCompletionChunk_Text
	CXCompletionChunk_Placeholder
	CXCompletionChunk_Informative
	CXCompletionChunk_CurrentParameter
	CXCompletionChunk_LeftParen
	CXCompletionChunk_RightParen
	CXCompletionChunk_LeftBracket
	CXCompletionChunk_RightBracket
	CXCompletionChunk_LeftBrace
	CXCompletionChunk_RightBrace
	CXCompletionChunk_LeftAngle
	CXCompletionChunk_RightAngle
	CXCompletionChunk_Comma
	CXCompletionChunk_ResultType
	CXCompletionChunk_Colon
	CXCompletionChunk_SemiColon
	CXCompletionChunk_Equal
	CXCompletionChunk_HorizontalSpace
	CXCompletionChunk_VerticalSpace
end enum

declare function clang_getCompletionChunkKind(byval completion_string as CXCompletionString, byval chunk_number as ulong) as CXCompletionChunkKind
declare function clang_getCompletionChunkText(byval completion_string as CXCompletionString, byval chunk_number as ulong) as CXString
declare function clang_getCompletionChunkCompletionString(byval completion_string as CXCompletionString, byval chunk_number as ulong) as CXCompletionString
declare function clang_getNumCompletionChunks(byval completion_string as CXCompletionString) as ulong
declare function clang_getCompletionPriority(byval completion_string as CXCompletionString) as ulong
declare function clang_getCompletionAvailability(byval completion_string as CXCompletionString) as CXAvailabilityKind
declare function clang_getCompletionNumAnnotations(byval completion_string as CXCompletionString) as ulong
declare function clang_getCompletionAnnotation(byval completion_string as CXCompletionString, byval annotation_number as ulong) as CXString
declare function clang_getCompletionParent(byval completion_string as CXCompletionString, byval kind as CXCursorKind ptr) as CXString
declare function clang_getCompletionBriefComment(byval completion_string as CXCompletionString) as CXString
declare function clang_getCursorCompletionString(byval cursor as CXCursor) as CXCompletionString

type CXCodeCompleteResults
	Results as CXCompletionResult ptr
	NumResults as ulong
end type

type CXCodeComplete_Flags as long
enum
	CXCodeComplete_IncludeMacros = &h01
	CXCodeComplete_IncludeCodePatterns = &h02
	CXCodeComplete_IncludeBriefComments = &h04
end enum

type CXCompletionContext as long
enum
	CXCompletionContext_Unexposed = 0
	CXCompletionContext_AnyType = 1 shl 0
	CXCompletionContext_AnyValue = 1 shl 1
	CXCompletionContext_ObjCObjectValue = 1 shl 2
	CXCompletionContext_ObjCSelectorValue = 1 shl 3
	CXCompletionContext_CXXClassTypeValue = 1 shl 4
	CXCompletionContext_DotMemberAccess = 1 shl 5
	CXCompletionContext_ArrowMemberAccess = 1 shl 6
	CXCompletionContext_ObjCPropertyAccess = 1 shl 7
	CXCompletionContext_EnumTag = 1 shl 8
	CXCompletionContext_UnionTag = 1 shl 9
	CXCompletionContext_StructTag = 1 shl 10
	CXCompletionContext_ClassTag = 1 shl 11
	CXCompletionContext_Namespace = 1 shl 12
	CXCompletionContext_NestedNameSpecifier = 1 shl 13
	CXCompletionContext_ObjCInterface = 1 shl 14
	CXCompletionContext_ObjCProtocol = 1 shl 15
	CXCompletionContext_ObjCCategory = 1 shl 16
	CXCompletionContext_ObjCInstanceMessage = 1 shl 17
	CXCompletionContext_ObjCClassMessage = 1 shl 18
	CXCompletionContext_ObjCSelectorName = 1 shl 19
	CXCompletionContext_MacroName = 1 shl 20
	CXCompletionContext_NaturalLanguage = 1 shl 21
	CXCompletionContext_Unknown = (1 shl 22) - 1
end enum

declare function clang_defaultCodeCompleteOptions() as ulong
declare function clang_codeCompleteAt(byval TU as CXTranslationUnit, byval complete_filename as const zstring ptr, byval complete_line as ulong, byval complete_column as ulong, byval unsaved_files as CXUnsavedFile ptr, byval num_unsaved_files as ulong, byval options as ulong) as CXCodeCompleteResults ptr
declare sub clang_sortCodeCompletionResults(byval Results as CXCompletionResult ptr, byval NumResults as ulong)
declare sub clang_disposeCodeCompleteResults(byval Results as CXCodeCompleteResults ptr)
declare function clang_codeCompleteGetNumDiagnostics(byval Results as CXCodeCompleteResults ptr) as ulong
declare function clang_codeCompleteGetDiagnostic(byval Results as CXCodeCompleteResults ptr, byval Index as ulong) as CXDiagnostic
declare function clang_codeCompleteGetContexts(byval Results as CXCodeCompleteResults ptr) as ulongint
declare function clang_codeCompleteGetContainerKind(byval Results as CXCodeCompleteResults ptr, byval IsIncomplete as ulong ptr) as CXCursorKind
declare function clang_codeCompleteGetContainerUSR(byval Results as CXCodeCompleteResults ptr) as CXString
declare function clang_codeCompleteGetObjCSelector(byval Results as CXCodeCompleteResults ptr) as CXString
declare function clang_getClangVersion() as CXString
declare sub clang_toggleCrashRecovery(byval isEnabled as ulong)
type CXInclusionVisitor as sub(byval included_file as CXFile, byval inclusion_stack as CXSourceLocation ptr, byval include_len as ulong, byval client_data as CXClientData)
declare sub clang_getInclusions(byval tu as CXTranslationUnit, byval visitor as CXInclusionVisitor, byval client_data as CXClientData)

type CXEvalResultKind as long
enum
	CXEval_Int = 1
	CXEval_Float = 2
	CXEval_ObjCStrLiteral = 3
	CXEval_StrLiteral = 4
	CXEval_CFStr = 5
	CXEval_Other = 6
	CXEval_UnExposed = 0
end enum

type CXEvalResult as any ptr
declare function clang_Cursor_Evaluate(byval C as CXCursor) as CXEvalResult
declare function clang_EvalResult_getKind(byval E as CXEvalResult) as CXEvalResultKind
declare function clang_EvalResult_getAsInt(byval E as CXEvalResult) as long
declare function clang_EvalResult_getAsLongLong(byval E as CXEvalResult) as longint
declare function clang_EvalResult_isUnsignedInt(byval E as CXEvalResult) as ulong
declare function clang_EvalResult_getAsUnsigned(byval E as CXEvalResult) as ulongint
declare function clang_EvalResult_getAsDouble(byval E as CXEvalResult) as double
declare function clang_EvalResult_getAsStr(byval E as CXEvalResult) as const zstring ptr
declare sub clang_EvalResult_dispose(byval E as CXEvalResult)
type CXRemapping as any ptr
declare function clang_getRemappings(byval path as const zstring ptr) as CXRemapping
declare function clang_getRemappingsFromFileList(byval filePaths as const zstring ptr ptr, byval numFiles as ulong) as CXRemapping
declare function clang_remap_getNumFiles(byval as CXRemapping) as ulong
declare sub clang_remap_getFilenames(byval as CXRemapping, byval index as ulong, byval original as CXString ptr, byval transformed as CXString ptr)
declare sub clang_remap_dispose(byval as CXRemapping)

type CXVisitorResult as long
enum
	CXVisit_Break
	CXVisit_Continue
end enum

type CXCursorAndRangeVisitor
	context as any ptr
	visit as function(byval context as any ptr, byval as CXCursor, byval as CXSourceRange) as CXVisitorResult
end type

type CXResult as long
enum
	CXResult_Success = 0
	CXResult_Invalid = 1
	CXResult_VisitBreak = 2
end enum

declare function clang_findReferencesInFile(byval cursor as CXCursor, byval file as CXFile, byval visitor as CXCursorAndRangeVisitor) as CXResult
declare function clang_findIncludesInFile(byval TU as CXTranslationUnit, byval file as CXFile, byval visitor as CXCursorAndRangeVisitor) as CXResult
type CXIdxClientFile as any ptr
type CXIdxClientEntity as any ptr
type CXIdxClientContainer as any ptr
type CXIdxClientASTFile as any ptr

type CXIdxLoc
	ptr_data(0 to 1) as any ptr
	int_data as ulong
end type

type CXIdxIncludedFileInfo
	hashLoc as CXIdxLoc
	filename as const zstring ptr
	file as CXFile
	isImport as long
	isAngled as long
	isModuleImport as long
end type

type CXIdxImportedASTFileInfo
	file as CXFile
	module as CXModule
	loc as CXIdxLoc
	isImplicit as long
end type

type CXIdxEntityKind as long
enum
	CXIdxEntity_Unexposed = 0
	CXIdxEntity_Typedef = 1
	CXIdxEntity_Function = 2
	CXIdxEntity_Variable = 3
	CXIdxEntity_Field = 4
	CXIdxEntity_EnumConstant = 5
	CXIdxEntity_ObjCClass = 6
	CXIdxEntity_ObjCProtocol = 7
	CXIdxEntity_ObjCCategory = 8
	CXIdxEntity_ObjCInstanceMethod = 9
	CXIdxEntity_ObjCClassMethod = 10
	CXIdxEntity_ObjCProperty = 11
	CXIdxEntity_ObjCIvar = 12
	CXIdxEntity_Enum = 13
	CXIdxEntity_Struct = 14
	CXIdxEntity_Union = 15
	CXIdxEntity_CXXClass = 16
	CXIdxEntity_CXXNamespace = 17
	CXIdxEntity_CXXNamespaceAlias = 18
	CXIdxEntity_CXXStaticVariable = 19
	CXIdxEntity_CXXStaticMethod = 20
	CXIdxEntity_CXXInstanceMethod = 21
	CXIdxEntity_CXXConstructor = 22
	CXIdxEntity_CXXDestructor = 23
	CXIdxEntity_CXXConversionFunction = 24
	CXIdxEntity_CXXTypeAlias = 25
	CXIdxEntity_CXXInterface = 26
end enum

type CXIdxEntityLanguage as long
enum
	CXIdxEntityLang_None = 0
	CXIdxEntityLang_C = 1
	CXIdxEntityLang_ObjC = 2
	CXIdxEntityLang_CXX = 3
	CXIdxEntityLang_Swift = 4
end enum

type CXIdxEntityCXXTemplateKind as long
enum
	CXIdxEntity_NonTemplate = 0
	CXIdxEntity_Template = 1
	CXIdxEntity_TemplatePartialSpecialization = 2
	CXIdxEntity_TemplateSpecialization = 3
end enum

type CXIdxAttrKind as long
enum
	CXIdxAttr_Unexposed = 0
	CXIdxAttr_IBAction = 1
	CXIdxAttr_IBOutlet = 2
	CXIdxAttr_IBOutletCollection = 3
end enum

type CXIdxAttrInfo
	kind as CXIdxAttrKind
	cursor as CXCursor
	loc as CXIdxLoc
end type

type CXIdxEntityInfo
	kind as CXIdxEntityKind
	templateKind as CXIdxEntityCXXTemplateKind
	lang as CXIdxEntityLanguage
	name as const zstring ptr
	USR as const zstring ptr
	cursor as CXCursor
	attributes as const CXIdxAttrInfo const ptr ptr
	numAttributes as ulong
end type

type CXIdxContainerInfo
	cursor as CXCursor
end type

type CXIdxIBOutletCollectionAttrInfo
	attrInfo as const CXIdxAttrInfo ptr
	objcClass as const CXIdxEntityInfo ptr
	classCursor as CXCursor
	classLoc as CXIdxLoc
end type

type CXIdxDeclInfoFlags as long
enum
	CXIdxDeclFlag_Skipped = &h1
end enum

type CXIdxDeclInfo
	entityInfo as const CXIdxEntityInfo ptr
	cursor as CXCursor
	loc as CXIdxLoc
	semanticContainer as const CXIdxContainerInfo ptr
	lexicalContainer as const CXIdxContainerInfo ptr
	isRedeclaration as long
	isDefinition as long
	isContainer as long
	declAsContainer as const CXIdxContainerInfo ptr
	isImplicit as long
	attributes as const CXIdxAttrInfo const ptr ptr
	numAttributes as ulong
	flags as ulong
end type

type CXIdxObjCContainerKind as long
enum
	CXIdxObjCContainer_ForwardRef = 0
	CXIdxObjCContainer_Interface = 1
	CXIdxObjCContainer_Implementation = 2
end enum

type CXIdxObjCContainerDeclInfo
	declInfo as const CXIdxDeclInfo ptr
	kind as CXIdxObjCContainerKind
end type

type CXIdxBaseClassInfo
	base as const CXIdxEntityInfo ptr
	cursor as CXCursor
	loc as CXIdxLoc
end type

type CXIdxObjCProtocolRefInfo
	protocol as const CXIdxEntityInfo ptr
	cursor as CXCursor
	loc as CXIdxLoc
end type

type CXIdxObjCProtocolRefListInfo
	protocols as const CXIdxObjCProtocolRefInfo const ptr ptr
	numProtocols as ulong
end type

type CXIdxObjCInterfaceDeclInfo
	containerInfo as const CXIdxObjCContainerDeclInfo ptr
	superInfo as const CXIdxBaseClassInfo ptr
	protocols as const CXIdxObjCProtocolRefListInfo ptr
end type

type CXIdxObjCCategoryDeclInfo
	containerInfo as const CXIdxObjCContainerDeclInfo ptr
	objcClass as const CXIdxEntityInfo ptr
	classCursor as CXCursor
	classLoc as CXIdxLoc
	protocols as const CXIdxObjCProtocolRefListInfo ptr
end type

type CXIdxObjCPropertyDeclInfo
	declInfo as const CXIdxDeclInfo ptr
	getter as const CXIdxEntityInfo ptr
	setter as const CXIdxEntityInfo ptr
end type

type CXIdxCXXClassDeclInfo
	declInfo as const CXIdxDeclInfo ptr
	bases as const CXIdxBaseClassInfo const ptr ptr
	numBases as ulong
end type

type CXIdxEntityRefKind as long
enum
	CXIdxEntityRef_Direct = 1
	CXIdxEntityRef_Implicit = 2
end enum

type CXIdxEntityRefInfo
	kind as CXIdxEntityRefKind
	cursor as CXCursor
	loc as CXIdxLoc
	referencedEntity as const CXIdxEntityInfo ptr
	parentEntity as const CXIdxEntityInfo ptr
	container as const CXIdxContainerInfo ptr
end type

type IndexerCallbacks
	abortQuery as function(byval client_data as CXClientData, byval reserved as any ptr) as long
	diagnostic as sub(byval client_data as CXClientData, byval as CXDiagnosticSet, byval reserved as any ptr)
	enteredMainFile as function(byval client_data as CXClientData, byval mainFile as CXFile, byval reserved as any ptr) as CXIdxClientFile
	ppIncludedFile as function(byval client_data as CXClientData, byval as const CXIdxIncludedFileInfo ptr) as CXIdxClientFile
	importedASTFile as function(byval client_data as CXClientData, byval as const CXIdxImportedASTFileInfo ptr) as CXIdxClientASTFile
	startedTranslationUnit as function(byval client_data as CXClientData, byval reserved as any ptr) as CXIdxClientContainer
	indexDeclaration as sub(byval client_data as CXClientData, byval as const CXIdxDeclInfo ptr)
	indexEntityReference as sub(byval client_data as CXClientData, byval as const CXIdxEntityRefInfo ptr)
end type

declare function clang_index_isEntityObjCContainerKind(byval as CXIdxEntityKind) as long
declare function clang_index_getObjCContainerDeclInfo(byval as const CXIdxDeclInfo ptr) as const CXIdxObjCContainerDeclInfo ptr
declare function clang_index_getObjCInterfaceDeclInfo(byval as const CXIdxDeclInfo ptr) as const CXIdxObjCInterfaceDeclInfo ptr
declare function clang_index_getObjCCategoryDeclInfo(byval as const CXIdxDeclInfo ptr) as const CXIdxObjCCategoryDeclInfo ptr
declare function clang_index_getObjCProtocolRefListInfo(byval as const CXIdxDeclInfo ptr) as const CXIdxObjCProtocolRefListInfo ptr
declare function clang_index_getObjCPropertyDeclInfo(byval as const CXIdxDeclInfo ptr) as const CXIdxObjCPropertyDeclInfo ptr
declare function clang_index_getIBOutletCollectionAttrInfo(byval as const CXIdxAttrInfo ptr) as const CXIdxIBOutletCollectionAttrInfo ptr
declare function clang_index_getCXXClassDeclInfo(byval as const CXIdxDeclInfo ptr) as const CXIdxCXXClassDeclInfo ptr
declare function clang_index_getClientContainer(byval as const CXIdxContainerInfo ptr) as CXIdxClientContainer
declare sub clang_index_setClientContainer(byval as const CXIdxContainerInfo ptr, byval as CXIdxClientContainer)
declare function clang_index_getClientEntity(byval as const CXIdxEntityInfo ptr) as CXIdxClientEntity
declare sub clang_index_setClientEntity(byval as const CXIdxEntityInfo ptr, byval as CXIdxClientEntity)
type CXIndexAction as any ptr
declare function clang_IndexAction_create(byval CIdx as CXIndex) as CXIndexAction
declare sub clang_IndexAction_dispose(byval as CXIndexAction)

type CXIndexOptFlags as long
enum
	CXIndexOpt_None = &h0
	CXIndexOpt_SuppressRedundantRefs = &h1
	CXIndexOpt_IndexFunctionLocalSymbols = &h2
	CXIndexOpt_IndexImplicitTemplateInstantiations = &h4
	CXIndexOpt_SuppressWarnings = &h8
	CXIndexOpt_SkipParsedBodiesInSession = &h10
end enum

declare function clang_indexSourceFile(byval as CXIndexAction, byval client_data as CXClientData, byval index_callbacks as IndexerCallbacks ptr, byval index_callbacks_size as ulong, byval index_options as ulong, byval source_filename as const zstring ptr, byval command_line_args as const zstring const ptr ptr, byval num_command_line_args as long, byval unsaved_files as CXUnsavedFile ptr, byval num_unsaved_files as ulong, byval out_TU as CXTranslationUnit ptr, byval TU_options as ulong) as long
declare function clang_indexSourceFileFullArgv(byval as CXIndexAction, byval client_data as CXClientData, byval index_callbacks as IndexerCallbacks ptr, byval index_callbacks_size as ulong, byval index_options as ulong, byval source_filename as const zstring ptr, byval command_line_args as const zstring const ptr ptr, byval num_command_line_args as long, byval unsaved_files as CXUnsavedFile ptr, byval num_unsaved_files as ulong, byval out_TU as CXTranslationUnit ptr, byval TU_options as ulong) as long
declare function clang_indexTranslationUnit(byval as CXIndexAction, byval client_data as CXClientData, byval index_callbacks as IndexerCallbacks ptr, byval index_callbacks_size as ulong, byval index_options as ulong, byval as CXTranslationUnit) as long
declare sub clang_indexLoc_getFileLocation(byval loc as CXIdxLoc, byval indexFile as CXIdxClientFile ptr, byval file as CXFile ptr, byval line as ulong ptr, byval column as ulong ptr, byval offset as ulong ptr)
declare function clang_indexLoc_getCXSourceLocation(byval loc as CXIdxLoc) as CXSourceLocation
type CXFieldVisitor as function(byval C as CXCursor, byval client_data as CXClientData) as CXVisitorResult
declare function clang_Type_visitFields(byval T as CXType, byval visitor as CXFieldVisitor, byval client_data as CXClientData) as ulong

type CXComment
	ASTNode as const any ptr
	TranslationUnit as CXTranslationUnit
end type

declare function clang_Cursor_getParsedComment(byval C as CXCursor) as CXComment

type CXCommentKind as long
enum
	CXComment_Null = 0
	CXComment_Text = 1
	CXComment_InlineCommand = 2
	CXComment_HTMLStartTag = 3
	CXComment_HTMLEndTag = 4
	CXComment_Paragraph = 5
	CXComment_BlockCommand = 6
	CXComment_ParamCommand = 7
	CXComment_TParamCommand = 8
	CXComment_VerbatimBlockCommand = 9
	CXComment_VerbatimBlockLine = 10
	CXComment_VerbatimLine = 11
	CXComment_FullComment = 12
end enum

type CXCommentInlineCommandRenderKind as long
enum
	CXCommentInlineCommandRenderKind_Normal
	CXCommentInlineCommandRenderKind_Bold
	CXCommentInlineCommandRenderKind_Monospaced
	CXCommentInlineCommandRenderKind_Emphasized
end enum

type CXCommentParamPassDirection as long
enum
	CXCommentParamPassDirection_In
	CXCommentParamPassDirection_Out
	CXCommentParamPassDirection_InOut
end enum

declare function clang_Comment_getKind(byval Comment as CXComment) as CXCommentKind
declare function clang_Comment_getNumChildren(byval Comment as CXComment) as ulong
declare function clang_Comment_getChild(byval Comment as CXComment, byval ChildIdx as ulong) as CXComment
declare function clang_Comment_isWhitespace(byval Comment as CXComment) as ulong
declare function clang_InlineContentComment_hasTrailingNewline(byval Comment as CXComment) as ulong
declare function clang_TextComment_getText(byval Comment as CXComment) as CXString
declare function clang_InlineCommandComment_getCommandName(byval Comment as CXComment) as CXString
declare function clang_InlineCommandComment_getRenderKind(byval Comment as CXComment) as CXCommentInlineCommandRenderKind
declare function clang_InlineCommandComment_getNumArgs(byval Comment as CXComment) as ulong
declare function clang_InlineCommandComment_getArgText(byval Comment as CXComment, byval ArgIdx as ulong) as CXString
declare function clang_HTMLTagComment_getTagName(byval Comment as CXComment) as CXString
declare function clang_HTMLStartTagComment_isSelfClosing(byval Comment as CXComment) as ulong
declare function clang_HTMLStartTag_getNumAttrs(byval Comment as CXComment) as ulong
declare function clang_HTMLStartTag_getAttrName(byval Comment as CXComment, byval AttrIdx as ulong) as CXString
declare function clang_HTMLStartTag_getAttrValue(byval Comment as CXComment, byval AttrIdx as ulong) as CXString
declare function clang_BlockCommandComment_getCommandName(byval Comment as CXComment) as CXString
declare function clang_BlockCommandComment_getNumArgs(byval Comment as CXComment) as ulong
declare function clang_BlockCommandComment_getArgText(byval Comment as CXComment, byval ArgIdx as ulong) as CXString
declare function clang_BlockCommandComment_getParagraph(byval Comment as CXComment) as CXComment
declare function clang_ParamCommandComment_getParamName(byval Comment as CXComment) as CXString
declare function clang_ParamCommandComment_isParamIndexValid(byval Comment as CXComment) as ulong
declare function clang_ParamCommandComment_getParamIndex(byval Comment as CXComment) as ulong
declare function clang_ParamCommandComment_isDirectionExplicit(byval Comment as CXComment) as ulong
declare function clang_ParamCommandComment_getDirection(byval Comment as CXComment) as CXCommentParamPassDirection
declare function clang_TParamCommandComment_getParamName(byval Comment as CXComment) as CXString
declare function clang_TParamCommandComment_isParamPositionValid(byval Comment as CXComment) as ulong
declare function clang_TParamCommandComment_getDepth(byval Comment as CXComment) as ulong
declare function clang_TParamCommandComment_getIndex(byval Comment as CXComment, byval Depth as ulong) as ulong
declare function clang_VerbatimBlockLineComment_getText(byval Comment as CXComment) as CXString
declare function clang_VerbatimLineComment_getText(byval Comment as CXComment) as CXString
declare function clang_HTMLTagComment_getAsString(byval Comment as CXComment) as CXString
declare function clang_FullComment_getAsHTML(byval Comment as CXComment) as CXString
declare function clang_FullComment_getAsXML(byval Comment as CXComment) as CXString

end extern
