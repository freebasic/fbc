'' FreeBASIC binding for llvm-3.5.0.src
''
'' based on the C header files:
''   University of Illinois/NCSA
''   Open Source License
''
''   Copyright (c) 2003-2014 University of Illinois at Urbana-Champaign.
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
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/math.bi"
#include once "crt/stdint.bi"
#include once "crt/sys/types.bi"
#include once "crt/stddef.bi"

extern "C"

#define LLVM_C_ANALYSIS_H
#define LLVM_C_CORE_H
#define LLVM_C_SUPPORT_H
#define SUPPORT_DATATYPES_H
type LLVMBool as long
type LLVMMemoryBufferRef as LLVMOpaqueMemoryBuffer ptr
declare function LLVMLoadLibraryPermanently(byval Filename as const zstring ptr) as LLVMBool

type LLVMContextRef as LLVMOpaqueContext ptr
type LLVMModuleRef as LLVMOpaqueModule ptr
type LLVMTypeRef as LLVMOpaqueType ptr
type LLVMValueRef as LLVMOpaqueValue ptr
type LLVMBasicBlockRef as LLVMOpaqueBasicBlock ptr
type LLVMBuilderRef as LLVMOpaqueBuilder ptr
type LLVMModuleProviderRef as LLVMOpaqueModuleProvider ptr
type LLVMPassManagerRef as LLVMOpaquePassManager ptr
type LLVMPassRegistryRef as LLVMOpaquePassRegistry ptr
type LLVMUseRef as LLVMOpaqueUse ptr
type LLVMDiagnosticInfoRef as LLVMOpaqueDiagnosticInfo ptr

type LLVMAttribute as long
enum
	LLVMZExtAttribute = 1 shl 0
	LLVMSExtAttribute = 1 shl 1
	LLVMNoReturnAttribute = 1 shl 2
	LLVMInRegAttribute = 1 shl 3
	LLVMStructRetAttribute = 1 shl 4
	LLVMNoUnwindAttribute = 1 shl 5
	LLVMNoAliasAttribute = 1 shl 6
	LLVMByValAttribute = 1 shl 7
	LLVMNestAttribute = 1 shl 8
	LLVMReadNoneAttribute = 1 shl 9
	LLVMReadOnlyAttribute = 1 shl 10
	LLVMNoInlineAttribute = 1 shl 11
	LLVMAlwaysInlineAttribute = 1 shl 12
	LLVMOptimizeForSizeAttribute = 1 shl 13
	LLVMStackProtectAttribute = 1 shl 14
	LLVMStackProtectReqAttribute = 1 shl 15
	LLVMAlignment = 31 shl 16
	LLVMNoCaptureAttribute = 1 shl 21
	LLVMNoRedZoneAttribute = 1 shl 22
	LLVMNoImplicitFloatAttribute = 1 shl 23
	LLVMNakedAttribute = 1 shl 24
	LLVMInlineHintAttribute = 1 shl 25
	LLVMStackAlignment = 7 shl 26
	LLVMReturnsTwice = 1 shl 29
	LLVMUWTable = 1 shl 30
	LLVMNonLazyBind = 1 shl 31
end enum

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

