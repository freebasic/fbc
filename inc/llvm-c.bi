'' FreeBASIC binding for llvm-5.0.0.src
''
'' based on the C header files:
''   University of Illinois/NCSA
''   Open Source License
''
''   Copyright (c) 2003-2017 University of Illinois at Urbana-Champaign.
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
''   Copyright © 2021 FreeBASIC development team

#pragma once

#include once "crt/math.bi"
#include once "crt/stdint.bi"
#include once "crt/sys/types.bi"
#include once "crt/stddef.bi"

'' The following symbols have been renamed:
''     constant LTO_API_VERSION => LTO_API_VERSION_

extern "C"

#define LLVM_C_ANALYSIS_H
#define LLVM_C_TYPES_H
#define SUPPORT_DATATYPES_H
const HAVE_U_INT64_T = 1

type LLVMBool as long
type LLVMMemoryBufferRef as LLVMOpaqueMemoryBuffer ptr
type LLVMContextRef as LLVMOpaqueContext ptr
type LLVMModuleRef as LLVMOpaqueModule ptr
type LLVMTypeRef as LLVMOpaqueType ptr
type LLVMValueRef as LLVMOpaqueValue ptr
type LLVMBasicBlockRef as LLVMOpaqueBasicBlock ptr
type LLVMMetadataRef as LLVMOpaqueMetadata ptr
type LLVMBuilderRef as LLVMOpaqueBuilder ptr
type LLVMDIBuilderRef as LLVMOpaqueDIBuilder ptr
type LLVMModuleProviderRef as LLVMOpaqueModuleProvider ptr
type LLVMPassManagerRef as LLVMOpaquePassManager ptr
type LLVMPassRegistryRef as LLVMOpaquePassRegistry ptr
type LLVMUseRef as LLVMOpaqueUse ptr
type LLVMAttributeRef as LLVMOpaqueAttributeRef ptr
type LLVMDiagnosticInfoRef as LLVMOpaqueDiagnosticInfo ptr

type LLVMVerifierFailureAction as long
enum
	LLVMAbortProcessAction
	LLVMPrintMessageAction
	LLVMReturnStatusAction
end enum

declare function LLVMVerifyModule(byval M as LLVMModuleRef, byval Action as LLVMVerifierFailureAction, byval OutMessage as zstring ptr ptr) as LLVMBool
declare function LLVMVerifyFunction(byval Fn as LLVMValueRef, byval Action as LLVMVerifierFailureAction) as LLVMBool
declare sub LLVMViewFunctionCFG(byval Fn as LLVMValueRef)
declare sub LLVMViewFunctionCFGOnly(byval Fn as LLVMValueRef)
#define LLVM_C_BITREADER_H
declare function LLVMParseBitcode(byval MemBuf as LLVMMemoryBufferRef, byval OutModule as LLVMModuleRef ptr, byval OutMessage as zstring ptr ptr) as LLVMBool
declare function LLVMParseBitcode2(byval MemBuf as LLVMMemoryBufferRef, byval OutModule as LLVMModuleRef ptr) as LLVMBool
declare function LLVMParseBitcodeInContext(byval ContextRef as LLVMContextRef, byval MemBuf as LLVMMemoryBufferRef, byval OutModule as LLVMModuleRef ptr, byval OutMessage as zstring ptr ptr) as LLVMBool
declare function LLVMParseBitcodeInContext2(byval ContextRef as LLVMContextRef, byval MemBuf as LLVMMemoryBufferRef, byval OutModule as LLVMModuleRef ptr) as LLVMBool
declare function LLVMGetBitcodeModuleInContext(byval ContextRef as LLVMContextRef, byval MemBuf as LLVMMemoryBufferRef, byval OutM as LLVMModuleRef ptr, byval OutMessage as zstring ptr ptr) as LLVMBool
declare function LLVMGetBitcodeModuleInContext2(byval ContextRef as LLVMContextRef, byval MemBuf as LLVMMemoryBufferRef, byval OutM as LLVMModuleRef ptr) as LLVMBool
declare function LLVMGetBitcodeModule(byval MemBuf as LLVMMemoryBufferRef, byval OutM as LLVMModuleRef ptr, byval OutMessage as zstring ptr ptr) as LLVMBool
declare function LLVMGetBitcodeModule2(byval MemBuf as LLVMMemoryBufferRef, byval OutM as LLVMModuleRef ptr) as LLVMBool
#define LLVM_C_BITWRITER_H
declare function LLVMWriteBitcodeToFile(byval M as LLVMModuleRef, byval Path as const zstring ptr) as long
declare function LLVMWriteBitcodeToFD(byval M as LLVMModuleRef, byval FD as long, byval ShouldClose as long, byval Unbuffered as long) as long
declare function LLVMWriteBitcodeToFileHandle(byval M as LLVMModuleRef, byval Handle as long) as long
declare function LLVMWriteBitcodeToMemoryBuffer(byval M as LLVMModuleRef) as LLVMMemoryBufferRef
#define LLVM_C_CORE_H
#define LLVM_C_ERROR_HANDLING_H
type LLVMFatalErrorHandler as sub(byval Reason as const zstring ptr)
declare sub LLVMInstallFatalErrorHandler(byval Handler as LLVMFatalErrorHandler)
declare sub LLVMResetFatalErrorHandler()
declare sub LLVMEnablePrettyStackTrace()

type LLVMOpcode as long
enum
	LLVMRet = 1
	LLVMBr = 2
	LLVMSwitch = 3
	LLVMIndirectBr = 4
	LLVMInvoke = 5
	LLVMUnreachable = 7
	LLVMAdd = 8
	LLVMFAdd = 9
	LLVMSub = 10
	LLVMFSub = 11
	LLVMMul = 12
	LLVMFMul = 13
	LLVMUDiv = 14
	LLVMSDiv = 15
	LLVMFDiv = 16
	LLVMURem = 17
	LLVMSRem = 18
	LLVMFRem = 19
	LLVMShl = 20
	LLVMLShr = 21
	LLVMAShr = 22
	LLVMAnd = 23
	LLVMOr = 24
	LLVMXor = 25
	LLVMAlloca = 26
	LLVMLoad = 27
	LLVMStore = 28
	LLVMGetElementPtr = 29
	LLVMTrunc = 30
	LLVMZExt = 31
	LLVMSExt = 32
	LLVMFPToUI = 33
	LLVMFPToSI = 34
	LLVMUIToFP = 35
	LLVMSIToFP = 36
	LLVMFPTrunc = 37
	LLVMFPExt = 38
	LLVMPtrToInt = 39
	LLVMIntToPtr = 40
	LLVMBitCast = 41
	LLVMAddrSpaceCast = 60
	LLVMICmp = 42
	LLVMFCmp = 43
	LLVMPHI = 44
	LLVMCall = 45
	LLVMSelect = 46
	LLVMUserOp1 = 47
	LLVMUserOp2 = 48
	LLVMVAArg = 49
	LLVMExtractElement = 50
	LLVMInsertElement = 51
	LLVMShuffleVector = 52
	LLVMExtractValue = 53
	LLVMInsertValue = 54
	LLVMFence = 55
	LLVMAtomicCmpXchg = 56
	LLVMAtomicRMW = 57
	LLVMResume = 58
	LLVMLandingPad = 59
	LLVMCleanupRet = 61
	LLVMCatchRet = 62
	LLVMCatchPad = 63
	LLVMCleanupPad = 64
	LLVMCatchSwitch = 65
end enum

type LLVMTypeKind as long
enum
	LLVMVoidTypeKind
	LLVMHalfTypeKind
	LLVMFloatTypeKind
	LLVMDoubleTypeKind
	LLVMX86_FP80TypeKind
	LLVMFP128TypeKind
	LLVMPPC_FP128TypeKind
	LLVMLabelTypeKind
	LLVMIntegerTypeKind
	LLVMFunctionTypeKind
	LLVMStructTypeKind
	LLVMArrayTypeKind
	LLVMPointerTypeKind
	LLVMVectorTypeKind
	LLVMMetadataTypeKind
	LLVMX86_MMXTypeKind
	LLVMTokenTypeKind
end enum

type LLVMLinkage as long
enum
	LLVMExternalLinkage
	LLVMAvailableExternallyLinkage
	LLVMLinkOnceAnyLinkage
	LLVMLinkOnceODRLinkage
	LLVMLinkOnceODRAutoHideLinkage
	LLVMWeakAnyLinkage
	LLVMWeakODRLinkage
	LLVMAppendingLinkage
	LLVMInternalLinkage
	LLVMPrivateLinkage
	LLVMDLLImportLinkage
	LLVMDLLExportLinkage
	LLVMExternalWeakLinkage
	LLVMGhostLinkage
	LLVMCommonLinkage
	LLVMLinkerPrivateLinkage
	LLVMLinkerPrivateWeakLinkage
end enum

type LLVMVisibility as long
enum
	LLVMDefaultVisibility
	LLVMHiddenVisibility
	LLVMProtectedVisibility
end enum

type LLVMDLLStorageClass as long
enum
	LLVMDefaultStorageClass = 0
	LLVMDLLImportStorageClass = 1
	LLVMDLLExportStorageClass = 2
end enum

type LLVMCallConv as long
enum
	LLVMCCallConv = 0
	LLVMFastCallConv = 8
	LLVMColdCallConv = 9
	LLVMWebKitJSCallConv = 12
	LLVMAnyRegCallConv = 13
	LLVMX86StdcallCallConv = 64
	LLVMX86FastcallCallConv = 65
end enum

type LLVMValueKind as long
enum
	LLVMArgumentValueKind
	LLVMBasicBlockValueKind
	LLVMMemoryUseValueKind
	LLVMMemoryDefValueKind
	LLVMMemoryPhiValueKind
	LLVMFunctionValueKind
	LLVMGlobalAliasValueKind
	LLVMGlobalIFuncValueKind
	LLVMGlobalVariableValueKind
	LLVMBlockAddressValueKind
	LLVMConstantExprValueKind
	LLVMConstantArrayValueKind
	LLVMConstantStructValueKind
	LLVMConstantVectorValueKind
	LLVMUndefValueValueKind
	LLVMConstantAggregateZeroValueKind
	LLVMConstantDataArrayValueKind
	LLVMConstantDataVectorValueKind
	LLVMConstantIntValueKind
	LLVMConstantFPValueKind
	LLVMConstantPointerNullValueKind
	LLVMConstantTokenNoneValueKind
	LLVMMetadataAsValueValueKind
	LLVMInlineAsmValueKind
	LLVMInstructionValueKind
end enum

type LLVMIntPredicate as long
enum
	LLVMIntEQ = 32
	LLVMIntNE
	LLVMIntUGT
	LLVMIntUGE
	LLVMIntULT
	LLVMIntULE
	LLVMIntSGT
	LLVMIntSGE
	LLVMIntSLT
	LLVMIntSLE
end enum

type LLVMRealPredicate as long
enum
	LLVMRealPredicateFalse
	LLVMRealOEQ
	LLVMRealOGT
	LLVMRealOGE
	LLVMRealOLT
	LLVMRealOLE
	LLVMRealONE
	LLVMRealORD
	LLVMRealUNO
	LLVMRealUEQ
	LLVMRealUGT
	LLVMRealUGE
	LLVMRealULT
	LLVMRealULE
	LLVMRealUNE
	LLVMRealPredicateTrue
end enum

type LLVMLandingPadClauseTy as long
enum
	LLVMLandingPadCatch
	LLVMLandingPadFilter
end enum

type LLVMThreadLocalMode as long
enum
	LLVMNotThreadLocal = 0
	LLVMGeneralDynamicTLSModel
	LLVMLocalDynamicTLSModel
	LLVMInitialExecTLSModel
	LLVMLocalExecTLSModel
end enum

type LLVMAtomicOrdering as long
enum
	LLVMAtomicOrderingNotAtomic = 0
	LLVMAtomicOrderingUnordered = 1
	LLVMAtomicOrderingMonotonic = 2
	LLVMAtomicOrderingAcquire = 4
	LLVMAtomicOrderingRelease = 5
	LLVMAtomicOrderingAcquireRelease = 6
	LLVMAtomicOrderingSequentiallyConsistent = 7
end enum

type LLVMAtomicRMWBinOp as long
enum
	LLVMAtomicRMWBinOpXchg
	LLVMAtomicRMWBinOpAdd
	LLVMAtomicRMWBinOpSub
	LLVMAtomicRMWBinOpAnd
	LLVMAtomicRMWBinOpNand
	LLVMAtomicRMWBinOpOr
	LLVMAtomicRMWBinOpXor
	LLVMAtomicRMWBinOpMax
	LLVMAtomicRMWBinOpMin
	LLVMAtomicRMWBinOpUMax
	LLVMAtomicRMWBinOpUMin
end enum

type LLVMDiagnosticSeverity as long
enum
	LLVMDSError
	LLVMDSWarning
	LLVMDSRemark
	LLVMDSNote
end enum

enum
	LLVMAttributeReturnIndex = 0u
	LLVMAttributeFunctionIndex = -1
end enum

type LLVMAttributeIndex as ulong
declare sub LLVMShutdown()
declare function LLVMCreateMessage(byval Message as const zstring ptr) as zstring ptr
declare sub LLVMDisposeMessage(byval Message as zstring ptr)
type LLVMDiagnosticHandler as sub(byval as LLVMDiagnosticInfoRef, byval as any ptr)
type LLVMYieldCallback as sub(byval as LLVMContextRef, byval as any ptr)
declare function LLVMContextCreate() as LLVMContextRef
declare function LLVMGetGlobalContext() as LLVMContextRef
declare sub LLVMContextSetDiagnosticHandler(byval C as LLVMContextRef, byval Handler as LLVMDiagnosticHandler, byval DiagnosticContext as any ptr)
declare function LLVMContextGetDiagnosticHandler(byval C as LLVMContextRef) as LLVMDiagnosticHandler
declare function LLVMContextGetDiagnosticContext(byval C as LLVMContextRef) as any ptr
declare sub LLVMContextSetYieldCallback(byval C as LLVMContextRef, byval Callback as LLVMYieldCallback, byval OpaqueHandle as any ptr)
declare sub LLVMContextDispose(byval C as LLVMContextRef)
declare function LLVMGetDiagInfoDescription(byval DI as LLVMDiagnosticInfoRef) as zstring ptr
declare function LLVMGetDiagInfoSeverity(byval DI as LLVMDiagnosticInfoRef) as LLVMDiagnosticSeverity
declare function LLVMGetMDKindIDInContext(byval C as LLVMContextRef, byval Name as const zstring ptr, byval SLen as ulong) as ulong
declare function LLVMGetMDKindID(byval Name as const zstring ptr, byval SLen as ulong) as ulong
declare function LLVMGetEnumAttributeKindForName(byval Name as const zstring ptr, byval SLen as uinteger) as ulong
declare function LLVMGetLastEnumAttributeKind() as ulong
declare function LLVMCreateEnumAttribute(byval C as LLVMContextRef, byval KindID as ulong, byval Val as ulongint) as LLVMAttributeRef
declare function LLVMGetEnumAttributeKind(byval A as LLVMAttributeRef) as ulong
declare function LLVMGetEnumAttributeValue(byval A as LLVMAttributeRef) as ulongint
declare function LLVMCreateStringAttribute(byval C as LLVMContextRef, byval K as const zstring ptr, byval KLength as ulong, byval V as const zstring ptr, byval VLength as ulong) as LLVMAttributeRef
declare function LLVMGetStringAttributeKind(byval A as LLVMAttributeRef, byval Length as ulong ptr) as const zstring ptr
declare function LLVMGetStringAttributeValue(byval A as LLVMAttributeRef, byval Length as ulong ptr) as const zstring ptr
declare function LLVMIsEnumAttribute(byval A as LLVMAttributeRef) as LLVMBool
declare function LLVMIsStringAttribute(byval A as LLVMAttributeRef) as LLVMBool
declare function LLVMModuleCreateWithName(byval ModuleID as const zstring ptr) as LLVMModuleRef
declare function LLVMModuleCreateWithNameInContext(byval ModuleID as const zstring ptr, byval C as LLVMContextRef) as LLVMModuleRef
declare function LLVMCloneModule(byval M as LLVMModuleRef) as LLVMModuleRef
declare sub LLVMDisposeModule(byval M as LLVMModuleRef)
declare function LLVMGetModuleIdentifier(byval M as LLVMModuleRef, byval Len as uinteger ptr) as const zstring ptr
declare sub LLVMSetModuleIdentifier(byval M as LLVMModuleRef, byval Ident as const zstring ptr, byval Len as uinteger)
declare function LLVMGetDataLayoutStr(byval M as LLVMModuleRef) as const zstring ptr
declare function LLVMGetDataLayout(byval M as LLVMModuleRef) as const zstring ptr
declare sub LLVMSetDataLayout(byval M as LLVMModuleRef, byval DataLayoutStr as const zstring ptr)
declare function LLVMGetTarget(byval M as LLVMModuleRef) as const zstring ptr
declare sub LLVMSetTarget(byval M as LLVMModuleRef, byval Triple as const zstring ptr)
declare sub LLVMDumpModule(byval M as LLVMModuleRef)
declare function LLVMPrintModuleToFile(byval M as LLVMModuleRef, byval Filename as const zstring ptr, byval ErrorMessage as zstring ptr ptr) as LLVMBool
declare function LLVMPrintModuleToString(byval M as LLVMModuleRef) as zstring ptr
declare sub LLVMSetModuleInlineAsm(byval M as LLVMModuleRef, byval Asm as const zstring ptr)
declare function LLVMGetModuleContext(byval M as LLVMModuleRef) as LLVMContextRef
declare function LLVMGetTypeByName(byval M as LLVMModuleRef, byval Name as const zstring ptr) as LLVMTypeRef
declare function LLVMGetNamedMetadataNumOperands(byval M as LLVMModuleRef, byval Name as const zstring ptr) as ulong
declare sub LLVMGetNamedMetadataOperands(byval M as LLVMModuleRef, byval Name as const zstring ptr, byval Dest as LLVMValueRef ptr)
declare sub LLVMAddNamedMetadataOperand(byval M as LLVMModuleRef, byval Name as const zstring ptr, byval Val as LLVMValueRef)
declare function LLVMAddFunction(byval M as LLVMModuleRef, byval Name as const zstring ptr, byval FunctionTy as LLVMTypeRef) as LLVMValueRef
declare function LLVMGetNamedFunction(byval M as LLVMModuleRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMGetFirstFunction(byval M as LLVMModuleRef) as LLVMValueRef
declare function LLVMGetLastFunction(byval M as LLVMModuleRef) as LLVMValueRef
declare function LLVMGetNextFunction(byval Fn as LLVMValueRef) as LLVMValueRef
declare function LLVMGetPreviousFunction(byval Fn as LLVMValueRef) as LLVMValueRef
declare function LLVMGetTypeKind(byval Ty as LLVMTypeRef) as LLVMTypeKind
declare function LLVMTypeIsSized(byval Ty as LLVMTypeRef) as LLVMBool
declare function LLVMGetTypeContext(byval Ty as LLVMTypeRef) as LLVMContextRef
declare sub LLVMDumpType(byval Val as LLVMTypeRef)
declare function LLVMPrintTypeToString(byval Val as LLVMTypeRef) as zstring ptr
declare function LLVMInt1TypeInContext(byval C as LLVMContextRef) as LLVMTypeRef
declare function LLVMInt8TypeInContext(byval C as LLVMContextRef) as LLVMTypeRef
declare function LLVMInt16TypeInContext(byval C as LLVMContextRef) as LLVMTypeRef
declare function LLVMInt32TypeInContext(byval C as LLVMContextRef) as LLVMTypeRef
declare function LLVMInt64TypeInContext(byval C as LLVMContextRef) as LLVMTypeRef
declare function LLVMInt128TypeInContext(byval C as LLVMContextRef) as LLVMTypeRef
declare function LLVMIntTypeInContext(byval C as LLVMContextRef, byval NumBits as ulong) as LLVMTypeRef
declare function LLVMInt1Type() as LLVMTypeRef
declare function LLVMInt8Type() as LLVMTypeRef
declare function LLVMInt16Type() as LLVMTypeRef
declare function LLVMInt32Type() as LLVMTypeRef
declare function LLVMInt64Type() as LLVMTypeRef
declare function LLVMInt128Type() as LLVMTypeRef
declare function LLVMIntType(byval NumBits as ulong) as LLVMTypeRef
declare function LLVMGetIntTypeWidth(byval IntegerTy as LLVMTypeRef) as ulong
declare function LLVMHalfTypeInContext(byval C as LLVMContextRef) as LLVMTypeRef
declare function LLVMFloatTypeInContext(byval C as LLVMContextRef) as LLVMTypeRef
declare function LLVMDoubleTypeInContext(byval C as LLVMContextRef) as LLVMTypeRef
declare function LLVMX86FP80TypeInContext(byval C as LLVMContextRef) as LLVMTypeRef
declare function LLVMFP128TypeInContext(byval C as LLVMContextRef) as LLVMTypeRef
declare function LLVMPPCFP128TypeInContext(byval C as LLVMContextRef) as LLVMTypeRef
declare function LLVMHalfType() as LLVMTypeRef
declare function LLVMFloatType() as LLVMTypeRef
declare function LLVMDoubleType() as LLVMTypeRef
declare function LLVMX86FP80Type() as LLVMTypeRef
declare function LLVMFP128Type() as LLVMTypeRef
declare function LLVMPPCFP128Type() as LLVMTypeRef
declare function LLVMFunctionType(byval ReturnType as LLVMTypeRef, byval ParamTypes as LLVMTypeRef ptr, byval ParamCount as ulong, byval IsVarArg as LLVMBool) as LLVMTypeRef
declare function LLVMIsFunctionVarArg(byval FunctionTy as LLVMTypeRef) as LLVMBool
declare function LLVMGetReturnType(byval FunctionTy as LLVMTypeRef) as LLVMTypeRef
declare function LLVMCountParamTypes(byval FunctionTy as LLVMTypeRef) as ulong
declare sub LLVMGetParamTypes(byval FunctionTy as LLVMTypeRef, byval Dest as LLVMTypeRef ptr)
declare function LLVMStructTypeInContext(byval C as LLVMContextRef, byval ElementTypes as LLVMTypeRef ptr, byval ElementCount as ulong, byval Packed as LLVMBool) as LLVMTypeRef
declare function LLVMStructType(byval ElementTypes as LLVMTypeRef ptr, byval ElementCount as ulong, byval Packed as LLVMBool) as LLVMTypeRef
declare function LLVMStructCreateNamed(byval C as LLVMContextRef, byval Name as const zstring ptr) as LLVMTypeRef
declare function LLVMGetStructName(byval Ty as LLVMTypeRef) as const zstring ptr
declare sub LLVMStructSetBody(byval StructTy as LLVMTypeRef, byval ElementTypes as LLVMTypeRef ptr, byval ElementCount as ulong, byval Packed as LLVMBool)
declare function LLVMCountStructElementTypes(byval StructTy as LLVMTypeRef) as ulong
declare sub LLVMGetStructElementTypes(byval StructTy as LLVMTypeRef, byval Dest as LLVMTypeRef ptr)
declare function LLVMStructGetTypeAtIndex(byval StructTy as LLVMTypeRef, byval i as ulong) as LLVMTypeRef
declare function LLVMIsPackedStruct(byval StructTy as LLVMTypeRef) as LLVMBool
declare function LLVMIsOpaqueStruct(byval StructTy as LLVMTypeRef) as LLVMBool
declare function LLVMGetElementType(byval Ty as LLVMTypeRef) as LLVMTypeRef
declare sub LLVMGetSubtypes(byval Tp as LLVMTypeRef, byval Arr as LLVMTypeRef ptr)
declare function LLVMGetNumContainedTypes(byval Tp as LLVMTypeRef) as ulong
declare function LLVMArrayType(byval ElementType as LLVMTypeRef, byval ElementCount as ulong) as LLVMTypeRef
declare function LLVMGetArrayLength(byval ArrayTy as LLVMTypeRef) as ulong
declare function LLVMPointerType(byval ElementType as LLVMTypeRef, byval AddressSpace as ulong) as LLVMTypeRef
declare function LLVMGetPointerAddressSpace(byval PointerTy as LLVMTypeRef) as ulong
declare function LLVMVectorType(byval ElementType as LLVMTypeRef, byval ElementCount as ulong) as LLVMTypeRef
declare function LLVMGetVectorSize(byval VectorTy as LLVMTypeRef) as ulong
declare function LLVMVoidTypeInContext(byval C as LLVMContextRef) as LLVMTypeRef
declare function LLVMLabelTypeInContext(byval C as LLVMContextRef) as LLVMTypeRef
declare function LLVMX86MMXTypeInContext(byval C as LLVMContextRef) as LLVMTypeRef
declare function LLVMVoidType() as LLVMTypeRef
declare function LLVMLabelType() as LLVMTypeRef
declare function LLVMX86MMXType() as LLVMTypeRef
declare function LLVMTypeOf(byval Val as LLVMValueRef) as LLVMTypeRef
declare function LLVMGetValueKind(byval Val as LLVMValueRef) as LLVMValueKind
declare function LLVMGetValueName(byval Val as LLVMValueRef) as const zstring ptr
declare sub LLVMSetValueName(byval Val as LLVMValueRef, byval Name as const zstring ptr)
declare sub LLVMDumpValue(byval Val as LLVMValueRef)
declare function LLVMPrintValueToString(byval Val as LLVMValueRef) as zstring ptr
declare sub LLVMReplaceAllUsesWith(byval OldVal as LLVMValueRef, byval NewVal as LLVMValueRef)
declare function LLVMIsConstant(byval Val as LLVMValueRef) as LLVMBool
declare function LLVMIsUndef(byval Val as LLVMValueRef) as LLVMBool
declare function LLVMIsAArgument(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsABasicBlock(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAInlineAsm(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAUser(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAConstant(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsABlockAddress(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAConstantAggregateZero(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAConstantArray(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAConstantDataSequential(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAConstantDataArray(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAConstantDataVector(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAConstantExpr(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAConstantFP(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAConstantInt(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAConstantPointerNull(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAConstantStruct(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAConstantTokenNone(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAConstantVector(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAGlobalValue(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAGlobalAlias(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAGlobalObject(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAFunction(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAGlobalVariable(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAUndefValue(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAInstruction(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsABinaryOperator(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsACallInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAIntrinsicInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsADbgInfoIntrinsic(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsADbgDeclareInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAMemIntrinsic(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAMemCpyInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAMemMoveInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAMemSetInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsACmpInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAFCmpInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAICmpInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAExtractElementInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAGetElementPtrInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAInsertElementInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAInsertValueInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsALandingPadInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAPHINode(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsASelectInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAShuffleVectorInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAStoreInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsATerminatorInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsABranchInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAIndirectBrInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAInvokeInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAReturnInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsASwitchInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAUnreachableInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAResumeInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsACleanupReturnInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsACatchReturnInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAFuncletPadInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsACatchPadInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsACleanupPadInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAUnaryInstruction(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAAllocaInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsACastInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAAddrSpaceCastInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsABitCastInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAFPExtInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAFPToSIInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAFPToUIInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAFPTruncInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAIntToPtrInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAPtrToIntInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsASExtInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsASIToFPInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsATruncInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAUIToFPInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAZExtInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAExtractValueInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsALoadInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAVAArgInst(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAMDNode(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAMDString(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMGetFirstUse(byval Val as LLVMValueRef) as LLVMUseRef
declare function LLVMGetNextUse(byval U as LLVMUseRef) as LLVMUseRef
declare function LLVMGetUser(byval U as LLVMUseRef) as LLVMValueRef
declare function LLVMGetUsedValue(byval U as LLVMUseRef) as LLVMValueRef
declare function LLVMGetOperand(byval Val as LLVMValueRef, byval Index as ulong) as LLVMValueRef
declare function LLVMGetOperandUse(byval Val as LLVMValueRef, byval Index as ulong) as LLVMUseRef
declare sub LLVMSetOperand(byval User as LLVMValueRef, byval Index as ulong, byval Val as LLVMValueRef)
declare function LLVMGetNumOperands(byval Val as LLVMValueRef) as long
declare function LLVMConstNull(byval Ty as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstAllOnes(byval Ty as LLVMTypeRef) as LLVMValueRef
declare function LLVMGetUndef(byval Ty as LLVMTypeRef) as LLVMValueRef
declare function LLVMIsNull(byval Val as LLVMValueRef) as LLVMBool
declare function LLVMConstPointerNull(byval Ty as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstInt(byval IntTy as LLVMTypeRef, byval N as ulongint, byval SignExtend as LLVMBool) as LLVMValueRef
declare function LLVMConstIntOfArbitraryPrecision(byval IntTy as LLVMTypeRef, byval NumWords as ulong, byval Words as const ulongint ptr) as LLVMValueRef
declare function LLVMConstIntOfString(byval IntTy as LLVMTypeRef, byval Text as const zstring ptr, byval Radix as ubyte) as LLVMValueRef
declare function LLVMConstIntOfStringAndSize(byval IntTy as LLVMTypeRef, byval Text as const zstring ptr, byval SLen as ulong, byval Radix as ubyte) as LLVMValueRef
declare function LLVMConstReal(byval RealTy as LLVMTypeRef, byval N as double) as LLVMValueRef
declare function LLVMConstRealOfString(byval RealTy as LLVMTypeRef, byval Text as const zstring ptr) as LLVMValueRef
declare function LLVMConstRealOfStringAndSize(byval RealTy as LLVMTypeRef, byval Text as const zstring ptr, byval SLen as ulong) as LLVMValueRef
declare function LLVMConstIntGetZExtValue(byval ConstantVal as LLVMValueRef) as ulongint
declare function LLVMConstIntGetSExtValue(byval ConstantVal as LLVMValueRef) as longint
declare function LLVMConstRealGetDouble(byval ConstantVal as LLVMValueRef, byval losesInfo as LLVMBool ptr) as double
declare function LLVMConstStringInContext(byval C as LLVMContextRef, byval Str as const zstring ptr, byval Length as ulong, byval DontNullTerminate as LLVMBool) as LLVMValueRef
declare function LLVMConstString(byval Str as const zstring ptr, byval Length as ulong, byval DontNullTerminate as LLVMBool) as LLVMValueRef
declare function LLVMIsConstantString(byval c as LLVMValueRef) as LLVMBool
declare function LLVMGetAsString(byval c as LLVMValueRef, byval Length as uinteger ptr) as const zstring ptr
declare function LLVMConstStructInContext(byval C as LLVMContextRef, byval ConstantVals as LLVMValueRef ptr, byval Count as ulong, byval Packed as LLVMBool) as LLVMValueRef
declare function LLVMConstStruct(byval ConstantVals as LLVMValueRef ptr, byval Count as ulong, byval Packed as LLVMBool) as LLVMValueRef
declare function LLVMConstArray(byval ElementTy as LLVMTypeRef, byval ConstantVals as LLVMValueRef ptr, byval Length as ulong) as LLVMValueRef
declare function LLVMConstNamedStruct(byval StructTy as LLVMTypeRef, byval ConstantVals as LLVMValueRef ptr, byval Count as ulong) as LLVMValueRef
declare function LLVMGetElementAsConstant(byval C as LLVMValueRef, byval idx as ulong) as LLVMValueRef
declare function LLVMConstVector(byval ScalarConstantVals as LLVMValueRef ptr, byval Size as ulong) as LLVMValueRef
declare function LLVMGetConstOpcode(byval ConstantVal as LLVMValueRef) as LLVMOpcode
declare function LLVMAlignOf(byval Ty as LLVMTypeRef) as LLVMValueRef
declare function LLVMSizeOf(byval Ty as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstNeg(byval ConstantVal as LLVMValueRef) as LLVMValueRef
declare function LLVMConstNSWNeg(byval ConstantVal as LLVMValueRef) as LLVMValueRef
declare function LLVMConstNUWNeg(byval ConstantVal as LLVMValueRef) as LLVMValueRef
declare function LLVMConstFNeg(byval ConstantVal as LLVMValueRef) as LLVMValueRef
declare function LLVMConstNot(byval ConstantVal as LLVMValueRef) as LLVMValueRef
declare function LLVMConstAdd(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstNSWAdd(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstNUWAdd(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstFAdd(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstSub(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstNSWSub(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstNUWSub(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstFSub(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstMul(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstNSWMul(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstNUWMul(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstFMul(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstUDiv(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstExactUDiv(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstSDiv(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstExactSDiv(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstFDiv(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstURem(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstSRem(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstFRem(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstAnd(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstOr(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstXor(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstICmp(byval Predicate as LLVMIntPredicate, byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstFCmp(byval Predicate as LLVMRealPredicate, byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstShl(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstLShr(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstAShr(byval LHSConstant as LLVMValueRef, byval RHSConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstGEP(byval ConstantVal as LLVMValueRef, byval ConstantIndices as LLVMValueRef ptr, byval NumIndices as ulong) as LLVMValueRef
declare function LLVMConstInBoundsGEP(byval ConstantVal as LLVMValueRef, byval ConstantIndices as LLVMValueRef ptr, byval NumIndices as ulong) as LLVMValueRef
declare function LLVMConstTrunc(byval ConstantVal as LLVMValueRef, byval ToType as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstSExt(byval ConstantVal as LLVMValueRef, byval ToType as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstZExt(byval ConstantVal as LLVMValueRef, byval ToType as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstFPTrunc(byval ConstantVal as LLVMValueRef, byval ToType as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstFPExt(byval ConstantVal as LLVMValueRef, byval ToType as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstUIToFP(byval ConstantVal as LLVMValueRef, byval ToType as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstSIToFP(byval ConstantVal as LLVMValueRef, byval ToType as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstFPToUI(byval ConstantVal as LLVMValueRef, byval ToType as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstFPToSI(byval ConstantVal as LLVMValueRef, byval ToType as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstPtrToInt(byval ConstantVal as LLVMValueRef, byval ToType as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstIntToPtr(byval ConstantVal as LLVMValueRef, byval ToType as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstBitCast(byval ConstantVal as LLVMValueRef, byval ToType as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstAddrSpaceCast(byval ConstantVal as LLVMValueRef, byval ToType as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstZExtOrBitCast(byval ConstantVal as LLVMValueRef, byval ToType as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstSExtOrBitCast(byval ConstantVal as LLVMValueRef, byval ToType as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstTruncOrBitCast(byval ConstantVal as LLVMValueRef, byval ToType as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstPointerCast(byval ConstantVal as LLVMValueRef, byval ToType as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstIntCast(byval ConstantVal as LLVMValueRef, byval ToType as LLVMTypeRef, byval isSigned as LLVMBool) as LLVMValueRef
declare function LLVMConstFPCast(byval ConstantVal as LLVMValueRef, byval ToType as LLVMTypeRef) as LLVMValueRef
declare function LLVMConstSelect(byval ConstantCondition as LLVMValueRef, byval ConstantIfTrue as LLVMValueRef, byval ConstantIfFalse as LLVMValueRef) as LLVMValueRef
declare function LLVMConstExtractElement(byval VectorConstant as LLVMValueRef, byval IndexConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstInsertElement(byval VectorConstant as LLVMValueRef, byval ElementValueConstant as LLVMValueRef, byval IndexConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstShuffleVector(byval VectorAConstant as LLVMValueRef, byval VectorBConstant as LLVMValueRef, byval MaskConstant as LLVMValueRef) as LLVMValueRef
declare function LLVMConstExtractValue(byval AggConstant as LLVMValueRef, byval IdxList as ulong ptr, byval NumIdx as ulong) as LLVMValueRef
declare function LLVMConstInsertValue(byval AggConstant as LLVMValueRef, byval ElementValueConstant as LLVMValueRef, byval IdxList as ulong ptr, byval NumIdx as ulong) as LLVMValueRef
declare function LLVMConstInlineAsm(byval Ty as LLVMTypeRef, byval AsmString as const zstring ptr, byval Constraints as const zstring ptr, byval HasSideEffects as LLVMBool, byval IsAlignStack as LLVMBool) as LLVMValueRef
declare function LLVMBlockAddress(byval F as LLVMValueRef, byval BB as LLVMBasicBlockRef) as LLVMValueRef
declare function LLVMGetGlobalParent(byval Global as LLVMValueRef) as LLVMModuleRef
declare function LLVMIsDeclaration(byval Global as LLVMValueRef) as LLVMBool
declare function LLVMGetLinkage(byval Global as LLVMValueRef) as LLVMLinkage
declare sub LLVMSetLinkage(byval Global as LLVMValueRef, byval Linkage as LLVMLinkage)
declare function LLVMGetSection(byval Global as LLVMValueRef) as const zstring ptr
declare sub LLVMSetSection(byval Global as LLVMValueRef, byval Section as const zstring ptr)
declare function LLVMGetVisibility(byval Global as LLVMValueRef) as LLVMVisibility
declare sub LLVMSetVisibility(byval Global as LLVMValueRef, byval Viz as LLVMVisibility)
declare function LLVMGetDLLStorageClass(byval Global as LLVMValueRef) as LLVMDLLStorageClass
declare sub LLVMSetDLLStorageClass(byval Global as LLVMValueRef, byval Class as LLVMDLLStorageClass)
declare function LLVMHasUnnamedAddr(byval Global as LLVMValueRef) as LLVMBool
declare sub LLVMSetUnnamedAddr(byval Global as LLVMValueRef, byval HasUnnamedAddr as LLVMBool)
declare function LLVMGetAlignment(byval V as LLVMValueRef) as ulong
declare sub LLVMSetAlignment(byval V as LLVMValueRef, byval Bytes as ulong)
declare function LLVMAddGlobal(byval M as LLVMModuleRef, byval Ty as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMAddGlobalInAddressSpace(byval M as LLVMModuleRef, byval Ty as LLVMTypeRef, byval Name as const zstring ptr, byval AddressSpace as ulong) as LLVMValueRef
declare function LLVMGetNamedGlobal(byval M as LLVMModuleRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMGetFirstGlobal(byval M as LLVMModuleRef) as LLVMValueRef
declare function LLVMGetLastGlobal(byval M as LLVMModuleRef) as LLVMValueRef
declare function LLVMGetNextGlobal(byval GlobalVar as LLVMValueRef) as LLVMValueRef
declare function LLVMGetPreviousGlobal(byval GlobalVar as LLVMValueRef) as LLVMValueRef
declare sub LLVMDeleteGlobal(byval GlobalVar as LLVMValueRef)
declare function LLVMGetInitializer(byval GlobalVar as LLVMValueRef) as LLVMValueRef
declare sub LLVMSetInitializer(byval GlobalVar as LLVMValueRef, byval ConstantVal as LLVMValueRef)
declare function LLVMIsThreadLocal(byval GlobalVar as LLVMValueRef) as LLVMBool
declare sub LLVMSetThreadLocal(byval GlobalVar as LLVMValueRef, byval IsThreadLocal as LLVMBool)
declare function LLVMIsGlobalConstant(byval GlobalVar as LLVMValueRef) as LLVMBool
declare sub LLVMSetGlobalConstant(byval GlobalVar as LLVMValueRef, byval IsConstant as LLVMBool)
declare function LLVMGetThreadLocalMode(byval GlobalVar as LLVMValueRef) as LLVMThreadLocalMode
declare sub LLVMSetThreadLocalMode(byval GlobalVar as LLVMValueRef, byval Mode as LLVMThreadLocalMode)
declare function LLVMIsExternallyInitialized(byval GlobalVar as LLVMValueRef) as LLVMBool
declare sub LLVMSetExternallyInitialized(byval GlobalVar as LLVMValueRef, byval IsExtInit as LLVMBool)
declare function LLVMAddAlias(byval M as LLVMModuleRef, byval Ty as LLVMTypeRef, byval Aliasee as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare sub LLVMDeleteFunction(byval Fn as LLVMValueRef)
declare function LLVMHasPersonalityFn(byval Fn as LLVMValueRef) as LLVMBool
declare function LLVMGetPersonalityFn(byval Fn as LLVMValueRef) as LLVMValueRef
declare sub LLVMSetPersonalityFn(byval Fn as LLVMValueRef, byval PersonalityFn as LLVMValueRef)
declare function LLVMGetIntrinsicID(byval Fn as LLVMValueRef) as ulong
declare function LLVMGetFunctionCallConv(byval Fn as LLVMValueRef) as ulong
declare sub LLVMSetFunctionCallConv(byval Fn as LLVMValueRef, byval CC as ulong)
declare function LLVMGetGC(byval Fn as LLVMValueRef) as const zstring ptr
declare sub LLVMSetGC(byval Fn as LLVMValueRef, byval Name as const zstring ptr)
declare sub LLVMAddAttributeAtIndex(byval F as LLVMValueRef, byval Idx as LLVMAttributeIndex, byval A as LLVMAttributeRef)
declare function LLVMGetAttributeCountAtIndex(byval F as LLVMValueRef, byval Idx as LLVMAttributeIndex) as ulong
declare sub LLVMGetAttributesAtIndex(byval F as LLVMValueRef, byval Idx as LLVMAttributeIndex, byval Attrs as LLVMAttributeRef ptr)
declare function LLVMGetEnumAttributeAtIndex(byval F as LLVMValueRef, byval Idx as LLVMAttributeIndex, byval KindID as ulong) as LLVMAttributeRef
declare function LLVMGetStringAttributeAtIndex(byval F as LLVMValueRef, byval Idx as LLVMAttributeIndex, byval K as const zstring ptr, byval KLen as ulong) as LLVMAttributeRef
declare sub LLVMRemoveEnumAttributeAtIndex(byval F as LLVMValueRef, byval Idx as LLVMAttributeIndex, byval KindID as ulong)
declare sub LLVMRemoveStringAttributeAtIndex(byval F as LLVMValueRef, byval Idx as LLVMAttributeIndex, byval K as const zstring ptr, byval KLen as ulong)
declare sub LLVMAddTargetDependentFunctionAttr(byval Fn as LLVMValueRef, byval A as const zstring ptr, byval V as const zstring ptr)
declare function LLVMCountParams(byval Fn as LLVMValueRef) as ulong
declare sub LLVMGetParams(byval Fn as LLVMValueRef, byval Params as LLVMValueRef ptr)
declare function LLVMGetParam(byval Fn as LLVMValueRef, byval Index as ulong) as LLVMValueRef
declare function LLVMGetParamParent(byval Inst as LLVMValueRef) as LLVMValueRef
declare function LLVMGetFirstParam(byval Fn as LLVMValueRef) as LLVMValueRef
declare function LLVMGetLastParam(byval Fn as LLVMValueRef) as LLVMValueRef
declare function LLVMGetNextParam(byval Arg as LLVMValueRef) as LLVMValueRef
declare function LLVMGetPreviousParam(byval Arg as LLVMValueRef) as LLVMValueRef
declare sub LLVMSetParamAlignment(byval Arg as LLVMValueRef, byval Align as ulong)
declare function LLVMMDStringInContext(byval C as LLVMContextRef, byval Str as const zstring ptr, byval SLen as ulong) as LLVMValueRef
declare function LLVMMDString(byval Str as const zstring ptr, byval SLen as ulong) as LLVMValueRef
declare function LLVMMDNodeInContext(byval C as LLVMContextRef, byval Vals as LLVMValueRef ptr, byval Count as ulong) as LLVMValueRef
declare function LLVMMDNode(byval Vals as LLVMValueRef ptr, byval Count as ulong) as LLVMValueRef
declare function LLVMMetadataAsValue(byval C as LLVMContextRef, byval MD as LLVMMetadataRef) as LLVMValueRef
declare function LLVMValueAsMetadata(byval Val as LLVMValueRef) as LLVMMetadataRef
declare function LLVMGetMDString(byval V as LLVMValueRef, byval Length as ulong ptr) as const zstring ptr
declare function LLVMGetMDNodeNumOperands(byval V as LLVMValueRef) as ulong
declare sub LLVMGetMDNodeOperands(byval V as LLVMValueRef, byval Dest as LLVMValueRef ptr)
declare function LLVMBasicBlockAsValue(byval BB as LLVMBasicBlockRef) as LLVMValueRef
declare function LLVMValueIsBasicBlock(byval Val as LLVMValueRef) as LLVMBool
declare function LLVMValueAsBasicBlock(byval Val as LLVMValueRef) as LLVMBasicBlockRef
declare function LLVMGetBasicBlockName(byval BB as LLVMBasicBlockRef) as const zstring ptr
declare function LLVMGetBasicBlockParent(byval BB as LLVMBasicBlockRef) as LLVMValueRef
declare function LLVMGetBasicBlockTerminator(byval BB as LLVMBasicBlockRef) as LLVMValueRef
declare function LLVMCountBasicBlocks(byval Fn as LLVMValueRef) as ulong
declare sub LLVMGetBasicBlocks(byval Fn as LLVMValueRef, byval BasicBlocks as LLVMBasicBlockRef ptr)
declare function LLVMGetFirstBasicBlock(byval Fn as LLVMValueRef) as LLVMBasicBlockRef
declare function LLVMGetLastBasicBlock(byval Fn as LLVMValueRef) as LLVMBasicBlockRef
declare function LLVMGetNextBasicBlock(byval BB as LLVMBasicBlockRef) as LLVMBasicBlockRef
declare function LLVMGetPreviousBasicBlock(byval BB as LLVMBasicBlockRef) as LLVMBasicBlockRef
declare function LLVMGetEntryBasicBlock(byval Fn as LLVMValueRef) as LLVMBasicBlockRef
declare function LLVMAppendBasicBlockInContext(byval C as LLVMContextRef, byval Fn as LLVMValueRef, byval Name as const zstring ptr) as LLVMBasicBlockRef
declare function LLVMAppendBasicBlock(byval Fn as LLVMValueRef, byval Name as const zstring ptr) as LLVMBasicBlockRef
declare function LLVMInsertBasicBlockInContext(byval C as LLVMContextRef, byval BB as LLVMBasicBlockRef, byval Name as const zstring ptr) as LLVMBasicBlockRef
declare function LLVMInsertBasicBlock(byval InsertBeforeBB as LLVMBasicBlockRef, byval Name as const zstring ptr) as LLVMBasicBlockRef
declare sub LLVMDeleteBasicBlock(byval BB as LLVMBasicBlockRef)
declare sub LLVMRemoveBasicBlockFromParent(byval BB as LLVMBasicBlockRef)
declare sub LLVMMoveBasicBlockBefore(byval BB as LLVMBasicBlockRef, byval MovePos as LLVMBasicBlockRef)
declare sub LLVMMoveBasicBlockAfter(byval BB as LLVMBasicBlockRef, byval MovePos as LLVMBasicBlockRef)
declare function LLVMGetFirstInstruction(byval BB as LLVMBasicBlockRef) as LLVMValueRef
declare function LLVMGetLastInstruction(byval BB as LLVMBasicBlockRef) as LLVMValueRef
declare function LLVMHasMetadata(byval Val as LLVMValueRef) as long
declare function LLVMGetMetadata(byval Val as LLVMValueRef, byval KindID as ulong) as LLVMValueRef
declare sub LLVMSetMetadata(byval Val as LLVMValueRef, byval KindID as ulong, byval Node as LLVMValueRef)
declare function LLVMGetInstructionParent(byval Inst as LLVMValueRef) as LLVMBasicBlockRef
declare function LLVMGetNextInstruction(byval Inst as LLVMValueRef) as LLVMValueRef
declare function LLVMGetPreviousInstruction(byval Inst as LLVMValueRef) as LLVMValueRef
declare sub LLVMInstructionRemoveFromParent(byval Inst as LLVMValueRef)
declare sub LLVMInstructionEraseFromParent(byval Inst as LLVMValueRef)
declare function LLVMGetInstructionOpcode(byval Inst as LLVMValueRef) as LLVMOpcode
declare function LLVMGetICmpPredicate(byval Inst as LLVMValueRef) as LLVMIntPredicate
declare function LLVMGetFCmpPredicate(byval Inst as LLVMValueRef) as LLVMRealPredicate
declare function LLVMInstructionClone(byval Inst as LLVMValueRef) as LLVMValueRef
declare function LLVMGetNumArgOperands(byval Instr as LLVMValueRef) as ulong
declare sub LLVMSetInstructionCallConv(byval Instr as LLVMValueRef, byval CC as ulong)
declare function LLVMGetInstructionCallConv(byval Instr as LLVMValueRef) as ulong
declare sub LLVMSetInstrParamAlignment(byval Instr as LLVMValueRef, byval index as ulong, byval Align as ulong)
declare sub LLVMAddCallSiteAttribute(byval C as LLVMValueRef, byval Idx as LLVMAttributeIndex, byval A as LLVMAttributeRef)
declare function LLVMGetCallSiteAttributeCount(byval C as LLVMValueRef, byval Idx as LLVMAttributeIndex) as ulong
declare sub LLVMGetCallSiteAttributes(byval C as LLVMValueRef, byval Idx as LLVMAttributeIndex, byval Attrs as LLVMAttributeRef ptr)
declare function LLVMGetCallSiteEnumAttribute(byval C as LLVMValueRef, byval Idx as LLVMAttributeIndex, byval KindID as ulong) as LLVMAttributeRef
declare function LLVMGetCallSiteStringAttribute(byval C as LLVMValueRef, byval Idx as LLVMAttributeIndex, byval K as const zstring ptr, byval KLen as ulong) as LLVMAttributeRef
declare sub LLVMRemoveCallSiteEnumAttribute(byval C as LLVMValueRef, byval Idx as LLVMAttributeIndex, byval KindID as ulong)
declare sub LLVMRemoveCallSiteStringAttribute(byval C as LLVMValueRef, byval Idx as LLVMAttributeIndex, byval K as const zstring ptr, byval KLen as ulong)
declare function LLVMGetCalledValue(byval Instr as LLVMValueRef) as LLVMValueRef
declare function LLVMIsTailCall(byval CallInst as LLVMValueRef) as LLVMBool
declare sub LLVMSetTailCall(byval CallInst as LLVMValueRef, byval IsTailCall as LLVMBool)
declare function LLVMGetNormalDest(byval InvokeInst as LLVMValueRef) as LLVMBasicBlockRef
declare function LLVMGetUnwindDest(byval InvokeInst as LLVMValueRef) as LLVMBasicBlockRef
declare sub LLVMSetNormalDest(byval InvokeInst as LLVMValueRef, byval B as LLVMBasicBlockRef)
declare sub LLVMSetUnwindDest(byval InvokeInst as LLVMValueRef, byval B as LLVMBasicBlockRef)
declare function LLVMGetNumSuccessors(byval Term as LLVMValueRef) as ulong
declare function LLVMGetSuccessor(byval Term as LLVMValueRef, byval i as ulong) as LLVMBasicBlockRef
declare sub LLVMSetSuccessor(byval Term as LLVMValueRef, byval i as ulong, byval block as LLVMBasicBlockRef)
declare function LLVMIsConditional(byval Branch as LLVMValueRef) as LLVMBool
declare function LLVMGetCondition(byval Branch as LLVMValueRef) as LLVMValueRef
declare sub LLVMSetCondition(byval Branch as LLVMValueRef, byval Cond as LLVMValueRef)
declare function LLVMGetSwitchDefaultDest(byval SwitchInstr as LLVMValueRef) as LLVMBasicBlockRef
declare function LLVMGetAllocatedType(byval Alloca as LLVMValueRef) as LLVMTypeRef
declare function LLVMIsInBounds(byval GEP as LLVMValueRef) as LLVMBool
declare sub LLVMSetIsInBounds(byval GEP as LLVMValueRef, byval InBounds as LLVMBool)
declare sub LLVMAddIncoming(byval PhiNode as LLVMValueRef, byval IncomingValues as LLVMValueRef ptr, byval IncomingBlocks as LLVMBasicBlockRef ptr, byval Count as ulong)
declare function LLVMCountIncoming(byval PhiNode as LLVMValueRef) as ulong
declare function LLVMGetIncomingValue(byval PhiNode as LLVMValueRef, byval Index as ulong) as LLVMValueRef
declare function LLVMGetIncomingBlock(byval PhiNode as LLVMValueRef, byval Index as ulong) as LLVMBasicBlockRef
declare function LLVMGetNumIndices(byval Inst as LLVMValueRef) as ulong
declare function LLVMGetIndices(byval Inst as LLVMValueRef) as const ulong ptr
declare function LLVMCreateBuilderInContext(byval C as LLVMContextRef) as LLVMBuilderRef
declare function LLVMCreateBuilder() as LLVMBuilderRef
declare sub LLVMPositionBuilder(byval Builder as LLVMBuilderRef, byval Block as LLVMBasicBlockRef, byval Instr as LLVMValueRef)
declare sub LLVMPositionBuilderBefore(byval Builder as LLVMBuilderRef, byval Instr as LLVMValueRef)
declare sub LLVMPositionBuilderAtEnd(byval Builder as LLVMBuilderRef, byval Block as LLVMBasicBlockRef)
declare function LLVMGetInsertBlock(byval Builder as LLVMBuilderRef) as LLVMBasicBlockRef
declare sub LLVMClearInsertionPosition(byval Builder as LLVMBuilderRef)
declare sub LLVMInsertIntoBuilder(byval Builder as LLVMBuilderRef, byval Instr as LLVMValueRef)
declare sub LLVMInsertIntoBuilderWithName(byval Builder as LLVMBuilderRef, byval Instr as LLVMValueRef, byval Name as const zstring ptr)
declare sub LLVMDisposeBuilder(byval Builder as LLVMBuilderRef)
declare sub LLVMSetCurrentDebugLocation(byval Builder as LLVMBuilderRef, byval L as LLVMValueRef)
declare function LLVMGetCurrentDebugLocation(byval Builder as LLVMBuilderRef) as LLVMValueRef
declare sub LLVMSetInstDebugLocation(byval Builder as LLVMBuilderRef, byval Inst as LLVMValueRef)
declare function LLVMBuildRetVoid(byval as LLVMBuilderRef) as LLVMValueRef
declare function LLVMBuildRet(byval as LLVMBuilderRef, byval V as LLVMValueRef) as LLVMValueRef
declare function LLVMBuildAggregateRet(byval as LLVMBuilderRef, byval RetVals as LLVMValueRef ptr, byval N as ulong) as LLVMValueRef
declare function LLVMBuildBr(byval as LLVMBuilderRef, byval Dest as LLVMBasicBlockRef) as LLVMValueRef
declare function LLVMBuildCondBr(byval as LLVMBuilderRef, byval If as LLVMValueRef, byval Then as LLVMBasicBlockRef, byval Else as LLVMBasicBlockRef) as LLVMValueRef
declare function LLVMBuildSwitch(byval as LLVMBuilderRef, byval V as LLVMValueRef, byval Else as LLVMBasicBlockRef, byval NumCases as ulong) as LLVMValueRef
declare function LLVMBuildIndirectBr(byval B as LLVMBuilderRef, byval Addr as LLVMValueRef, byval NumDests as ulong) as LLVMValueRef
declare function LLVMBuildInvoke(byval as LLVMBuilderRef, byval Fn as LLVMValueRef, byval Args as LLVMValueRef ptr, byval NumArgs as ulong, byval Then as LLVMBasicBlockRef, byval Catch as LLVMBasicBlockRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildLandingPad(byval B as LLVMBuilderRef, byval Ty as LLVMTypeRef, byval PersFn as LLVMValueRef, byval NumClauses as ulong, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildResume(byval B as LLVMBuilderRef, byval Exn as LLVMValueRef) as LLVMValueRef
declare function LLVMBuildUnreachable(byval as LLVMBuilderRef) as LLVMValueRef
declare sub LLVMAddCase(byval Switch as LLVMValueRef, byval OnVal as LLVMValueRef, byval Dest as LLVMBasicBlockRef)
declare sub LLVMAddDestination(byval IndirectBr as LLVMValueRef, byval Dest as LLVMBasicBlockRef)
declare function LLVMGetNumClauses(byval LandingPad as LLVMValueRef) as ulong
declare function LLVMGetClause(byval LandingPad as LLVMValueRef, byval Idx as ulong) as LLVMValueRef
declare sub LLVMAddClause(byval LandingPad as LLVMValueRef, byval ClauseVal as LLVMValueRef)
declare function LLVMIsCleanup(byval LandingPad as LLVMValueRef) as LLVMBool
declare sub LLVMSetCleanup(byval LandingPad as LLVMValueRef, byval Val as LLVMBool)
declare function LLVMBuildAdd(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildNSWAdd(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildNUWAdd(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildFAdd(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildSub(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildNSWSub(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildNUWSub(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildFSub(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildMul(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildNSWMul(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildNUWMul(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildFMul(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildUDiv(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildExactUDiv(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildSDiv(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildExactSDiv(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildFDiv(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildURem(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildSRem(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildFRem(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildShl(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildLShr(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildAShr(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildAnd(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildOr(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildXor(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildBinOp(byval B as LLVMBuilderRef, byval Op as LLVMOpcode, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildNeg(byval as LLVMBuilderRef, byval V as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildNSWNeg(byval B as LLVMBuilderRef, byval V as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildNUWNeg(byval B as LLVMBuilderRef, byval V as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildFNeg(byval as LLVMBuilderRef, byval V as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildNot(byval as LLVMBuilderRef, byval V as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildMalloc(byval as LLVMBuilderRef, byval Ty as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildArrayMalloc(byval as LLVMBuilderRef, byval Ty as LLVMTypeRef, byval Val as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildAlloca(byval as LLVMBuilderRef, byval Ty as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildArrayAlloca(byval as LLVMBuilderRef, byval Ty as LLVMTypeRef, byval Val as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildFree(byval as LLVMBuilderRef, byval PointerVal as LLVMValueRef) as LLVMValueRef
declare function LLVMBuildLoad(byval as LLVMBuilderRef, byval PointerVal as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildStore(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval Ptr_ as LLVMValueRef) as LLVMValueRef
declare function LLVMBuildGEP(byval B as LLVMBuilderRef, byval Pointer as LLVMValueRef, byval Indices as LLVMValueRef ptr, byval NumIndices as ulong, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildInBoundsGEP(byval B as LLVMBuilderRef, byval Pointer as LLVMValueRef, byval Indices as LLVMValueRef ptr, byval NumIndices as ulong, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildStructGEP(byval B as LLVMBuilderRef, byval Pointer as LLVMValueRef, byval Idx as ulong, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildGlobalString(byval B as LLVMBuilderRef, byval Str as const zstring ptr, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildGlobalStringPtr(byval B as LLVMBuilderRef, byval Str as const zstring ptr, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMGetVolatile(byval MemoryAccessInst as LLVMValueRef) as LLVMBool
declare sub LLVMSetVolatile(byval MemoryAccessInst as LLVMValueRef, byval IsVolatile as LLVMBool)
declare function LLVMGetOrdering(byval MemoryAccessInst as LLVMValueRef) as LLVMAtomicOrdering
declare sub LLVMSetOrdering(byval MemoryAccessInst as LLVMValueRef, byval Ordering as LLVMAtomicOrdering)
declare function LLVMBuildTrunc(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildZExt(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildSExt(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildFPToUI(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildFPToSI(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildUIToFP(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildSIToFP(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildFPTrunc(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildFPExt(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildPtrToInt(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildIntToPtr(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildBitCast(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildAddrSpaceCast(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildZExtOrBitCast(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildSExtOrBitCast(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildTruncOrBitCast(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildCast(byval B as LLVMBuilderRef, byval Op as LLVMOpcode, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildPointerCast(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildIntCast(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildFPCast(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval DestTy as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildICmp(byval as LLVMBuilderRef, byval Op as LLVMIntPredicate, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildFCmp(byval as LLVMBuilderRef, byval Op as LLVMRealPredicate, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildPhi(byval as LLVMBuilderRef, byval Ty as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildCall(byval as LLVMBuilderRef, byval Fn as LLVMValueRef, byval Args as LLVMValueRef ptr, byval NumArgs as ulong, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildSelect(byval as LLVMBuilderRef, byval If as LLVMValueRef, byval Then as LLVMValueRef, byval Else as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildVAArg(byval as LLVMBuilderRef, byval List as LLVMValueRef, byval Ty as LLVMTypeRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildExtractElement(byval as LLVMBuilderRef, byval VecVal as LLVMValueRef, byval Index as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildInsertElement(byval as LLVMBuilderRef, byval VecVal as LLVMValueRef, byval EltVal as LLVMValueRef, byval Index as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildShuffleVector(byval as LLVMBuilderRef, byval V1 as LLVMValueRef, byval V2 as LLVMValueRef, byval Mask as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildExtractValue(byval as LLVMBuilderRef, byval AggVal as LLVMValueRef, byval Index as ulong, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildInsertValue(byval as LLVMBuilderRef, byval AggVal as LLVMValueRef, byval EltVal as LLVMValueRef, byval Index as ulong, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildIsNull(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildIsNotNull(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildPtrDiff(byval as LLVMBuilderRef, byval LHS as LLVMValueRef, byval RHS as LLVMValueRef, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildFence(byval B as LLVMBuilderRef, byval ordering as LLVMAtomicOrdering, byval singleThread as LLVMBool, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildAtomicRMW(byval B as LLVMBuilderRef, byval op as LLVMAtomicRMWBinOp, byval PTR as LLVMValueRef, byval Val as LLVMValueRef, byval ordering as LLVMAtomicOrdering, byval singleThread as LLVMBool) as LLVMValueRef
declare function LLVMBuildAtomicCmpXchg(byval B as LLVMBuilderRef, byval Ptr_ as LLVMValueRef, byval Cmp as LLVMValueRef, byval New_ as LLVMValueRef, byval SuccessOrdering as LLVMAtomicOrdering, byval FailureOrdering as LLVMAtomicOrdering, byval SingleThread as LLVMBool) as LLVMValueRef
declare function LLVMIsAtomicSingleThread(byval AtomicInst as LLVMValueRef) as LLVMBool
declare sub LLVMSetAtomicSingleThread(byval AtomicInst as LLVMValueRef, byval SingleThread as LLVMBool)
declare function LLVMGetCmpXchgSuccessOrdering(byval CmpXchgInst as LLVMValueRef) as LLVMAtomicOrdering
declare sub LLVMSetCmpXchgSuccessOrdering(byval CmpXchgInst as LLVMValueRef, byval Ordering as LLVMAtomicOrdering)
declare function LLVMGetCmpXchgFailureOrdering(byval CmpXchgInst as LLVMValueRef) as LLVMAtomicOrdering
declare sub LLVMSetCmpXchgFailureOrdering(byval CmpXchgInst as LLVMValueRef, byval Ordering as LLVMAtomicOrdering)
declare function LLVMCreateModuleProviderForExistingModule(byval M as LLVMModuleRef) as LLVMModuleProviderRef
declare sub LLVMDisposeModuleProvider(byval M as LLVMModuleProviderRef)
declare function LLVMCreateMemoryBufferWithContentsOfFile(byval Path as const zstring ptr, byval OutMemBuf as LLVMMemoryBufferRef ptr, byval OutMessage as zstring ptr ptr) as LLVMBool
declare function LLVMCreateMemoryBufferWithSTDIN(byval OutMemBuf as LLVMMemoryBufferRef ptr, byval OutMessage as zstring ptr ptr) as LLVMBool
declare function LLVMCreateMemoryBufferWithMemoryRange(byval InputData as const zstring ptr, byval InputDataLength as uinteger, byval BufferName as const zstring ptr, byval RequiresNullTerminator as LLVMBool) as LLVMMemoryBufferRef
declare function LLVMCreateMemoryBufferWithMemoryRangeCopy(byval InputData as const zstring ptr, byval InputDataLength as uinteger, byval BufferName as const zstring ptr) as LLVMMemoryBufferRef
declare function LLVMGetBufferStart(byval MemBuf as LLVMMemoryBufferRef) as const zstring ptr
declare function LLVMGetBufferSize(byval MemBuf as LLVMMemoryBufferRef) as uinteger
declare sub LLVMDisposeMemoryBuffer(byval MemBuf as LLVMMemoryBufferRef)
declare function LLVMGetGlobalPassRegistry() as LLVMPassRegistryRef
declare function LLVMCreatePassManager() as LLVMPassManagerRef
declare function LLVMCreateFunctionPassManagerForModule(byval M as LLVMModuleRef) as LLVMPassManagerRef
declare function LLVMCreateFunctionPassManager(byval MP as LLVMModuleProviderRef) as LLVMPassManagerRef
declare function LLVMRunPassManager(byval PM as LLVMPassManagerRef, byval M as LLVMModuleRef) as LLVMBool
declare function LLVMInitializeFunctionPassManager(byval FPM as LLVMPassManagerRef) as LLVMBool
declare function LLVMRunFunctionPassManager(byval FPM as LLVMPassManagerRef, byval F as LLVMValueRef) as LLVMBool
declare function LLVMFinalizeFunctionPassManager(byval FPM as LLVMPassManagerRef) as LLVMBool
declare sub LLVMDisposePassManager(byval PM as LLVMPassManagerRef)
declare function LLVMStartMultithreaded() as LLVMBool
declare sub LLVMStopMultithreaded()
declare function LLVMIsMultithreaded() as LLVMBool
#define LLVM_C_DISASSEMBLER_H
type LLVMDisasmContextRef as any ptr
type LLVMOpInfoCallback as function(byval DisInfo as any ptr, byval PC as ulongint, byval Offset as ulongint, byval Size as ulongint, byval TagType as long, byval TagBuf as any ptr) as long

type LLVMOpInfoSymbol1
	Present as ulongint
	Name as const zstring ptr
	Value as ulongint
end type

type LLVMOpInfo1
	AddSymbol as LLVMOpInfoSymbol1
	SubtractSymbol as LLVMOpInfoSymbol1
	Value as ulongint
	VariantKind as ulongint
end type

const LLVMDisassembler_VariantKind_None = 0
const LLVMDisassembler_VariantKind_ARM_HI16 = 1
const LLVMDisassembler_VariantKind_ARM_LO16 = 2
const LLVMDisassembler_VariantKind_ARM64_PAGE = 1
const LLVMDisassembler_VariantKind_ARM64_PAGEOFF = 2
const LLVMDisassembler_VariantKind_ARM64_GOTPAGE = 3
const LLVMDisassembler_VariantKind_ARM64_GOTPAGEOFF = 4
const LLVMDisassembler_VariantKind_ARM64_TLVP = 5
const LLVMDisassembler_VariantKind_ARM64_TLVOFF = 6
type LLVMSymbolLookupCallback as function(byval DisInfo as any ptr, byval ReferenceValue as ulongint, byval ReferenceType as ulongint ptr, byval ReferencePC as ulongint, byval ReferenceName as const zstring ptr ptr) as const zstring ptr
const LLVMDisassembler_ReferenceType_InOut_None = 0
const LLVMDisassembler_ReferenceType_In_Branch = 1
const LLVMDisassembler_ReferenceType_In_PCrel_Load = 2
const LLVMDisassembler_ReferenceType_In_ARM64_ADRP = &h100000001
const LLVMDisassembler_ReferenceType_In_ARM64_ADDXri = &h100000002
const LLVMDisassembler_ReferenceType_In_ARM64_LDRXui = &h100000003
const LLVMDisassembler_ReferenceType_In_ARM64_LDRXl = &h100000004
const LLVMDisassembler_ReferenceType_In_ARM64_ADR = &h100000005
const LLVMDisassembler_ReferenceType_Out_SymbolStub = 1
const LLVMDisassembler_ReferenceType_Out_LitPool_SymAddr = 2
const LLVMDisassembler_ReferenceType_Out_LitPool_CstrAddr = 3
const LLVMDisassembler_ReferenceType_Out_Objc_CFString_Ref = 4
const LLVMDisassembler_ReferenceType_Out_Objc_Message = 5
const LLVMDisassembler_ReferenceType_Out_Objc_Message_Ref = 6
const LLVMDisassembler_ReferenceType_Out_Objc_Selector_Ref = 7
const LLVMDisassembler_ReferenceType_Out_Objc_Class_Ref = 8
const LLVMDisassembler_ReferenceType_DeMangled_Name = 9

declare function LLVMCreateDisasm(byval TripleName as const zstring ptr, byval DisInfo as any ptr, byval TagType as long, byval GetOpInfo as LLVMOpInfoCallback, byval SymbolLookUp as LLVMSymbolLookupCallback) as LLVMDisasmContextRef
declare function LLVMCreateDisasmCPU(byval Triple as const zstring ptr, byval CPU as const zstring ptr, byval DisInfo as any ptr, byval TagType as long, byval GetOpInfo as LLVMOpInfoCallback, byval SymbolLookUp as LLVMSymbolLookupCallback) as LLVMDisasmContextRef
declare function LLVMCreateDisasmCPUFeatures(byval Triple as const zstring ptr, byval CPU as const zstring ptr, byval Features as const zstring ptr, byval DisInfo as any ptr, byval TagType as long, byval GetOpInfo as LLVMOpInfoCallback, byval SymbolLookUp as LLVMSymbolLookupCallback) as LLVMDisasmContextRef
declare function LLVMSetDisasmOptions(byval DC as LLVMDisasmContextRef, byval Options as ulongint) as long

const LLVMDisassembler_Option_UseMarkup = 1
const LLVMDisassembler_Option_PrintImmHex = 2
const LLVMDisassembler_Option_AsmPrinterVariant = 4
const LLVMDisassembler_Option_SetInstrComments = 8
const LLVMDisassembler_Option_PrintLatency = 16
declare sub LLVMDisasmDispose(byval DC as LLVMDisasmContextRef)
declare function LLVMDisasmInstruction(byval DC as LLVMDisasmContextRef, byval Bytes as ubyte ptr, byval BytesSize as ulongint, byval PC as ulongint, byval OutString as zstring ptr, byval OutStringSize as uinteger) as uinteger
#define LLVM_C_EXECUTIONENGINE_H
#define LLVM_C_TARGET_H
#define LLVM_CONFIG_H
#ifdef __FB_WIN32__
	#ifdef __FB_64BIT__
		#define LLVM_DEFAULT_TARGET_TRIPLE "x86_64-w64-mingw32"
	#else
		#define LLVM_DEFAULT_TARGET_TRIPLE "i686-w64-mingw32"
	#endif
#else
	#ifdef __FB_64BIT__
		#define LLVM_DEFAULT_TARGET_TRIPLE "x86_64-pc-linux-gnu"
	#else
		#define LLVM_DEFAULT_TARGET_TRIPLE "i686-pc-linux-gnu"
	#endif
#endif
const LLVM_ENABLE_THREADS = 1
const LLVM_HAS_ATOMICS = 1
#define LLVM_HOST_TRIPLE LLVM_DEFAULT_TARGET_TRIPLE
#define LLVM_NATIVE_ARCH X86
#ifdef __FB_UNIX__
	const LLVM_ON_UNIX = 1
#endif
const LLVM_USE_INTEL_JITEVENTS = 0
const LLVM_USE_OPROFILE = 0
const LLVM_VERSION_MAJOR = 5
const LLVM_VERSION_MINOR = 0
const LLVM_VERSION_PATCH = 0
#define LLVM_VERSION_STRING "5.0.0git-fb0acea"

type LLVMByteOrdering as long
enum
	LLVMBigEndian
	LLVMLittleEndian
end enum

type LLVMTargetDataRef as LLVMOpaqueTargetData ptr
type LLVMTargetLibraryInfoRef as LLVMOpaqueTargetLibraryInfotData ptr
declare sub LLVMInitializeAArch64TargetInfo()
declare sub LLVMInitializeAMDGPUTargetInfo()
declare sub LLVMInitializeARMTargetInfo()
declare sub LLVMInitializeBPFTargetInfo()
declare sub LLVMInitializeHexagonTargetInfo()
declare sub LLVMInitializeLanaiTargetInfo()
declare sub LLVMInitializeMipsTargetInfo()
declare sub LLVMInitializeMSP430TargetInfo()
declare sub LLVMInitializeNVPTXTargetInfo()
declare sub LLVMInitializePowerPCTargetInfo()
declare sub LLVMInitializeSparcTargetInfo()
declare sub LLVMInitializeSystemZTargetInfo()
declare sub LLVMInitializeX86TargetInfo()
declare sub LLVM_NATIVE_TARGETINFO alias "LLVMInitializeX86TargetInfo"()
declare sub LLVMInitializeXCoreTargetInfo()
declare sub LLVMInitializeAArch64Target()
declare sub LLVMInitializeAMDGPUTarget()
declare sub LLVMInitializeARMTarget()
declare sub LLVMInitializeBPFTarget()
declare sub LLVMInitializeHexagonTarget()
declare sub LLVMInitializeLanaiTarget()
declare sub LLVMInitializeMipsTarget()
declare sub LLVMInitializeMSP430Target()
declare sub LLVMInitializeNVPTXTarget()
declare sub LLVMInitializePowerPCTarget()
declare sub LLVMInitializeSparcTarget()
declare sub LLVMInitializeSystemZTarget()
declare sub LLVMInitializeX86Target()
declare sub LLVM_NATIVE_TARGET alias "LLVMInitializeX86Target"()
declare sub LLVMInitializeXCoreTarget()
declare sub LLVMInitializeAArch64TargetMC()
declare sub LLVMInitializeAMDGPUTargetMC()
declare sub LLVMInitializeARMTargetMC()
declare sub LLVMInitializeBPFTargetMC()
declare sub LLVMInitializeHexagonTargetMC()
declare sub LLVMInitializeLanaiTargetMC()
declare sub LLVMInitializeMipsTargetMC()
declare sub LLVMInitializeMSP430TargetMC()
declare sub LLVMInitializeNVPTXTargetMC()
declare sub LLVMInitializePowerPCTargetMC()
declare sub LLVMInitializeSparcTargetMC()
declare sub LLVMInitializeSystemZTargetMC()
declare sub LLVMInitializeX86TargetMC()
declare sub LLVM_NATIVE_TARGETMC alias "LLVMInitializeX86TargetMC"()
declare sub LLVMInitializeXCoreTargetMC()
declare sub LLVMInitializeAArch64AsmPrinter()
declare sub LLVMInitializeAMDGPUAsmPrinter()
declare sub LLVMInitializeARMAsmPrinter()
declare sub LLVMInitializeBPFAsmPrinter()
declare sub LLVMInitializeHexagonAsmPrinter()
declare sub LLVMInitializeLanaiAsmPrinter()
declare sub LLVMInitializeMipsAsmPrinter()
declare sub LLVMInitializeMSP430AsmPrinter()
declare sub LLVMInitializeNVPTXAsmPrinter()
declare sub LLVMInitializePowerPCAsmPrinter()
declare sub LLVMInitializeSparcAsmPrinter()
declare sub LLVMInitializeSystemZAsmPrinter()
declare sub LLVMInitializeX86AsmPrinter()
declare sub LLVM_NATIVE_ASMPRINTER alias "LLVMInitializeX86AsmPrinter"()
declare sub LLVMInitializeXCoreAsmPrinter()
declare sub LLVMInitializeAArch64AsmParser()
declare sub LLVMInitializeAMDGPUAsmParser()
declare sub LLVMInitializeARMAsmParser()
declare sub LLVMInitializeHexagonAsmParser()
declare sub LLVMInitializeLanaiAsmParser()
declare sub LLVMInitializeMipsAsmParser()
declare sub LLVMInitializePowerPCAsmParser()
declare sub LLVMInitializeSparcAsmParser()
declare sub LLVMInitializeSystemZAsmParser()
declare sub LLVMInitializeX86AsmParser()
declare sub LLVM_NATIVE_ASMPARSER alias "LLVMInitializeX86AsmParser"()
declare sub LLVMInitializeAArch64Disassembler()
declare sub LLVMInitializeAMDGPUDisassembler()
declare sub LLVMInitializeARMDisassembler()
declare sub LLVMInitializeBPFDisassembler()
declare sub LLVMInitializeHexagonDisassembler()
declare sub LLVMInitializeLanaiDisassembler()
declare sub LLVMInitializeMipsDisassembler()
declare sub LLVMInitializePowerPCDisassembler()
declare sub LLVMInitializeSparcDisassembler()
declare sub LLVMInitializeSystemZDisassembler()
declare sub LLVMInitializeX86Disassembler()
declare sub LLVM_NATIVE_DISASSEMBLER alias "LLVMInitializeX86Disassembler"()
declare sub LLVMInitializeXCoreDisassembler()

private sub LLVMInitializeAllTargetInfos()
	LLVMInitializeAArch64TargetInfo()
	LLVMInitializeAMDGPUTargetInfo()
	LLVMInitializeARMTargetInfo()
	LLVMInitializeBPFTargetInfo()
	LLVMInitializeHexagonTargetInfo()
	LLVMInitializeLanaiTargetInfo()
	LLVMInitializeMipsTargetInfo()
	LLVMInitializeMSP430TargetInfo()
	LLVMInitializeNVPTXTargetInfo()
	LLVMInitializePowerPCTargetInfo()
	LLVMInitializeSparcTargetInfo()
	LLVMInitializeSystemZTargetInfo()
	LLVMInitializeX86TargetInfo()
	LLVMInitializeXCoreTargetInfo()
end sub

private sub LLVMInitializeAllTargets()
	LLVMInitializeAArch64Target()
	LLVMInitializeAMDGPUTarget()
	LLVMInitializeARMTarget()
	LLVMInitializeBPFTarget()
	LLVMInitializeHexagonTarget()
	LLVMInitializeLanaiTarget()
	LLVMInitializeMipsTarget()
	LLVMInitializeMSP430Target()
	LLVMInitializeNVPTXTarget()
	LLVMInitializePowerPCTarget()
	LLVMInitializeSparcTarget()
	LLVMInitializeSystemZTarget()
	LLVMInitializeX86Target()
	LLVMInitializeXCoreTarget()
end sub

private sub LLVMInitializeAllTargetMCs()
	LLVMInitializeAArch64TargetMC()
	LLVMInitializeAMDGPUTargetMC()
	LLVMInitializeARMTargetMC()
	LLVMInitializeBPFTargetMC()
	LLVMInitializeHexagonTargetMC()
	LLVMInitializeLanaiTargetMC()
	LLVMInitializeMipsTargetMC()
	LLVMInitializeMSP430TargetMC()
	LLVMInitializeNVPTXTargetMC()
	LLVMInitializePowerPCTargetMC()
	LLVMInitializeSparcTargetMC()
	LLVMInitializeSystemZTargetMC()
	LLVMInitializeX86TargetMC()
	LLVMInitializeXCoreTargetMC()
end sub

private sub LLVMInitializeAllAsmPrinters()
	LLVMInitializeAArch64AsmPrinter()
	LLVMInitializeAMDGPUAsmPrinter()
	LLVMInitializeARMAsmPrinter()
	LLVMInitializeBPFAsmPrinter()
	LLVMInitializeHexagonAsmPrinter()
	LLVMInitializeLanaiAsmPrinter()
	LLVMInitializeMipsAsmPrinter()
	LLVMInitializeMSP430AsmPrinter()
	LLVMInitializeNVPTXAsmPrinter()
	LLVMInitializePowerPCAsmPrinter()
	LLVMInitializeSparcAsmPrinter()
	LLVMInitializeSystemZAsmPrinter()
	LLVMInitializeX86AsmPrinter()
	LLVMInitializeXCoreAsmPrinter()
end sub

private sub LLVMInitializeAllAsmParsers()
	LLVMInitializeAArch64AsmParser()
	LLVMInitializeAMDGPUAsmParser()
	LLVMInitializeARMAsmParser()
	LLVMInitializeHexagonAsmParser()
	LLVMInitializeLanaiAsmParser()
	LLVMInitializeMipsAsmParser()
	LLVMInitializePowerPCAsmParser()
	LLVMInitializeSparcAsmParser()
	LLVMInitializeSystemZAsmParser()
	LLVMInitializeX86AsmParser()
end sub

private sub LLVMInitializeAllDisassemblers()
	LLVMInitializeAArch64Disassembler()
	LLVMInitializeAMDGPUDisassembler()
	LLVMInitializeARMDisassembler()
	LLVMInitializeBPFDisassembler()
	LLVMInitializeHexagonDisassembler()
	LLVMInitializeLanaiDisassembler()
	LLVMInitializeMipsDisassembler()
	LLVMInitializePowerPCDisassembler()
	LLVMInitializeSparcDisassembler()
	LLVMInitializeSystemZDisassembler()
	LLVMInitializeX86Disassembler()
	LLVMInitializeXCoreDisassembler()
end sub

private function LLVMInitializeNativeTarget() as LLVMBool
	LLVMInitializeX86TargetInfo()
	LLVMInitializeX86Target()
	LLVMInitializeX86TargetMC()
	return 0
end function

private function LLVMInitializeNativeAsmParser() as LLVMBool
	LLVMInitializeX86AsmParser()
	return 0
end function

private function LLVMInitializeNativeAsmPrinter() as LLVMBool
	LLVMInitializeX86AsmPrinter()
	return 0
end function

private function LLVMInitializeNativeDisassembler() as LLVMBool
	LLVMInitializeX86Disassembler()
	return 0
end function

declare function LLVMGetModuleDataLayout(byval M as LLVMModuleRef) as LLVMTargetDataRef
declare sub LLVMSetModuleDataLayout(byval M as LLVMModuleRef, byval DL as LLVMTargetDataRef)
declare function LLVMCreateTargetData(byval StringRep as const zstring ptr) as LLVMTargetDataRef
declare sub LLVMDisposeTargetData(byval TD as LLVMTargetDataRef)
declare sub LLVMAddTargetLibraryInfo(byval TLI as LLVMTargetLibraryInfoRef, byval PM as LLVMPassManagerRef)
declare function LLVMCopyStringRepOfTargetData(byval TD as LLVMTargetDataRef) as zstring ptr
declare function LLVMByteOrder(byval TD as LLVMTargetDataRef) as LLVMByteOrdering
declare function LLVMPointerSize(byval TD as LLVMTargetDataRef) as ulong
declare function LLVMPointerSizeForAS(byval TD as LLVMTargetDataRef, byval AS_ as ulong) as ulong
declare function LLVMIntPtrType(byval TD as LLVMTargetDataRef) as LLVMTypeRef
declare function LLVMIntPtrTypeForAS(byval TD as LLVMTargetDataRef, byval AS_ as ulong) as LLVMTypeRef
declare function LLVMIntPtrTypeInContext(byval C as LLVMContextRef, byval TD as LLVMTargetDataRef) as LLVMTypeRef
declare function LLVMIntPtrTypeForASInContext(byval C as LLVMContextRef, byval TD as LLVMTargetDataRef, byval AS_ as ulong) as LLVMTypeRef
declare function LLVMSizeOfTypeInBits(byval TD as LLVMTargetDataRef, byval Ty as LLVMTypeRef) as ulongint
declare function LLVMStoreSizeOfType(byval TD as LLVMTargetDataRef, byval Ty as LLVMTypeRef) as ulongint
declare function LLVMABISizeOfType(byval TD as LLVMTargetDataRef, byval Ty as LLVMTypeRef) as ulongint
declare function LLVMABIAlignmentOfType(byval TD as LLVMTargetDataRef, byval Ty as LLVMTypeRef) as ulong
declare function LLVMCallFrameAlignmentOfType(byval TD as LLVMTargetDataRef, byval Ty as LLVMTypeRef) as ulong
declare function LLVMPreferredAlignmentOfType(byval TD as LLVMTargetDataRef, byval Ty as LLVMTypeRef) as ulong
declare function LLVMPreferredAlignmentOfGlobal(byval TD as LLVMTargetDataRef, byval GlobalVar as LLVMValueRef) as ulong
declare function LLVMElementAtOffset(byval TD as LLVMTargetDataRef, byval StructTy as LLVMTypeRef, byval Offset as ulongint) as ulong
declare function LLVMOffsetOfElement(byval TD as LLVMTargetDataRef, byval StructTy as LLVMTypeRef, byval Element as ulong) as ulongint
#define LLVM_C_TARGETMACHINE_H
type LLVMTargetMachineRef as LLVMOpaqueTargetMachine ptr
type LLVMTargetRef as LLVMTarget ptr

type LLVMCodeGenOptLevel as long
enum
	LLVMCodeGenLevelNone
	LLVMCodeGenLevelLess
	LLVMCodeGenLevelDefault
	LLVMCodeGenLevelAggressive
end enum

type LLVMRelocMode as long
enum
	LLVMRelocDefault
	LLVMRelocStatic
	LLVMRelocPIC
	LLVMRelocDynamicNoPic
end enum

type LLVMCodeModel as long
enum
	LLVMCodeModelDefault
	LLVMCodeModelJITDefault
	LLVMCodeModelSmall
	LLVMCodeModelKernel
	LLVMCodeModelMedium
	LLVMCodeModelLarge
end enum

type LLVMCodeGenFileType as long
enum
	LLVMAssemblyFile
	LLVMObjectFile
end enum

declare function LLVMGetFirstTarget() as LLVMTargetRef
declare function LLVMGetNextTarget(byval T as LLVMTargetRef) as LLVMTargetRef
declare function LLVMGetTargetFromName(byval Name as const zstring ptr) as LLVMTargetRef
declare function LLVMGetTargetFromTriple(byval Triple as const zstring ptr, byval T as LLVMTargetRef ptr, byval ErrorMessage as zstring ptr ptr) as LLVMBool
declare function LLVMGetTargetName(byval T as LLVMTargetRef) as const zstring ptr
declare function LLVMGetTargetDescription(byval T as LLVMTargetRef) as const zstring ptr
declare function LLVMTargetHasJIT(byval T as LLVMTargetRef) as LLVMBool
declare function LLVMTargetHasTargetMachine(byval T as LLVMTargetRef) as LLVMBool
declare function LLVMTargetHasAsmBackend(byval T as LLVMTargetRef) as LLVMBool
declare function LLVMCreateTargetMachine(byval T as LLVMTargetRef, byval Triple as const zstring ptr, byval CPU as const zstring ptr, byval Features as const zstring ptr, byval Level as LLVMCodeGenOptLevel, byval Reloc as LLVMRelocMode, byval CodeModel as LLVMCodeModel) as LLVMTargetMachineRef
declare sub LLVMDisposeTargetMachine(byval T as LLVMTargetMachineRef)
declare function LLVMGetTargetMachineTarget(byval T as LLVMTargetMachineRef) as LLVMTargetRef
declare function LLVMGetTargetMachineTriple(byval T as LLVMTargetMachineRef) as zstring ptr
declare function LLVMGetTargetMachineCPU(byval T as LLVMTargetMachineRef) as zstring ptr
declare function LLVMGetTargetMachineFeatureString(byval T as LLVMTargetMachineRef) as zstring ptr
declare function LLVMCreateTargetDataLayout(byval T as LLVMTargetMachineRef) as LLVMTargetDataRef
declare sub LLVMSetTargetMachineAsmVerbosity(byval T as LLVMTargetMachineRef, byval VerboseAsm as LLVMBool)
declare function LLVMTargetMachineEmitToFile(byval T as LLVMTargetMachineRef, byval M as LLVMModuleRef, byval Filename as zstring ptr, byval codegen as LLVMCodeGenFileType, byval ErrorMessage as zstring ptr ptr) as LLVMBool
declare function LLVMTargetMachineEmitToMemoryBuffer(byval T as LLVMTargetMachineRef, byval M as LLVMModuleRef, byval codegen as LLVMCodeGenFileType, byval ErrorMessage as zstring ptr ptr, byval OutMemBuf as LLVMMemoryBufferRef ptr) as LLVMBool
declare function LLVMGetDefaultTargetTriple() as zstring ptr
declare sub LLVMAddAnalysisPasses(byval T as LLVMTargetMachineRef, byval PM as LLVMPassManagerRef)
declare sub LLVMLinkInMCJIT()
declare sub LLVMLinkInInterpreter()

type LLVMGenericValueRef as LLVMOpaqueGenericValue ptr
type LLVMExecutionEngineRef as LLVMOpaqueExecutionEngine ptr
type LLVMMCJITMemoryManagerRef as LLVMOpaqueMCJITMemoryManager ptr

type LLVMMCJITCompilerOptions
	OptLevel as ulong
	CodeModel as LLVMCodeModel
	NoFramePointerElim as LLVMBool
	EnableFastISel as LLVMBool
	MCJMM as LLVMMCJITMemoryManagerRef
end type

declare function LLVMCreateGenericValueOfInt(byval Ty as LLVMTypeRef, byval N as ulongint, byval IsSigned as LLVMBool) as LLVMGenericValueRef
declare function LLVMCreateGenericValueOfPointer(byval P as any ptr) as LLVMGenericValueRef
declare function LLVMCreateGenericValueOfFloat(byval Ty as LLVMTypeRef, byval N as double) as LLVMGenericValueRef
declare function LLVMGenericValueIntWidth(byval GenValRef as LLVMGenericValueRef) as ulong
declare function LLVMGenericValueToInt(byval GenVal as LLVMGenericValueRef, byval IsSigned as LLVMBool) as ulongint
declare function LLVMGenericValueToPointer(byval GenVal as LLVMGenericValueRef) as any ptr
declare function LLVMGenericValueToFloat(byval TyRef as LLVMTypeRef, byval GenVal as LLVMGenericValueRef) as double
declare sub LLVMDisposeGenericValue(byval GenVal as LLVMGenericValueRef)
declare function LLVMCreateExecutionEngineForModule(byval OutEE as LLVMExecutionEngineRef ptr, byval M as LLVMModuleRef, byval OutError as zstring ptr ptr) as LLVMBool
declare function LLVMCreateInterpreterForModule(byval OutInterp as LLVMExecutionEngineRef ptr, byval M as LLVMModuleRef, byval OutError as zstring ptr ptr) as LLVMBool
declare function LLVMCreateJITCompilerForModule(byval OutJIT as LLVMExecutionEngineRef ptr, byval M as LLVMModuleRef, byval OptLevel as ulong, byval OutError as zstring ptr ptr) as LLVMBool
declare sub LLVMInitializeMCJITCompilerOptions(byval Options as LLVMMCJITCompilerOptions ptr, byval SizeOfOptions as uinteger)
declare function LLVMCreateMCJITCompilerForModule(byval OutJIT as LLVMExecutionEngineRef ptr, byval M as LLVMModuleRef, byval Options as LLVMMCJITCompilerOptions ptr, byval SizeOfOptions as uinteger, byval OutError as zstring ptr ptr) as LLVMBool
declare sub LLVMDisposeExecutionEngine(byval EE as LLVMExecutionEngineRef)
declare sub LLVMRunStaticConstructors(byval EE as LLVMExecutionEngineRef)
declare sub LLVMRunStaticDestructors(byval EE as LLVMExecutionEngineRef)
declare function LLVMRunFunctionAsMain(byval EE as LLVMExecutionEngineRef, byval F as LLVMValueRef, byval ArgC as ulong, byval ArgV as const zstring const ptr ptr, byval EnvP as const zstring const ptr ptr) as long
declare function LLVMRunFunction(byval EE as LLVMExecutionEngineRef, byval F as LLVMValueRef, byval NumArgs as ulong, byval Args as LLVMGenericValueRef ptr) as LLVMGenericValueRef
declare sub LLVMFreeMachineCodeForFunction(byval EE as LLVMExecutionEngineRef, byval F as LLVMValueRef)
declare sub LLVMAddModule(byval EE as LLVMExecutionEngineRef, byval M as LLVMModuleRef)
declare function LLVMRemoveModule(byval EE as LLVMExecutionEngineRef, byval M as LLVMModuleRef, byval OutMod as LLVMModuleRef ptr, byval OutError as zstring ptr ptr) as LLVMBool
declare function LLVMFindFunction(byval EE as LLVMExecutionEngineRef, byval Name as const zstring ptr, byval OutFn as LLVMValueRef ptr) as LLVMBool
declare function LLVMRecompileAndRelinkFunction(byval EE as LLVMExecutionEngineRef, byval Fn as LLVMValueRef) as any ptr
declare function LLVMGetExecutionEngineTargetData(byval EE as LLVMExecutionEngineRef) as LLVMTargetDataRef
declare function LLVMGetExecutionEngineTargetMachine(byval EE as LLVMExecutionEngineRef) as LLVMTargetMachineRef
declare sub LLVMAddGlobalMapping(byval EE as LLVMExecutionEngineRef, byval Global as LLVMValueRef, byval Addr as any ptr)
declare function LLVMGetPointerToGlobal(byval EE as LLVMExecutionEngineRef, byval Global as LLVMValueRef) as any ptr
declare function LLVMGetGlobalValueAddress(byval EE as LLVMExecutionEngineRef, byval Name as const zstring ptr) as ulongint
declare function LLVMGetFunctionAddress(byval EE as LLVMExecutionEngineRef, byval Name as const zstring ptr) as ulongint

type LLVMMemoryManagerAllocateCodeSectionCallback as function(byval Opaque as any ptr, byval Size as uinteger, byval Alignment as ulong, byval SectionID as ulong, byval SectionName as const zstring ptr) as ubyte ptr
type LLVMMemoryManagerAllocateDataSectionCallback as function(byval Opaque as any ptr, byval Size as uinteger, byval Alignment as ulong, byval SectionID as ulong, byval SectionName as const zstring ptr, byval IsReadOnly as LLVMBool) as ubyte ptr
type LLVMMemoryManagerFinalizeMemoryCallback as function(byval Opaque as any ptr, byval ErrMsg as zstring ptr ptr) as LLVMBool
type LLVMMemoryManagerDestroyCallback as sub(byval Opaque as any ptr)
declare function LLVMCreateSimpleMCJITMemoryManager(byval Opaque as any ptr, byval AllocateCodeSection as LLVMMemoryManagerAllocateCodeSectionCallback, byval AllocateDataSection as LLVMMemoryManagerAllocateDataSectionCallback, byval FinalizeMemory as LLVMMemoryManagerFinalizeMemoryCallback, byval Destroy as LLVMMemoryManagerDestroyCallback) as LLVMMCJITMemoryManagerRef
declare sub LLVMDisposeMCJITMemoryManager(byval MM as LLVMMCJITMemoryManagerRef)
#define LLVM_C_IRREADER_H
declare function LLVMParseIRInContext(byval ContextRef as LLVMContextRef, byval MemBuf as LLVMMemoryBufferRef, byval OutM as LLVMModuleRef ptr, byval OutMessage as zstring ptr ptr) as LLVMBool
#define LLVM_C_INITIALIZATION_H

declare sub LLVMInitializeCore(byval R as LLVMPassRegistryRef)
declare sub LLVMInitializeTransformUtils(byval R as LLVMPassRegistryRef)
declare sub LLVMInitializeScalarOpts(byval R as LLVMPassRegistryRef)
declare sub LLVMInitializeObjCARCOpts(byval R as LLVMPassRegistryRef)
declare sub LLVMInitializeVectorization(byval R as LLVMPassRegistryRef)
declare sub LLVMInitializeInstCombine(byval R as LLVMPassRegistryRef)
declare sub LLVMInitializeIPO(byval R as LLVMPassRegistryRef)
declare sub LLVMInitializeInstrumentation(byval R as LLVMPassRegistryRef)
declare sub LLVMInitializeAnalysis(byval R as LLVMPassRegistryRef)
declare sub LLVMInitializeIPA(byval R as LLVMPassRegistryRef)
declare sub LLVMInitializeCodeGen(byval R as LLVMPassRegistryRef)
declare sub LLVMInitializeTarget(byval R as LLVMPassRegistryRef)
#define LLVM_C_LINKTIMEOPTIMIZER_H
type llvm_lto_t as any ptr

type llvm_lto_status as long
enum
	LLVM_LTO_UNKNOWN
	LLVM_LTO_OPT_SUCCESS
	LLVM_LTO_READ_SUCCESS
	LLVM_LTO_READ_FAILURE
	LLVM_LTO_WRITE_FAILURE
	LLVM_LTO_NO_TARGET
	LLVM_LTO_NO_WORK
	LLVM_LTO_MODULE_MERGE_FAILURE
	LLVM_LTO_ASM_FAILURE
	LLVM_LTO_NULL_OBJECT
end enum

type llvm_lto_status_t as llvm_lto_status
declare function llvm_create_optimizer() as llvm_lto_t
declare sub llvm_destroy_optimizer(byval lto as llvm_lto_t)
declare function llvm_read_object_file(byval lto as llvm_lto_t, byval input_filename as const zstring ptr) as llvm_lto_status_t
declare function llvm_optimize_modules(byval lto as llvm_lto_t, byval output_filename as const zstring ptr) as llvm_lto_status_t
#define LLVM_C_LINKER_H

type LLVMLinkerMode as long
enum
	LLVMLinkerDestroySource = 0
	LLVMLinkerPreserveSource_Removed = 1
end enum

declare function LLVMLinkModules2(byval Dest as LLVMModuleRef, byval Src as LLVMModuleRef) as LLVMBool
#define LLVM_C_OBJECT_H
type LLVMObjectFileRef as LLVMOpaqueObjectFile ptr
type LLVMSectionIteratorRef as LLVMOpaqueSectionIterator ptr
type LLVMSymbolIteratorRef as LLVMOpaqueSymbolIterator ptr
type LLVMRelocationIteratorRef as LLVMOpaqueRelocationIterator ptr

declare function LLVMCreateObjectFile(byval MemBuf as LLVMMemoryBufferRef) as LLVMObjectFileRef
declare sub LLVMDisposeObjectFile(byval ObjectFile as LLVMObjectFileRef)
declare function LLVMGetSections(byval ObjectFile as LLVMObjectFileRef) as LLVMSectionIteratorRef
declare sub LLVMDisposeSectionIterator(byval SI as LLVMSectionIteratorRef)
declare function LLVMIsSectionIteratorAtEnd(byval ObjectFile as LLVMObjectFileRef, byval SI as LLVMSectionIteratorRef) as LLVMBool
declare sub LLVMMoveToNextSection(byval SI as LLVMSectionIteratorRef)
declare sub LLVMMoveToContainingSection(byval Sect as LLVMSectionIteratorRef, byval Sym as LLVMSymbolIteratorRef)
declare function LLVMGetSymbols(byval ObjectFile as LLVMObjectFileRef) as LLVMSymbolIteratorRef
declare sub LLVMDisposeSymbolIterator(byval SI as LLVMSymbolIteratorRef)
declare function LLVMIsSymbolIteratorAtEnd(byval ObjectFile as LLVMObjectFileRef, byval SI as LLVMSymbolIteratorRef) as LLVMBool
declare sub LLVMMoveToNextSymbol(byval SI as LLVMSymbolIteratorRef)
declare function LLVMGetSectionName(byval SI as LLVMSectionIteratorRef) as const zstring ptr
declare function LLVMGetSectionSize(byval SI as LLVMSectionIteratorRef) as ulongint
declare function LLVMGetSectionContents(byval SI as LLVMSectionIteratorRef) as const zstring ptr
declare function LLVMGetSectionAddress(byval SI as LLVMSectionIteratorRef) as ulongint
declare function LLVMGetSectionContainsSymbol(byval SI as LLVMSectionIteratorRef, byval Sym as LLVMSymbolIteratorRef) as LLVMBool
declare function LLVMGetRelocations(byval Section as LLVMSectionIteratorRef) as LLVMRelocationIteratorRef
declare sub LLVMDisposeRelocationIterator(byval RI as LLVMRelocationIteratorRef)
declare function LLVMIsRelocationIteratorAtEnd(byval Section as LLVMSectionIteratorRef, byval RI as LLVMRelocationIteratorRef) as LLVMBool
declare sub LLVMMoveToNextRelocation(byval RI as LLVMRelocationIteratorRef)
declare function LLVMGetSymbolName(byval SI as LLVMSymbolIteratorRef) as const zstring ptr
declare function LLVMGetSymbolAddress(byval SI as LLVMSymbolIteratorRef) as ulongint
declare function LLVMGetSymbolSize(byval SI as LLVMSymbolIteratorRef) as ulongint
declare function LLVMGetRelocationOffset(byval RI as LLVMRelocationIteratorRef) as ulongint
declare function LLVMGetRelocationSymbol(byval RI as LLVMRelocationIteratorRef) as LLVMSymbolIteratorRef
declare function LLVMGetRelocationType(byval RI as LLVMRelocationIteratorRef) as ulongint
declare function LLVMGetRelocationTypeName(byval RI as LLVMRelocationIteratorRef) as const zstring ptr
declare function LLVMGetRelocationValueString(byval RI as LLVMRelocationIteratorRef) as const zstring ptr
#define LLVM_C_ORCBINDINGS_H

type LLVMSharedModuleRef as LLVMOpaqueSharedModule ptr
type LLVMSharedObjectBufferRef as LLVMOpaqueSharedObjectBuffer ptr
type LLVMOrcJITStackRef as LLVMOrcOpaqueJITStack ptr
type LLVMOrcModuleHandle as ulong
type LLVMOrcTargetAddress as ulongint
type LLVMOrcSymbolResolverFn as function(byval Name as const zstring ptr, byval LookupCtx as any ptr) as ulongint
type LLVMOrcLazyCompileCallbackFn as function(byval JITStack as LLVMOrcJITStackRef, byval CallbackCtx as any ptr) as ulongint

type LLVMOrcErrorCode as long
enum
	LLVMOrcErrSuccess = 0
	LLVMOrcErrGeneric
end enum

declare function LLVMOrcMakeSharedModule(byval Mod_ as LLVMModuleRef) as LLVMSharedModuleRef
declare sub LLVMOrcDisposeSharedModuleRef(byval SharedMod as LLVMSharedModuleRef)
declare function LLVMOrcMakeSharedObjectBuffer(byval ObjBuffer as LLVMMemoryBufferRef) as LLVMSharedObjectBufferRef
declare sub LLVMOrcDisposeSharedObjectBufferRef(byval SharedObjBuffer as LLVMSharedObjectBufferRef)
declare function LLVMOrcCreateInstance(byval TM as LLVMTargetMachineRef) as LLVMOrcJITStackRef
declare function LLVMOrcGetErrorMsg(byval JITStack as LLVMOrcJITStackRef) as const zstring ptr
declare sub LLVMOrcGetMangledSymbol(byval JITStack as LLVMOrcJITStackRef, byval MangledSymbol as zstring ptr ptr, byval Symbol as const zstring ptr)
declare sub LLVMOrcDisposeMangledSymbol(byval MangledSymbol as zstring ptr)
declare function LLVMOrcCreateLazyCompileCallback(byval JITStack as LLVMOrcJITStackRef, byval RetAddr as LLVMOrcTargetAddress ptr, byval Callback as LLVMOrcLazyCompileCallbackFn, byval CallbackCtx as any ptr) as LLVMOrcErrorCode
declare function LLVMOrcCreateIndirectStub(byval JITStack as LLVMOrcJITStackRef, byval StubName as const zstring ptr, byval InitAddr as LLVMOrcTargetAddress) as LLVMOrcErrorCode
declare function LLVMOrcSetIndirectStubPointer(byval JITStack as LLVMOrcJITStackRef, byval StubName as const zstring ptr, byval NewAddr as LLVMOrcTargetAddress) as LLVMOrcErrorCode
declare function LLVMOrcAddEagerlyCompiledIR(byval JITStack as LLVMOrcJITStackRef, byval RetHandle as LLVMOrcModuleHandle ptr, byval Mod_ as LLVMSharedModuleRef, byval SymbolResolver as LLVMOrcSymbolResolverFn, byval SymbolResolverCtx as any ptr) as LLVMOrcErrorCode
declare function LLVMOrcAddLazilyCompiledIR(byval JITStack as LLVMOrcJITStackRef, byval RetHandle as LLVMOrcModuleHandle ptr, byval Mod_ as LLVMSharedModuleRef, byval SymbolResolver as LLVMOrcSymbolResolverFn, byval SymbolResolverCtx as any ptr) as LLVMOrcErrorCode
declare function LLVMOrcAddObjectFile(byval JITStack as LLVMOrcJITStackRef, byval RetHandle as LLVMOrcModuleHandle ptr, byval Obj as LLVMSharedObjectBufferRef, byval SymbolResolver as LLVMOrcSymbolResolverFn, byval SymbolResolverCtx as any ptr) as LLVMOrcErrorCode
declare function LLVMOrcRemoveModule(byval JITStack as LLVMOrcJITStackRef, byval H as LLVMOrcModuleHandle) as LLVMOrcErrorCode
declare function LLVMOrcGetSymbolAddress(byval JITStack as LLVMOrcJITStackRef, byval RetAddr as LLVMOrcTargetAddress ptr, byval SymbolName as const zstring ptr) as LLVMOrcErrorCode
declare function LLVMOrcDisposeInstance(byval JITStack as LLVMOrcJITStackRef) as LLVMOrcErrorCode
#define LLVM_C_SUPPORT_H
declare function LLVMLoadLibraryPermanently(byval Filename as const zstring ptr) as LLVMBool
declare sub LLVMParseCommandLineOptions(byval argc as long, byval argv as const zstring const ptr ptr, byval Overview as const zstring ptr)
declare function LLVMSearchForAddressOfSymbol(byval symbolName as const zstring ptr) as any ptr
declare sub LLVMAddSymbol(byval symbolName as const zstring ptr, byval symbolValue as any ptr)
#define LLVM_C_TRANSFORMS_IPO_H
declare sub LLVMAddArgumentPromotionPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddConstantMergePass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddDeadArgEliminationPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddFunctionAttrsPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddFunctionInliningPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddAlwaysInlinerPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddGlobalDCEPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddGlobalOptimizerPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddIPConstantPropagationPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddPruneEHPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddIPSCCPPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddInternalizePass(byval as LLVMPassManagerRef, byval AllButMain as ulong)
declare sub LLVMAddStripDeadPrototypesPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddStripSymbolsPass(byval PM as LLVMPassManagerRef)
#define LLVM_C_TRANSFORMS_PASSMANAGERBUILDER_H
type LLVMPassManagerBuilderRef as LLVMOpaquePassManagerBuilder ptr
declare function LLVMPassManagerBuilderCreate() as LLVMPassManagerBuilderRef
declare sub LLVMPassManagerBuilderDispose(byval PMB as LLVMPassManagerBuilderRef)
declare sub LLVMPassManagerBuilderSetOptLevel(byval PMB as LLVMPassManagerBuilderRef, byval OptLevel as ulong)
declare sub LLVMPassManagerBuilderSetSizeLevel(byval PMB as LLVMPassManagerBuilderRef, byval SizeLevel as ulong)
declare sub LLVMPassManagerBuilderSetDisableUnitAtATime(byval PMB as LLVMPassManagerBuilderRef, byval Value as LLVMBool)
declare sub LLVMPassManagerBuilderSetDisableUnrollLoops(byval PMB as LLVMPassManagerBuilderRef, byval Value as LLVMBool)
declare sub LLVMPassManagerBuilderSetDisableSimplifyLibCalls(byval PMB as LLVMPassManagerBuilderRef, byval Value as LLVMBool)
declare sub LLVMPassManagerBuilderUseInlinerWithThreshold(byval PMB as LLVMPassManagerBuilderRef, byval Threshold as ulong)
declare sub LLVMPassManagerBuilderPopulateFunctionPassManager(byval PMB as LLVMPassManagerBuilderRef, byval PM as LLVMPassManagerRef)
declare sub LLVMPassManagerBuilderPopulateModulePassManager(byval PMB as LLVMPassManagerBuilderRef, byval PM as LLVMPassManagerRef)
declare sub LLVMPassManagerBuilderPopulateLTOPassManager(byval PMB as LLVMPassManagerBuilderRef, byval PM as LLVMPassManagerRef, byval Internalize as LLVMBool, byval RunInliner as LLVMBool)
#define LLVM_C_TRANSFORMS_SCALAR_H
declare sub LLVMAddAggressiveDCEPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddBitTrackingDCEPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddAlignmentFromAssumptionsPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddCFGSimplificationPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddLateCFGSimplificationPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddDeadStoreEliminationPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddScalarizerPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddMergedLoadStoreMotionPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddGVNPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddNewGVNPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddIndVarSimplifyPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddInstructionCombiningPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddJumpThreadingPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddLICMPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddLoopDeletionPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddLoopIdiomPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddLoopRotatePass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddLoopRerollPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddLoopUnrollPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddLoopUnswitchPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddMemCpyOptPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddPartiallyInlineLibCallsPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddLowerSwitchPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddPromoteMemoryToRegisterPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddReassociatePass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddSCCPPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddScalarReplAggregatesPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddScalarReplAggregatesPassSSA(byval PM as LLVMPassManagerRef)
declare sub LLVMAddScalarReplAggregatesPassWithThreshold(byval PM as LLVMPassManagerRef, byval Threshold as long)
declare sub LLVMAddSimplifyLibCallsPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddTailCallEliminationPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddConstantPropagationPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddDemoteMemoryToRegisterPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddVerifierPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddCorrelatedValuePropagationPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddEarlyCSEPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddEarlyCSEMemSSAPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddLowerExpectIntrinsicPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddTypeBasedAliasAnalysisPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddScopedNoAliasAAPass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddBasicAliasAnalysisPass(byval PM as LLVMPassManagerRef)
#define LLVM_C_TRANSFORMS_VECTORIZE_H
declare sub LLVMAddBBVectorizePass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddLoopVectorizePass(byval PM as LLVMPassManagerRef)
declare sub LLVMAddSLPVectorizePass(byval PM as LLVMPassManagerRef)
#define LLVM_C_LTO_H
type lto_bool_t as byte
const LTO_API_VERSION_ = 21

type lto_symbol_attributes as long
enum
	LTO_SYMBOL_ALIGNMENT_MASK = &h0000001F
	LTO_SYMBOL_PERMISSIONS_MASK = &h000000E0
	LTO_SYMBOL_PERMISSIONS_CODE = &h000000A0
	LTO_SYMBOL_PERMISSIONS_DATA = &h000000C0
	LTO_SYMBOL_PERMISSIONS_RODATA = &h00000080
	LTO_SYMBOL_DEFINITION_MASK = &h00000700
	LTO_SYMBOL_DEFINITION_REGULAR = &h00000100
	LTO_SYMBOL_DEFINITION_TENTATIVE = &h00000200
	LTO_SYMBOL_DEFINITION_WEAK = &h00000300
	LTO_SYMBOL_DEFINITION_UNDEFINED = &h00000400
	LTO_SYMBOL_DEFINITION_WEAKUNDEF = &h00000500
	LTO_SYMBOL_SCOPE_MASK = &h00003800
	LTO_SYMBOL_SCOPE_INTERNAL = &h00000800
	LTO_SYMBOL_SCOPE_HIDDEN = &h00001000
	LTO_SYMBOL_SCOPE_PROTECTED = &h00002000
	LTO_SYMBOL_SCOPE_DEFAULT = &h00001800
	LTO_SYMBOL_SCOPE_DEFAULT_CAN_BE_HIDDEN = &h00002800
	LTO_SYMBOL_COMDAT = &h00004000
	LTO_SYMBOL_ALIAS = &h00008000
end enum

type lto_debug_model as long
enum
	LTO_DEBUG_MODEL_NONE = 0
	LTO_DEBUG_MODEL_DWARF = 1
end enum

type lto_codegen_model as long
enum
	LTO_CODEGEN_PIC_MODEL_STATIC = 0
	LTO_CODEGEN_PIC_MODEL_DYNAMIC = 1
	LTO_CODEGEN_PIC_MODEL_DYNAMIC_NO_PIC = 2
	LTO_CODEGEN_PIC_MODEL_DEFAULT = 3
end enum

type lto_module_t as LLVMOpaqueLTOModule ptr
type lto_code_gen_t as LLVMOpaqueLTOCodeGenerator ptr
type thinlto_code_gen_t as LLVMOpaqueThinLTOCodeGenerator ptr

declare function lto_get_version() as const zstring ptr
declare function lto_get_error_message() as const zstring ptr
declare function lto_module_is_object_file(byval path as const zstring ptr) as lto_bool_t
declare function lto_module_is_object_file_for_target(byval path as const zstring ptr, byval target_triple_prefix as const zstring ptr) as lto_bool_t
declare function lto_module_has_objc_category(byval mem as const any ptr, byval length as uinteger) as lto_bool_t
declare function lto_module_is_object_file_in_memory(byval mem as const any ptr, byval length as uinteger) as lto_bool_t
declare function lto_module_is_object_file_in_memory_for_target(byval mem as const any ptr, byval length as uinteger, byval target_triple_prefix as const zstring ptr) as lto_bool_t
declare function lto_module_create(byval path as const zstring ptr) as lto_module_t
declare function lto_module_create_from_memory(byval mem as const any ptr, byval length as uinteger) as lto_module_t
declare function lto_module_create_from_memory_with_path(byval mem as const any ptr, byval length as uinteger, byval path as const zstring ptr) as lto_module_t
declare function lto_module_create_in_local_context(byval mem as const any ptr, byval length as uinteger, byval path as const zstring ptr) as lto_module_t
declare function lto_module_create_in_codegen_context(byval mem as const any ptr, byval length as uinteger, byval path as const zstring ptr, byval cg as lto_code_gen_t) as lto_module_t
declare function lto_module_create_from_fd(byval fd as long, byval path as const zstring ptr, byval file_size as uinteger) as lto_module_t
#ifdef __FB_WIN32__
	declare function lto_module_create_from_fd_at_offset(byval fd as long, byval path as const zstring ptr, byval file_size as uinteger, byval map_size as uinteger, byval offset as _off_t) as lto_module_t
#else
	declare function lto_module_create_from_fd_at_offset(byval fd as long, byval path as const zstring ptr, byval file_size as uinteger, byval map_size as uinteger, byval offset as off_t) as lto_module_t
#endif
declare sub lto_module_dispose(byval mod_ as lto_module_t)
declare function lto_module_get_target_triple(byval mod_ as lto_module_t) as const zstring ptr
declare sub lto_module_set_target_triple(byval mod_ as lto_module_t, byval triple as const zstring ptr)
declare function lto_module_get_num_symbols(byval mod_ as lto_module_t) as ulong
declare function lto_module_get_symbol_name(byval mod_ as lto_module_t, byval index as ulong) as const zstring ptr
declare function lto_module_get_symbol_attribute(byval mod_ as lto_module_t, byval index as ulong) as lto_symbol_attributes
declare function lto_module_get_linkeropts(byval mod_ as lto_module_t) as const zstring ptr

type lto_codegen_diagnostic_severity_t as long
enum
	LTO_DS_ERROR = 0
	LTO_DS_WARNING = 1
	LTO_DS_REMARK = 3
	LTO_DS_NOTE = 2
end enum

type lto_diagnostic_handler_t as sub(byval severity as lto_codegen_diagnostic_severity_t, byval diag as const zstring ptr, byval ctxt as any ptr)
declare sub lto_codegen_set_diagnostic_handler(byval as lto_code_gen_t, byval as lto_diagnostic_handler_t, byval as any ptr)
declare function lto_codegen_create() as lto_code_gen_t
declare function lto_codegen_create_in_local_context() as lto_code_gen_t
declare sub lto_codegen_dispose(byval as lto_code_gen_t)
declare function lto_codegen_add_module(byval cg as lto_code_gen_t, byval mod_ as lto_module_t) as lto_bool_t
declare sub lto_codegen_set_module(byval cg as lto_code_gen_t, byval mod_ as lto_module_t)
declare function lto_codegen_set_debug_model(byval cg as lto_code_gen_t, byval as lto_debug_model) as lto_bool_t
declare function lto_codegen_set_pic_model(byval cg as lto_code_gen_t, byval as lto_codegen_model) as lto_bool_t
declare sub lto_codegen_set_cpu(byval cg as lto_code_gen_t, byval cpu as const zstring ptr)
declare sub lto_codegen_set_assembler_path(byval cg as lto_code_gen_t, byval path as const zstring ptr)
declare sub lto_codegen_set_assembler_args(byval cg as lto_code_gen_t, byval args as const zstring ptr ptr, byval nargs as long)
declare sub lto_codegen_add_must_preserve_symbol(byval cg as lto_code_gen_t, byval symbol as const zstring ptr)
declare function lto_codegen_write_merged_modules(byval cg as lto_code_gen_t, byval path as const zstring ptr) as lto_bool_t
declare function lto_codegen_compile(byval cg as lto_code_gen_t, byval length as uinteger ptr) as const any ptr
declare function lto_codegen_compile_to_file(byval cg as lto_code_gen_t, byval name as const zstring ptr ptr) as lto_bool_t
declare function lto_codegen_optimize(byval cg as lto_code_gen_t) as lto_bool_t
declare function lto_codegen_compile_optimized(byval cg as lto_code_gen_t, byval length as uinteger ptr) as const any ptr
declare function lto_api_version() as ulong
declare sub lto_codegen_debug_options(byval cg as lto_code_gen_t, byval as const zstring ptr)
declare sub lto_initialize_disassembler()
declare sub lto_codegen_set_should_internalize(byval cg as lto_code_gen_t, byval ShouldInternalize as lto_bool_t)
declare sub lto_codegen_set_should_embed_uselists(byval cg as lto_code_gen_t, byval ShouldEmbedUselists as lto_bool_t)

type LTOObjectBuffer
	Buffer as const zstring ptr
	Size as uinteger
end type

declare function thinlto_create_codegen() as thinlto_code_gen_t
declare sub thinlto_codegen_dispose(byval cg as thinlto_code_gen_t)
declare sub thinlto_codegen_add_module(byval cg as thinlto_code_gen_t, byval identifier as const zstring ptr, byval data as const zstring ptr, byval length as long)
declare sub thinlto_codegen_process(byval cg as thinlto_code_gen_t)
declare function thinlto_module_get_num_objects(byval cg as thinlto_code_gen_t) as ulong
declare function thinlto_module_get_object(byval cg as thinlto_code_gen_t, byval index as ulong) as LTOObjectBuffer
declare function thinlto_module_get_num_object_files(byval cg as thinlto_code_gen_t) as ulong
declare function thinlto_module_get_object_file(byval cg as thinlto_code_gen_t, byval index as ulong) as const zstring ptr
declare function thinlto_codegen_set_pic_model(byval cg as thinlto_code_gen_t, byval as lto_codegen_model) as lto_bool_t
declare sub thinlto_codegen_set_savetemps_dir(byval cg as thinlto_code_gen_t, byval save_temps_dir as const zstring ptr)
declare sub thinlto_set_generated_objects_dir(byval cg as thinlto_code_gen_t, byval save_temps_dir as const zstring ptr)
declare sub thinlto_codegen_set_cpu(byval cg as thinlto_code_gen_t, byval cpu as const zstring ptr)
declare sub thinlto_codegen_disable_codegen(byval cg as thinlto_code_gen_t, byval disable as lto_bool_t)
declare sub thinlto_codegen_set_codegen_only(byval cg as thinlto_code_gen_t, byval codegen_only as lto_bool_t)
declare sub thinlto_debug_options(byval options as const zstring const ptr ptr, byval number as long)
declare function lto_module_is_thinlto(byval mod_ as lto_module_t) as lto_bool_t
declare sub thinlto_codegen_add_must_preserve_symbol(byval cg as thinlto_code_gen_t, byval name as const zstring ptr, byval length as long)
declare sub thinlto_codegen_add_cross_referenced_symbol(byval cg as thinlto_code_gen_t, byval name as const zstring ptr, byval length as long)
declare sub thinlto_codegen_set_cache_dir(byval cg as thinlto_code_gen_t, byval cache_dir as const zstring ptr)
declare sub thinlto_codegen_set_cache_pruning_interval(byval cg as thinlto_code_gen_t, byval interval as long)
declare sub thinlto_codegen_set_final_cache_size_relative_to_available_space(byval cg as thinlto_code_gen_t, byval percentage as ulong)
declare sub thinlto_codegen_set_cache_entry_expiration(byval cg as thinlto_code_gen_t, byval expiration as ulong)

end extern