declare sub LLVMShutdown()
declare function LLVMCreateMessage(byval Message as const zstring ptr) as zstring ptr
declare sub LLVMDisposeMessage(byval Message as zstring ptr)
type LLVMFatalErrorHandler as sub(byval Reason as const zstring ptr)
declare sub LLVMInstallFatalErrorHandler(byval Handler as LLVMFatalErrorHandler)
declare sub LLVMResetFatalErrorHandler()
declare sub LLVMEnablePrettyStackTrace()
type LLVMDiagnosticHandler as sub(byval as LLVMDiagnosticInfoRef, byval as any ptr)
type LLVMYieldCallback as sub(byval as LLVMContextRef, byval as any ptr)
declare function LLVMContextCreate() as LLVMContextRef
declare function LLVMGetGlobalContext() as LLVMContextRef
declare sub LLVMContextSetDiagnosticHandler(byval C as LLVMContextRef, byval Handler as LLVMDiagnosticHandler, byval DiagnosticContext as any ptr)
declare sub LLVMContextSetYieldCallback(byval C as LLVMContextRef, byval Callback as LLVMYieldCallback, byval OpaqueHandle as any ptr)
declare sub LLVMContextDispose(byval C as LLVMContextRef)
declare function LLVMGetDiagInfoDescription(byval DI as LLVMDiagnosticInfoRef) as zstring ptr
declare function LLVMGetDiagInfoSeverity(byval DI as LLVMDiagnosticInfoRef) as LLVMDiagnosticSeverity
declare function LLVMGetMDKindIDInContext(byval C as LLVMContextRef, byval Name as const zstring ptr, byval SLen as ulong) as ulong
declare function LLVMGetMDKindID(byval Name as const zstring ptr, byval SLen as ulong) as ulong
declare function LLVMModuleCreateWithName(byval ModuleID as const zstring ptr) as LLVMModuleRef
declare function LLVMModuleCreateWithNameInContext(byval ModuleID as const zstring ptr, byval C as LLVMContextRef) as LLVMModuleRef
declare sub LLVMDisposeModule(byval M as LLVMModuleRef)
declare function LLVMGetDataLayout(byval M as LLVMModuleRef) as const zstring ptr
declare sub LLVMSetDataLayout(byval M as LLVMModuleRef, byval Triple as const zstring ptr)
declare function LLVMGetTarget(byval M as LLVMModuleRef) as const zstring ptr
declare sub LLVMSetTarget(byval M as LLVMModuleRef, byval Triple as const zstring ptr)
declare sub LLVMDumpModule(byval M as LLVMModuleRef)
declare function LLVMPrintModuleToFile(byval M as LLVMModuleRef, byval Filename as const zstring ptr, byval ErrorMessage as zstring ptr ptr) as LLVMBool
declare function LLVMPrintModuleToString(byval M as LLVMModuleRef) as zstring ptr
declare sub LLVMSetModuleInlineAsm(byval M as LLVMModuleRef, byval Asm as const zstring ptr)
declare function LLVMGetModuleContext(byval M as LLVMModuleRef) as LLVMContextRef
declare function LLVMGetTypeByName(byval M as LLVMModuleRef, byval Name as const zstring ptr) as LLVMTypeRef
declare function LLVMGetNamedMetadataNumOperands(byval M as LLVMModuleRef, byval name as const zstring ptr) as ulong
declare sub LLVMGetNamedMetadataOperands(byval M as LLVMModuleRef, byval name as const zstring ptr, byval Dest as LLVMValueRef ptr)
declare sub LLVMAddNamedMetadataOperand(byval M as LLVMModuleRef, byval name as const zstring ptr, byval Val as LLVMValueRef)
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
declare function LLVMIntTypeInContext(byval C as LLVMContextRef, byval NumBits as ulong) as LLVMTypeRef
declare function LLVMInt1Type() as LLVMTypeRef
declare function LLVMInt8Type() as LLVMTypeRef
declare function LLVMInt16Type() as LLVMTypeRef
declare function LLVMInt32Type() as LLVMTypeRef
declare function LLVMInt64Type() as LLVMTypeRef
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
declare function LLVMIsPackedStruct(byval StructTy as LLVMTypeRef) as LLVMBool
declare function LLVMIsOpaqueStruct(byval StructTy as LLVMTypeRef) as LLVMBool
declare function LLVMGetElementType(byval Ty as LLVMTypeRef) as LLVMTypeRef
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
declare function LLVMIsAMDNode(byval Val as LLVMValueRef) as LLVMValueRef
declare function LLVMIsAMDString(byval Val as LLVMValueRef) as LLVMValueRef
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
declare function LLVMGetFirstUse(byval Val as LLVMValueRef) as LLVMUseRef
declare function LLVMGetNextUse(byval U as LLVMUseRef) as LLVMUseRef
declare function LLVMGetUser(byval U as LLVMUseRef) as LLVMValueRef
declare function LLVMGetUsedValue(byval U as LLVMUseRef) as LLVMValueRef
declare function LLVMGetOperand(byval Val as LLVMValueRef, byval Index as ulong) as LLVMValueRef
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
declare function LLVMConstStringInContext(byval C as LLVMContextRef, byval Str as const zstring ptr, byval Length as ulong, byval DontNullTerminate as LLVMBool) as LLVMValueRef
declare function LLVMConstString(byval Str as const zstring ptr, byval Length as ulong, byval DontNullTerminate as LLVMBool) as LLVMValueRef
declare function LLVMConstStructInContext(byval C as LLVMContextRef, byval ConstantVals as LLVMValueRef ptr, byval Count as ulong, byval Packed as LLVMBool) as LLVMValueRef
declare function LLVMConstStruct(byval ConstantVals as LLVMValueRef ptr, byval Count as ulong, byval Packed as LLVMBool) as LLVMValueRef
declare function LLVMConstArray(byval ElementTy as LLVMTypeRef, byval ConstantVals as LLVMValueRef ptr, byval Length as ulong) as LLVMValueRef
declare function LLVMConstNamedStruct(byval StructTy as LLVMTypeRef, byval ConstantVals as LLVMValueRef ptr, byval Count as ulong) as LLVMValueRef
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
declare function LLVMGetIntrinsicID(byval Fn as LLVMValueRef) as ulong
declare function LLVMGetFunctionCallConv(byval Fn as LLVMValueRef) as ulong
declare sub LLVMSetFunctionCallConv(byval Fn as LLVMValueRef, byval CC as ulong)
declare function LLVMGetGC(byval Fn as LLVMValueRef) as const zstring ptr
declare sub LLVMSetGC(byval Fn as LLVMValueRef, byval Name as const zstring ptr)
declare sub LLVMAddFunctionAttr(byval Fn as LLVMValueRef, byval PA as LLVMAttribute)
declare sub LLVMAddTargetDependentFunctionAttr(byval Fn as LLVMValueRef, byval A as const zstring ptr, byval V as const zstring ptr)
declare function LLVMGetFunctionAttr(byval Fn as LLVMValueRef) as LLVMAttribute
declare sub LLVMRemoveFunctionAttr(byval Fn as LLVMValueRef, byval PA as LLVMAttribute)
declare function LLVMCountParams(byval Fn as LLVMValueRef) as ulong
declare sub LLVMGetParams(byval Fn as LLVMValueRef, byval Params as LLVMValueRef ptr)
declare function LLVMGetParam(byval Fn as LLVMValueRef, byval Index as ulong) as LLVMValueRef
declare function LLVMGetParamParent(byval Inst as LLVMValueRef) as LLVMValueRef
declare function LLVMGetFirstParam(byval Fn as LLVMValueRef) as LLVMValueRef
declare function LLVMGetLastParam(byval Fn as LLVMValueRef) as LLVMValueRef
declare function LLVMGetNextParam(byval Arg as LLVMValueRef) as LLVMValueRef
declare function LLVMGetPreviousParam(byval Arg as LLVMValueRef) as LLVMValueRef
declare sub LLVMAddAttribute(byval Arg as LLVMValueRef, byval PA as LLVMAttribute)
declare sub LLVMRemoveAttribute(byval Arg as LLVMValueRef, byval PA as LLVMAttribute)
declare function LLVMGetAttribute(byval Arg as LLVMValueRef) as LLVMAttribute
declare sub LLVMSetParamAlignment(byval Arg as LLVMValueRef, byval align as ulong)
declare function LLVMMDStringInContext(byval C as LLVMContextRef, byval Str as const zstring ptr, byval SLen as ulong) as LLVMValueRef
declare function LLVMMDString(byval Str as const zstring ptr, byval SLen as ulong) as LLVMValueRef
declare function LLVMMDNodeInContext(byval C as LLVMContextRef, byval Vals as LLVMValueRef ptr, byval Count as ulong) as LLVMValueRef
declare function LLVMMDNode(byval Vals as LLVMValueRef ptr, byval Count as ulong) as LLVMValueRef
declare function LLVMGetMDString(byval V as LLVMValueRef, byval Len as ulong ptr) as const zstring ptr
declare function LLVMGetMDNodeNumOperands(byval V as LLVMValueRef) as ulong
declare sub LLVMGetMDNodeOperands(byval V as LLVMValueRef, byval Dest as LLVMValueRef ptr)
declare function LLVMBasicBlockAsValue(byval BB as LLVMBasicBlockRef) as LLVMValueRef
declare function LLVMValueIsBasicBlock(byval Val as LLVMValueRef) as LLVMBool
declare function LLVMValueAsBasicBlock(byval Val as LLVMValueRef) as LLVMBasicBlockRef
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
declare sub LLVMInstructionEraseFromParent(byval Inst as LLVMValueRef)
declare function LLVMGetInstructionOpcode(byval Inst as LLVMValueRef) as LLVMOpcode
declare function LLVMGetICmpPredicate(byval Inst as LLVMValueRef) as LLVMIntPredicate
declare sub LLVMSetInstructionCallConv(byval Instr as LLVMValueRef, byval CC as ulong)
declare function LLVMGetInstructionCallConv(byval Instr as LLVMValueRef) as ulong
declare sub LLVMAddInstrAttribute(byval Instr as LLVMValueRef, byval index as ulong, byval as LLVMAttribute)
declare sub LLVMRemoveInstrAttribute(byval Instr as LLVMValueRef, byval index as ulong, byval as LLVMAttribute)
declare sub LLVMSetInstrParamAlignment(byval Instr as LLVMValueRef, byval index as ulong, byval align as ulong)
declare function LLVMIsTailCall(byval CallInst as LLVMValueRef) as LLVMBool
declare sub LLVMSetTailCall(byval CallInst as LLVMValueRef, byval IsTailCall as LLVMBool)
declare function LLVMGetSwitchDefaultDest(byval SwitchInstr as LLVMValueRef) as LLVMBasicBlockRef
declare sub LLVMAddIncoming(byval PhiNode as LLVMValueRef, byval IncomingValues as LLVMValueRef ptr, byval IncomingBlocks as LLVMBasicBlockRef ptr, byval Count as ulong)
declare function LLVMCountIncoming(byval PhiNode as LLVMValueRef) as ulong
declare function LLVMGetIncomingValue(byval PhiNode as LLVMValueRef, byval Index as ulong) as LLVMValueRef
declare function LLVMGetIncomingBlock(byval PhiNode as LLVMValueRef, byval Index as ulong) as LLVMBasicBlockRef
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
declare sub LLVMAddClause(byval LandingPad as LLVMValueRef, byval ClauseVal as LLVMValueRef)
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
declare function LLVMBuildStore(byval as LLVMBuilderRef, byval Val as LLVMValueRef, byval Ptr as LLVMValueRef) as LLVMValueRef
declare function LLVMBuildGEP(byval B as LLVMBuilderRef, byval Pointer as LLVMValueRef, byval Indices as LLVMValueRef ptr, byval NumIndices as ulong, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildInBoundsGEP(byval B as LLVMBuilderRef, byval Pointer as LLVMValueRef, byval Indices as LLVMValueRef ptr, byval NumIndices as ulong, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildStructGEP(byval B as LLVMBuilderRef, byval Pointer as LLVMValueRef, byval Idx as ulong, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildGlobalString(byval B as LLVMBuilderRef, byval Str as const zstring ptr, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMBuildGlobalStringPtr(byval B as LLVMBuilderRef, byval Str as const zstring ptr, byval Name as const zstring ptr) as LLVMValueRef
declare function LLVMGetVolatile(byval MemoryAccessInst as LLVMValueRef) as LLVMBool
declare sub LLVMSetVolatile(byval MemoryAccessInst as LLVMValueRef, byval IsVolatile as LLVMBool)
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
#define LLVM_C_BITCODEREADER_H
declare function LLVMParseBitcode(byval MemBuf as LLVMMemoryBufferRef, byval OutModule as LLVMModuleRef ptr, byval OutMessage as zstring ptr ptr) as LLVMBool
declare function LLVMParseBitcodeInContext(byval ContextRef as LLVMContextRef, byval MemBuf as LLVMMemoryBufferRef, byval OutModule as LLVMModuleRef ptr, byval OutMessage as zstring ptr ptr) as LLVMBool
declare function LLVMGetBitcodeModuleInContext(byval ContextRef as LLVMContextRef, byval MemBuf as LLVMMemoryBufferRef, byval OutM as LLVMModuleRef ptr, byval OutMessage as zstring ptr ptr) as LLVMBool
declare function LLVMGetBitcodeModule(byval MemBuf as LLVMMemoryBufferRef, byval OutM as LLVMModuleRef ptr, byval OutMessage as zstring ptr ptr) as LLVMBool
declare function LLVMGetBitcodeModuleProviderInContext(byval ContextRef as LLVMContextRef, byval MemBuf as LLVMMemoryBufferRef, byval OutMP as LLVMModuleProviderRef ptr, byval OutMessage as zstring ptr ptr) as LLVMBool
declare function LLVMGetBitcodeModuleProvider(byval MemBuf as LLVMMemoryBufferRef, byval OutMP as LLVMModuleProviderRef ptr, byval OutMessage as zstring ptr ptr) as LLVMBool
#define LLVM_C_BITCODEWRITER_H
declare function LLVMWriteBitcodeToFile(byval M as LLVMModuleRef, byval Path as const zstring ptr) as long
declare function LLVMWriteBitcodeToFD(byval M as LLVMModuleRef, byval FD as long, byval ShouldClose as long, byval Unbuffered as long) as long
declare function LLVMWriteBitcodeToFileHandle(byval M as LLVMModuleRef, byval Handle as long) as long
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
#define LLVM_BINDIR "/usr/bin"
#define LLVM_CONFIGTIME "Fri Apr 17 18:48:11 CEST 2015"
#define LLVM_DATADIR "/usr/share/llvm"
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
#define LLVM_DOCSDIR "/usr/share/doc/llvm"
const LLVM_ENABLE_THREADS = 1
#define LLVM_ETCDIR "/usr/etc/llvm"
const LLVM_HAS_ATOMICS = 1
#define LLVM_HOST_TRIPLE LLVM_DEFAULT_TARGET_TRIPLE
#define LLVM_INCLUDEDIR "/usr/include"
#define LLVM_INFODIR "/usr/info"
#define LLVM_MANDIR "/usr/man"
#define LLVM_NATIVE_ARCH X86
#define LLVM_NATIVE_ASMPARSER LLVMInitializeX86AsmParser
#define LLVM_NATIVE_ASMPRINTER LLVMInitializeX86AsmPrinter
#define LLVM_NATIVE_DISASSEMBLER LLVMInitializeX86Disassembler
#define LLVM_NATIVE_TARGET LLVMInitializeX86Target
#define LLVM_NATIVE_TARGETINFO LLVMInitializeX86TargetInfo
#define LLVM_NATIVE_TARGETMC LLVMInitializeX86TargetMC
#ifdef __FB_UNIX__
	const LLVM_ON_UNIX = 1
#endif
#define LLVM_PREFIX "/usr"
const LLVM_USE_INTEL_JITEVENTS = 0
const LLVM_USE_OPROFILE = 0
const LLVM_VERSION_MAJOR = 3
const LLVM_VERSION_MINOR = 5

type LLVMByteOrdering as long
enum
	LLVMBigEndian
	LLVMLittleEndian
end enum

type LLVMTargetDataRef as LLVMOpaqueTargetData ptr
type LLVMTargetLibraryInfoRef as LLVMOpaqueTargetLibraryInfotData ptr
declare sub LLVMInitializeR600TargetInfo()
declare sub LLVMInitializeSystemZTargetInfo()
declare sub LLVMInitializeHexagonTargetInfo()
declare sub LLVMInitializeNVPTXTargetInfo()
declare sub LLVMInitializeCppBackendTargetInfo()
declare sub LLVMInitializeMSP430TargetInfo()
declare sub LLVMInitializeXCoreTargetInfo()
declare sub LLVMInitializeMipsTargetInfo()
declare sub LLVMInitializeAArch64TargetInfo()
declare sub LLVMInitializeARMTargetInfo()
declare sub LLVMInitializePowerPCTargetInfo()
declare sub LLVMInitializeSparcTargetInfo()
declare sub LLVMInitializeX86TargetInfo()
declare sub LLVMInitializeR600Target()
declare sub LLVMInitializeSystemZTarget()
declare sub LLVMInitializeHexagonTarget()
declare sub LLVMInitializeNVPTXTarget()
declare sub LLVMInitializeCppBackendTarget()
declare sub LLVMInitializeMSP430Target()
declare sub LLVMInitializeXCoreTarget()
declare sub LLVMInitializeMipsTarget()
declare sub LLVMInitializeAArch64Target()
declare sub LLVMInitializeARMTarget()
declare sub LLVMInitializePowerPCTarget()
declare sub LLVMInitializeSparcTarget()
declare sub LLVMInitializeX86Target()
declare sub LLVMInitializeR600TargetMC()
declare sub LLVMInitializeSystemZTargetMC()
declare sub LLVMInitializeHexagonTargetMC()
declare sub LLVMInitializeNVPTXTargetMC()
declare sub LLVMInitializeCppBackendTargetMC()
declare sub LLVMInitializeMSP430TargetMC()
declare sub LLVMInitializeXCoreTargetMC()
declare sub LLVMInitializeMipsTargetMC()
declare sub LLVMInitializeAArch64TargetMC()
declare sub LLVMInitializeARMTargetMC()
declare sub LLVMInitializePowerPCTargetMC()
declare sub LLVMInitializeSparcTargetMC()
declare sub LLVMInitializeX86TargetMC()
declare sub LLVMInitializeR600AsmPrinter()
declare sub LLVMInitializeSystemZAsmPrinter()
declare sub LLVMInitializeHexagonAsmPrinter()
declare sub LLVMInitializeNVPTXAsmPrinter()
declare sub LLVMInitializeMSP430AsmPrinter()
declare sub LLVMInitializeXCoreAsmPrinter()
declare sub LLVMInitializeMipsAsmPrinter()
declare sub LLVMInitializeAArch64AsmPrinter()
declare sub LLVMInitializeARMAsmPrinter()
declare sub LLVMInitializePowerPCAsmPrinter()
declare sub LLVMInitializeSparcAsmPrinter()
declare sub LLVMInitializeX86AsmPrinter()
declare sub LLVMInitializeSystemZAsmParser()
declare sub LLVMInitializeMipsAsmParser()
declare sub LLVMInitializeAArch64AsmParser()
declare sub LLVMInitializeARMAsmParser()
declare sub LLVMInitializePowerPCAsmParser()
declare sub LLVMInitializeSparcAsmParser()
declare sub LLVMInitializeX86AsmParser()
declare sub LLVMInitializeSystemZDisassembler()
declare sub LLVMInitializeXCoreDisassembler()
declare sub LLVMInitializeMipsDisassembler()
declare sub LLVMInitializeAArch64Disassembler()
declare sub LLVMInitializeARMDisassembler()
declare sub LLVMInitializePowerPCDisassembler()
declare sub LLVMInitializeSparcDisassembler()
declare sub LLVMInitializeX86Disassembler()

private sub LLVMInitializeAllTargetInfos()
	LLVMInitializeR600TargetInfo()
	LLVMInitializeSystemZTargetInfo()
	LLVMInitializeHexagonTargetInfo()
	LLVMInitializeNVPTXTargetInfo()
	LLVMInitializeCppBackendTargetInfo()
	LLVMInitializeMSP430TargetInfo()
	LLVMInitializeXCoreTargetInfo()
	LLVMInitializeMipsTargetInfo()
	LLVMInitializeAArch64TargetInfo()
	LLVMInitializeARMTargetInfo()
	LLVMInitializePowerPCTargetInfo()
	LLVMInitializeSparcTargetInfo()
	LLVMInitializeX86TargetInfo()
end sub

private sub LLVMInitializeAllTargets()
	LLVMInitializeR600Target()
	LLVMInitializeSystemZTarget()
	LLVMInitializeHexagonTarget()
	LLVMInitializeNVPTXTarget()
	LLVMInitializeCppBackendTarget()
	LLVMInitializeMSP430Target()
	LLVMInitializeXCoreTarget()
	LLVMInitializeMipsTarget()
	LLVMInitializeAArch64Target()
	LLVMInitializeARMTarget()
	LLVMInitializePowerPCTarget()
	LLVMInitializeSparcTarget()
	LLVMInitializeX86Target()
end sub

private sub LLVMInitializeAllTargetMCs()
	LLVMInitializeR600TargetMC()
	LLVMInitializeSystemZTargetMC()
	LLVMInitializeHexagonTargetMC()
	LLVMInitializeNVPTXTargetMC()
	LLVMInitializeCppBackendTargetMC()
	LLVMInitializeMSP430TargetMC()
	LLVMInitializeXCoreTargetMC()
	LLVMInitializeMipsTargetMC()
	LLVMInitializeAArch64TargetMC()
	LLVMInitializeARMTargetMC()
	LLVMInitializePowerPCTargetMC()
	LLVMInitializeSparcTargetMC()
	LLVMInitializeX86TargetMC()
end sub

private sub LLVMInitializeAllAsmPrinters()
	LLVMInitializeR600AsmPrinter()
	LLVMInitializeSystemZAsmPrinter()
	LLVMInitializeHexagonAsmPrinter()
	LLVMInitializeNVPTXAsmPrinter()
	LLVMInitializeMSP430AsmPrinter()
	LLVMInitializeXCoreAsmPrinter()
	LLVMInitializeMipsAsmPrinter()
	LLVMInitializeAArch64AsmPrinter()
	LLVMInitializeARMAsmPrinter()
	LLVMInitializePowerPCAsmPrinter()
	LLVMInitializeSparcAsmPrinter()
	LLVMInitializeX86AsmPrinter()
end sub

private sub LLVMInitializeAllAsmParsers()
	LLVMInitializeSystemZAsmParser()
	LLVMInitializeMipsAsmParser()
	LLVMInitializeAArch64AsmParser()
	LLVMInitializeARMAsmParser()
	LLVMInitializePowerPCAsmParser()
	LLVMInitializeSparcAsmParser()
	LLVMInitializeX86AsmParser()
end sub

private sub LLVMInitializeAllDisassemblers()
	LLVMInitializeSystemZDisassembler()
	LLVMInitializeXCoreDisassembler()
	LLVMInitializeMipsDisassembler()
	LLVMInitializeAArch64Disassembler()
	LLVMInitializeARMDisassembler()
	LLVMInitializePowerPCDisassembler()
	LLVMInitializeSparcDisassembler()
	LLVMInitializeX86Disassembler()
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

declare function LLVMCreateTargetData(byval StringRep as const zstring ptr) as LLVMTargetDataRef
declare sub LLVMAddTargetData(byval TD as LLVMTargetDataRef, byval PM as LLVMPassManagerRef)
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
declare sub LLVMDisposeTargetData(byval TD as LLVMTargetDataRef)
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
declare function LLVMGetTargetMachineData(byval T as LLVMTargetMachineRef) as LLVMTargetDataRef
declare sub LLVMSetTargetMachineAsmVerbosity(byval T as LLVMTargetMachineRef, byval VerboseAsm as LLVMBool)
declare function LLVMTargetMachineEmitToFile(byval T as LLVMTargetMachineRef, byval M as LLVMModuleRef, byval Filename as zstring ptr, byval codegen as LLVMCodeGenFileType, byval ErrorMessage as zstring ptr ptr) as LLVMBool
declare function LLVMTargetMachineEmitToMemoryBuffer(byval T as LLVMTargetMachineRef, byval M as LLVMModuleRef, byval codegen as LLVMCodeGenFileType, byval ErrorMessage as zstring ptr ptr, byval OutMemBuf as LLVMMemoryBufferRef ptr) as LLVMBool
declare function LLVMGetDefaultTargetTriple() as zstring ptr
declare sub LLVMAddAnalysisPasses(byval T as LLVMTargetMachineRef, byval PM as LLVMPassManagerRef)
declare sub LLVMLinkInJIT()
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
declare function LLVMCreateExecutionEngine(byval OutEE as LLVMExecutionEngineRef ptr, byval MP as LLVMModuleProviderRef, byval OutError as zstring ptr ptr) as LLVMBool
declare function LLVMCreateInterpreter(byval OutInterp as LLVMExecutionEngineRef ptr, byval MP as LLVMModuleProviderRef, byval OutError as zstring ptr ptr) as LLVMBool
declare function LLVMCreateJITCompiler(byval OutJIT as LLVMExecutionEngineRef ptr, byval MP as LLVMModuleProviderRef, byval OptLevel as ulong, byval OutError as zstring ptr ptr) as LLVMBool
declare sub LLVMDisposeExecutionEngine(byval EE as LLVMExecutionEngineRef)
declare sub LLVMRunStaticConstructors(byval EE as LLVMExecutionEngineRef)
declare sub LLVMRunStaticDestructors(byval EE as LLVMExecutionEngineRef)
declare function LLVMRunFunctionAsMain(byval EE as LLVMExecutionEngineRef, byval F as LLVMValueRef, byval ArgC as ulong, byval ArgV as const zstring const ptr ptr, byval EnvP as const zstring const ptr ptr) as long
declare function LLVMRunFunction(byval EE as LLVMExecutionEngineRef, byval F as LLVMValueRef, byval NumArgs as ulong, byval Args as LLVMGenericValueRef ptr) as LLVMGenericValueRef
declare sub LLVMFreeMachineCodeForFunction(byval EE as LLVMExecutionEngineRef, byval F as LLVMValueRef)
declare sub LLVMAddModule(byval EE as LLVMExecutionEngineRef, byval M as LLVMModuleRef)
declare sub LLVMAddModuleProvider(byval EE as LLVMExecutionEngineRef, byval MP as LLVMModuleProviderRef)
declare function LLVMRemoveModule(byval EE as LLVMExecutionEngineRef, byval M as LLVMModuleRef, byval OutMod as LLVMModuleRef ptr, byval OutError as zstring ptr ptr) as LLVMBool
declare function LLVMRemoveModuleProvider(byval EE as LLVMExecutionEngineRef, byval MP as LLVMModuleProviderRef, byval OutMod as LLVMModuleRef ptr, byval OutError as zstring ptr ptr) as LLVMBool
declare function LLVMFindFunction(byval EE as LLVMExecutionEngineRef, byval Name as const zstring ptr, byval OutFn as LLVMValueRef ptr) as LLVMBool
declare function LLVMRecompileAndRelinkFunction(byval EE as LLVMExecutionEngineRef, byval Fn as LLVMValueRef) as any ptr
declare function LLVMGetExecutionEngineTargetData(byval EE as LLVMExecutionEngineRef) as LLVMTargetDataRef
declare function LLVMGetExecutionEngineTargetMachine(byval EE as LLVMExecutionEngineRef) as LLVMTargetMachineRef
declare sub LLVMAddGlobalMapping(byval EE as LLVMExecutionEngineRef, byval Global as LLVMValueRef, byval Addr as any ptr)
declare function LLVMGetPointerToGlobal(byval EE as LLVMExecutionEngineRef, byval Global as LLVMValueRef) as any ptr

type LLVMMemoryManagerAllocateCodeSectionCallback as function(byval Opaque as any ptr, byval Size as uinteger, byval Alignment as ulong, byval SectionID as ulong, byval SectionName as const zstring ptr) as ubyte ptr
type LLVMMemoryManagerAllocateDataSectionCallback as function(byval Opaque as any ptr, byval Size as uinteger, byval Alignment as ulong, byval SectionID as ulong, byval SectionName as const zstring ptr, byval IsReadOnly as LLVMBool) as ubyte ptr
type LLVMMemoryManagerFinalizeMemoryCallback as function(byval Opaque as any ptr, byval ErrMsg as zstring ptr ptr) as LLVMBool
type LLVMMemoryManagerDestroyCallback as sub(byval Opaque as any ptr)
declare function LLVMCreateSimpleMCJITMemoryManager(byval Opaque as any ptr, byval AllocateCodeSection as LLVMMemoryManagerAllocateCodeSectionCallback, byval AllocateDataSection as LLVMMemoryManagerAllocateDataSectionCallback, byval FinalizeMemory as LLVMMemoryManagerFinalizeMemoryCallback, byval Destroy as LLVMMemoryManagerDestroyCallback) as LLVMMCJITMemoryManagerRef
declare sub LLVMDisposeMCJITMemoryManager(byval MM as LLVMMCJITMemoryManagerRef)
#define LLVM_C_INITIALIZEPASSES_H

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
#define LLVM_C_IRREADER_H
declare function LLVMParseIRInContext(byval ContextRef as LLVMContextRef, byval MemBuf as LLVMMemoryBufferRef, byval OutM as LLVMModuleRef ptr, byval OutMessage as zstring ptr ptr) as LLVMBool
#define LLVM_C_LINKER_H

type LLVMLinkerMode as long
enum
	LLVMLinkerDestroySource = 0
	LLVMLinkerPreserveSource = 1
end enum

declare function LLVMLinkModules(byval Dest as LLVMModuleRef, byval Src as LLVMModuleRef, byval Mode as LLVMLinkerMode, byval OutMessage as zstring ptr ptr) as LLVMBool
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
#define LLVM_C_LTO_H
type lto_bool_t as byte
const LTO_API_VERSION = 10

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
declare function lto_get_version() as const zstring ptr
declare function lto_get_error_message() as const zstring ptr
declare function lto_module_is_object_file(byval path as const zstring ptr) as lto_bool_t
declare function lto_module_is_object_file_for_target(byval path as const zstring ptr, byval target_triple_prefix as const zstring ptr) as lto_bool_t
declare function lto_module_is_object_file_in_memory(byval mem as const any ptr, byval length as uinteger) as lto_bool_t
declare function lto_module_is_object_file_in_memory_for_target(byval mem as const any ptr, byval length as uinteger, byval target_triple_prefix as const zstring ptr) as lto_bool_t
declare function lto_module_create(byval path as const zstring ptr) as lto_module_t
declare function lto_module_create_from_memory(byval mem as const any ptr, byval length as uinteger) as lto_module_t
declare function lto_module_create_from_memory_with_path(byval mem as const any ptr, byval length as uinteger, byval path as const zstring ptr) as lto_module_t
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
declare function lto_module_get_num_deplibs(byval mod_ as lto_module_t) as ulong
declare function lto_module_get_deplib(byval mod_ as lto_module_t, byval index as ulong) as const zstring ptr
declare function lto_module_get_num_linkeropts(byval mod_ as lto_module_t) as ulong
declare function lto_module_get_linkeropt(byval mod_ as lto_module_t, byval index as ulong) as const zstring ptr

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
declare sub lto_codegen_dispose(byval as lto_code_gen_t)
declare function lto_codegen_add_module(byval cg as lto_code_gen_t, byval mod_ as lto_module_t) as lto_bool_t
declare function lto_codegen_set_debug_model(byval cg as lto_code_gen_t, byval as lto_debug_model) as lto_bool_t
declare function lto_codegen_set_pic_model(byval cg as lto_code_gen_t, byval as lto_codegen_model) as lto_bool_t
declare sub lto_codegen_set_cpu(byval cg as lto_code_gen_t, byval cpu as const zstring ptr)
declare sub lto_codegen_set_assembler_path(byval cg as lto_code_gen_t, byval path as const zstring ptr)
declare sub lto_codegen_set_assembler_args(byval cg as lto_code_gen_t, byval args as const zstring ptr ptr, byval nargs as long)
declare sub lto_codegen_add_must_preserve_symbol(byval cg as lto_code_gen_t, byval symbol as const zstring ptr)
declare function lto_codegen_write_merged_modules(byval cg as lto_code_gen_t, byval path as const zstring ptr) as lto_bool_t
declare function lto_codegen_compile(byval cg as lto_code_gen_t, byval length as uinteger ptr) as const any ptr
declare function lto_codegen_compile_to_file(byval cg as lto_code_gen_t, byval name as const zstring ptr ptr) as lto_bool_t
declare sub lto_codegen_debug_options(byval cg as lto_code_gen_t, byval as const zstring ptr)
declare sub lto_initialize_disassembler()
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
declare function LLVMGetRelocationAddress(byval RI as LLVMRelocationIteratorRef) as ulongint
declare function LLVMGetRelocationOffset(byval RI as LLVMRelocationIteratorRef) as ulongint
declare function LLVMGetRelocationSymbol(byval RI as LLVMRelocationIteratorRef) as LLVMSymbolIteratorRef
declare function LLVMGetRelocationType(byval RI as LLVMRelocationIteratorRef) as ulongint
declare function LLVMGetRelocationTypeName(byval RI as LLVMRelocationIteratorRef) as const zstring ptr
declare function LLVMGetRelocationValueString(byval RI as LLVMRelocationIteratorRef) as const zstring ptr

end extern
