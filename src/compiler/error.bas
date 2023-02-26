'' error reporting module
''
''

#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "lex.bi"
#include once "parser.bi"
#include once "hash.bi"

type ERRPARAMLOCATION
	'' While an argument location is pushed,
	'' errors will be reported "at parameter N of F()"
	proc            as FBSYMBOL ptr
	tk              as integer
	paramnum        as integer
	paramid         as zstring ptr
end type

type FB_ERRCTX
	inited                  as integer
	cnt                     as integer
	hide_further_messages   as integer
	lastline                as integer
	laststmt                as integer
	undefhash               as THASH                '' undefined symbols
	paramlocations          as TLIST  '' ERRPARAMLOCATION's
end type

type FBWARNING
	level       as integer
	text        as const zstring ptr
end type

declare function hMakeParamDesc _
	( _
		byval msgex as const zstring ptr _
	) as const zstring ptr

''globals
	dim shared errctx as FB_ERRCTX

	dim shared warningMsgs( 1 to FB_WARNINGMSGS-1 ) as FBWARNING = _
	{ _
		( /'FB_WARNINGMSG_PASSINGSCALARASPTR        '/ 2, @"Passing scalar as pointer" ), _
		( /'FB_WARNINGMSG_PASSINGPTRTOSCALAR        '/ 2, @"Passing pointer to scalar" ), _
		( /'FB_WARNINGMSG_PASSINGDIFFPOINTERS       '/ 2, @"Passing different pointer types" ), _
		( /'FB_WARNINGMSG_SUSPICIOUSPTRASSIGN       '/ 2, @"Suspicious pointer assignment" ), _
		( /'FB_WARNINGMSG_IMPLICITCONVERSION        '/ 1, @"Implicit conversion" ), _
		( /'FB_WARNINGMSG_CANNOTEXPORT              '/ 2, @"Cannot export symbol without -export option" ), _
		( /'FB_WARNINGMSG_IDNAMETOOBIG              '/ 2, @"Identifier's name too big, truncated" ), _
		( /'FB_WARNINGMSG_NUMBERTOOBIG              '/ 2, @"Literal number too big, truncated" ), _
		( /'FB_WARNINGMSG_LITSTRINGTOOBIG           '/ 2, @"Literal string too big, truncated" ), _
		( /'FB_WARNINGMSG_POINTERFIELDS             '/ 1, @"UDT with pointer, var-len string, or var-len array fields" ), _
		( /'FB_WARNINGMSG_IMPLICITALLOCATION        '/ 1, @"Implicit variable allocation" ), _
		( /'FB_WARNINGMSG_NOCLOSINGQUOTE            '/ 1, @"Missing closing quote in literal string" ), _
		( /'FB_WARNINGMSG_NOFUNCTIONRESULT          '/ 1, @"Function result was not explicitly set" ), _
		( /'FB_WARNINGMSG_BRANCHCROSSINGLOCALVAR    '/ 2, @"Branch crossing local variable definition" ), _
		( /'FB_WARNINGMSG_NOEXPLICITPARAMMODE       '/ 1, @"No explicit BYREF or BYVAL" ), _
		( /'FB_WARNINGMSG_POSSIBLEESCSEQ            '/ 1, @"Possible escape sequence found in" ), _
		( /'FB_WARNINGMSG_PARAMSIZETOOBIG           '/ 1, @"The type length is too large, consider passing BYREF" ), _
		( /'FB_WARNINGMSG_PARAMLISTSIZETOOBIG       '/ 2, @"The length of the parameters list is too large, consider passing UDT's BYREF" ), _
		( /'FB_WARNINGMSG_ANYINITHASNOEFFECT        '/ 2, @"The ANY initializer has no effect on UDT's with default constructors" ), _
		( /'FB_WARNINGMSG_MIXINGMTMODES             '/ 3, @"Object files or libraries with mixed multithreading (-mt) options" ), _
		( /'FB_WARNINGMSG_MIXINGLANGMODES           '/ 3, @"Object files or libraries with mixed language (-lang) options" ), _
		( /'FB_WARNINGMSG_DELETEANYPTR              '/ 1, @"Deleting ANY pointers is undefined" ), _
		( /'FB_WARNINGMSG_HUGEARRAYONSTACK          '/ 3, @"Array too large for stack, consider making it var-len or SHARED" ), _
		( /'FB_WARNINGMSG_HUGEVARONSTACK            '/ 3, @"Variable too large for stack, consider making it SHARED" ), _
		( /'FB_WARNINGMSG_CONVOVERFLOW              '/ 1, @"Overflow in constant conversion" ), _
		( /'FB_WARNINGMSG_NEXTVARMEANINGLESS        '/ 1, @"Variable following NEXT is meaningless" ), _
		( /'FB_WARNINGMSG_CASTTONONPTR              '/ 1, @"Cast to non-pointer" ), _
		( /'FB_WARNINGMSG_RETURNMETHODMISMATCH      '/ 1, @"Return method mismatch" ), _
		( /'FB_WARNINGMSG_PASSINGPTR                '/ 1, @"Passing Pointer" ), _
		( /'FB_WARNINGMSG_CMDLINEOVERRIDES          '/ 1, @"Command line option overrides directive" ), _
		( /'FB_WARNINGMSG_DIRECTIVEIGNORED          '/ 1, @"Directive ignored after first pass" ), _
		( /'FB_WARNINGMSG_IFFOUNDAFTERELSE          '/ 1, @"'IF' statement found directly after multi-line 'ELSE'" ), _
		( /'FB_WARNINGMSG_SHIFTEXCEEDSBITSINDATATYPE'/ 1, @"Shift value greater than or equal to number of bits in data type" ), _
		( /'FB_WARNINGMSG_BYREFEQAFTERPARENS        '/ 1, @"'=' parsed as equality operator in function argument, not assignment to BYREF function result" ), _
		( /'FB_WARNINGMSG_OPERANDSMIXEDSIGNEDNESS   '/ 1, @"Mixing signed/unsigned operands" ), _
		( /'FB_WARNINGMSG_MISMATCHINGPARAMINIT      '/ 1, @"Mismatching parameter initializer" ), _
		( /'FB_WARNINGMSG_AMBIGIOUSLENSIZEOF        '/ 2, @"" ), _  '' FB_WARNINGMSG_AMBIGIOUSLENSIZEOF
		( /'FB_WARNINGMSG_OPERANDSMIXEDTYPES        '/ 1, @"Suspicious logic operation, mixed boolean and non-boolean operands" ), _
		( /'FB_WARNINGMSG_REDEFINITIONOFINTRINSIC   '/ 1, @"Redefinition of intrinsic" ), _
		( /'FB_WARNINGMSG_CONSTQUALIFIERDISCARDED   '/ 0, @"CONST qualifier discarded" ), _
		( /'FB_WARNINGMSG_RETURNTYPEMISMATCH        '/ 0, @"Return type mismatch" ), _
		( /'FB_WARNINGMSG_CALLINGCONVMISMATCH       '/ 0, @"Calling convention mismatch" ), _
		( /'FB_WARNINGMSG_ARGCNTMISMATCH            '/ 0, @"Argument count mismatch" ), _
		( /'FB_WARNINGMSG_SUFFIXIGNORED             '/ 1, @"Suffix ignored" ), _
		( /'FB_WARNINGMSG_FORENDTOOBIG              '/ 1, @"FOR counter variable is unable to exceed limit value" ), _
		( /'FB_WARNINGMSG_CMDLINEIGNORED            '/ 1, @"#cmdline ignored" ), _
		( /'FB_WARNINGMSG_RESERVEDGLOBALSYMBOL      '/ 1, @"Use of reserved global or backend symbol" ), _
		( /'FB_WARNINGMSG_EXPECTEDDIGIT             '/ 1, @"Expected digit" ), _
		( /'FB_WARNINGMSG_UPCASTDISCARDSINITIALIZER '/ 1, @"Up-casting discards initializer(s)" ) _
	}

	dim shared errorMsgs( 1 to FB_ERRMSGS-1 ) as const zstring ptr => _
	{ _
		/'FB_ERRMSG_ARGCNTMISMATCH                     '/ @"Argument count mismatch", _
		/'FB_ERRMSG_EXPECTEDEOF                        '/ @"Expected End-of-File", _
		/'FB_ERRMSG_EXPECTEDEOL                        '/ @"Expected End-of-Line", _
		/'FB_ERRMSG_DUPDEFINITION                      '/ @"Duplicated definition", _
		/'FB_ERRMSG_EXPECTINGAS                        '/ @"Expected 'AS'", _
		/'FB_ERRMSG_EXPECTEDLPRNT                      '/ @"Expected '('", _
		/'FB_ERRMSG_EXPECTEDRPRNT                      '/ @"Expected ')'", _
		/'FB_ERRMSG_UNDEFINEDSYMBOL                    '/ @"Undefined symbol", _
		/'FB_ERRMSG_EXPECTEDEXPRESSION                 '/ @"Expected expression", _
		/'FB_ERRMSG_EXPECTEDEQ                         '/ @"Expected '='", _
		/'FB_ERRMSG_EXPECTEDCONST                      '/ @"Expected constant", _
		/'FB_ERRMSG_EXPECTEDTO                         '/ @"Expected 'TO'", _
		/'FB_ERRMSG_EXPECTEDNEXT                       '/ @"Expected 'NEXT'", _
		/'FB_ERRMSG_EXPECTEDIDENTIFIER                 '/ @"Expected identifier", _
		/'FB_ERRMSG_EXPECTEDMINUS                      '/ @"Expected '-'", _
		/'FB_ERRMSG_EXPECTEDCOMMA                      '/ @"Expected ','", _
		/'FB_ERRMSG_SYNTAXERROR                        '/ @"Syntax error", _
		/'FB_ERRMSG_ELEMENTNOTDEFINED                  '/ @"Element not defined", _
		/'FB_ERRMSG_EXPECTEDENDTYPE                    '/ @"Expected 'END TYPE' or 'END UNION'", _
		/'FB_ERRMSG_TYPEMISMATCH                       '/ @"Type mismatch", _
		/'FB_ERRMSG_INTERNAL                           '/ @"Internal!", _
		/'FB_ERRMSG_PARAMTYPEMISMATCH                  '/ @"Parameter type mismatch", _
		/'FB_ERRMSG_FILENOTFOUND                       '/ @"File not found", _
		/'FB_ERRMSG_INVALIDDATATYPES                   '/ @"Invalid data types", _
		/'FB_ERRMSG_INVALIDCHARACTER                   '/ @"Invalid character", _
		/'FB_ERRMSG_FILEACCESSERROR                    '/ @"File access error", _
		/'FB_ERRMSG_RECLEVELTOODEEP                    '/ @"Recursion level too deep", _
		/'FB_ERRMSG_EXPECTEDPOINTER                    '/ @"Expected pointer", _
		/'FB_ERRMSG_EXPECTEDLOOP                       '/ @"Expected 'LOOP'", _
		/'FB_ERRMSG_EXPECTEDWEND                       '/ @"Expected 'WEND'", _
		/'FB_ERRMSG_EXPECTEDTHEN                       '/ @"Expected 'THEN'", _
		/'FB_ERRMSG_EXPECTEDENDIF                      '/ @"Expected 'END IF'", _
		/'FB_ERRMSG_ILLEGALEND                         '/ @"Illegal 'END'", _
		/'FB_ERRMSG_EXPECTEDCASE                       '/ @"Expected 'CASE'", _
		/'FB_ERRMSG_EXPECTEDENDSELECT                  '/ @"Expected 'END SELECT'", _
		/'FB_ERRMSG_WRONGDIMENSIONS                    '/ @"Wrong number of dimensions", _
		/'FB_ERRMSG_BOUNDSDIFFERFROMEXTERN             '/ @"Array boundaries do not match the original EXTERN declaration", _
		/'FB_ERRMSG_INNERPROCNOTALLOWED                '/ @"'SUB' or 'FUNCTION' without 'END SUB' or 'END FUNCTION'", _
		/'FB_ERRMSG_EXPECTEDENDSUBORFUNCT              '/ @"Expected 'END SUB' or 'END FUNCTION'", _
		/'FB_ERRMSG_RETURNTYPEMISMATCH                 '/ @"Return type here does not match DECLARE prototype", _
		/'FB_ERRMSG_CALLINGCONVMISMATCH                '/ @"Calling convention does not match DECLARE prototype", _
		/'FB_ERRMSG_VARIABLENOTDECLARED                '/ @"Variable not declared", _
		/'FB_ERRMSG_VARIABLEREQUIRED                   '/ @"Variable required", _
		/'FB_ERRMSG_ILLEGALOUTSIDECOMP                 '/ @"Illegal outside a compound statement", _
		/'FB_ERRMSG_EXPECTEDENDASM                     '/ @"Expected 'END ASM'", _
		/'FB_ERRMSG_PROCNOTDECLARED                    '/ @"Function not declared", _
		/'FB_ERRMSG_EXPECTEDSEMICOLON                  '/ @"Expected ';'", _
		/'FB_ERRMSG_UNDEFINEDLABEL                     '/ @"Undefined label", _
		/'FB_ERRMSG_TOOMANYDIMENSIONS                  '/ @"Too many array dimensions", _
		/'FB_ERRMSG_ARRAYTOOBIG                        '/ @"Array too big", _
		/'FB_ERRMSG_UDTTOOBIG                          '/ @"User Defined Type too big", _
		/'FB_ERRMSG_EXPECTEDSCALAR                     '/ @"Expected scalar counter", _
		/'FB_ERRMSG_ILLEGALOUTSIDEAPROC                '/ @"Illegal outside a CONSTRUCTOR, DESTRUCTOR, FUNCTION, OPERATOR, PROPERTY or SUB block", _
		/'FB_ERRMSG_EXPECTEDDYNAMICARRAY               '/ @"Expected var-len array", _
		/'FB_ERRMSG_CANNOTRETURNFIXLENFROMFUNCTS       '/ @"Fixed-len strings cannot be returned from functions", _
		/'FB_ERRMSG_ARRAYALREADYDIMENSIONED            '/ @"Array already dimensioned", _
		/'FB_ERRMSG_ILLEGALRESUMEERROR                 '/ @"Illegal without the -ex option", _
		/'FB_ERRMSG_PARAMTYPEMISMATCHAT                '/ @"Type mismatch", _
		/'FB_ERRMSG_ILLEGALPARAMSPECAT                 '/ @"Illegal specification", _
		/'FB_ERRMSG_EXPECTEDENDWITH                    '/ @"Expected 'END WITH'", _
		/'FB_ERRMSG_ILLEGALINSIDEASUB                  '/ @"Illegal inside functions", _
		/'FB_ERRMSG_ILLEGALINSIDESELECT                '/ @"Statement in between SELECT and first CASE", _
		/'FB_ERRMSG_EXPECTEDARRAY                      '/ @"Expected array", _
		/'FB_ERRMSG_EXPECTEDLBRACE                     '/ @"Expected '{'", _
		/'FB_ERRMSG_EXPECTEDRBRACE                     '/ @"Expected '}'", _
		/'FB_ERRMSG_EXPECTEDRBRACKET                   '/ @"Expected ']'", _
		/'FB_ERRMSG_TOOMANYEXPRESSIONS                 '/ @"Too many expressions", _
		/'FB_ERRMSG_EXPECTEDRESTYPE                    '/ @"Expected explicit result type", _
		/'FB_ERRMSG_RANGETOOLARGE                      '/ @"Range too large", _
		/'FB_ERRMSG_FORWARDREFNOTALLOWED               '/ @"Forward references not allowed", _
		/'FB_ERRMSG_INCOMPLETETYPE                     '/ @"Incomplete type", _
		/'FB_ERRMSG_ARRAYNOTALLOCATED                  '/ @"Array not dimensioned", _
		/'FB_ERRMSG_EXPECTEDINDEX                      '/ @"Array access, index expected", _
		/'FB_ERRMSG_EXPECTEDENDENUM                    '/ @"Expected 'END ENUM'", _
		/'FB_ERRMSG_CANTINITDYNAMICARRAYS              '/ @"Var-len arrays cannot be initialized", _
		/'FB_ERRMSG_DYNAMICARRAYWITHELLIPSIS           '/ @"'...' ellipsis upper bound given for dynamic array (this is not supported)", _
		/'FB_ERRMSG_ARRAYFIELDWITHELLIPSIS             '/ @"'...' ellipsis upper bound given for array field (this is not supported)", _
		/'FB_ERRMSG_INVALIDBITFIELD                    '/ @"Invalid bitfield", _
		/'FB_ERRMSG_TOOMANYPARAMS                      '/ @"Too many parameters", _
		/'FB_ERRMSG_MACROTEXTTOOLONG                   '/ @"Macro text too long", _
		/'FB_ERRMSG_INVALIDCMDOPTION                   '/ @"Invalid command-line option", _
		/'FB_ERRMSG_DOSWITHNONX86                      '/ @"Selected non-x86 CPU when compiling for DOS", _
		/'FB_ERRMSG_GENGASWITHNONX86                   '/ @"Selected -gen gas|gas64 ASM backend is incompatible with CPU", _
		/'FB_ERRMSG_GENGASWITHOUTINTEL                 '/ @"-asm att used for -gen gas, but -gen gas only supports -asm intel", _
		/'FB_ERRMSG_PICNOTSUPPORTEDFOREXE              '/ @"-pic used when making executable (only works when making a shared library)", _
		/'FB_ERRMSG_PICNOTSUPPORTEDFORTARGET           '/ @"-pic used, but not supported by target system (only works for non-x86 Unixes)", _
		/'FB_ERRMSG_CANTINITDYNAMICSTRINGS             '/ @"Var-len strings cannot be initialized", _
		/'FB_ERRMSG_RECURSIVEUDT                       '/ @"Recursive TYPE or UNION not allowed", _
		/'FB_ERRMSG_RECURSIVEMACRO                     '/ @"Recursive DEFINE not allowed", _
		/'FB_ERRMSG_CANTINCLUDEPERIODS                 '/ @"Identifier cannot include periods", _
		/'FB_ERRMSG_EXEMISSING                         '/ @"Executable not found", _
		/'FB_ERRMSG_ARRAYOUTOFBOUNDS                   '/ @"Array out-of-bounds", _
		/'FB_ERRMSG_MISSINGCMDOPTION                   '/ @"Missing command-line option for", _
		/'FB_ERRMSG_EXPECTEDANY                        '/ @"Expected 'ANY'", _
		/'FB_ERRMSG_EXPECTEDENDSCOPE                   '/ @"Expected 'END SCOPE'", _
		/'FB_ERRMSG_ILLEGALINSIDEASCOPE                '/ @"Illegal inside a compound statement or scoped block", _
		/'FB_ERRMSG_CANTPASSUDTRESULTBYREF             '/ @"UDT function results cannot be passed by reference", _
		/'FB_ERRMSG_AMBIGUOUSCALLTOPROC                '/ @"Ambiguous call to overloaded function", _
		/'FB_ERRMSG_NOMATCHINGPROC                     '/ @"No matching overloaded function", _
		/'FB_ERRMSG_DIVBYZERO                          '/ @"Division by zero", _
		/'FB_ERRMSG_STACKUNDERFLOW                     '/ @"Cannot pop stack, underflow", _
		/'FB_ERRMSG_CANTINITDYNAMICFIELDS              '/ @"UDT's containing var-len string fields cannot be initialized", _
		/'FB_ERRMSG_BRANCHTOBLOCKWITHLOCALVARS         '/ @"Branching to scope block containing local variables", _
		/'FB_ERRMSG_BRANCHTARGETOUTSIDECURRPROC        '/ @"Branching to other functions or to module-level", _
		/'FB_ERRMSG_BRANCHCROSSINGDYNDATADEF           '/ @"Branch crossing local array, var-len string or object definition", _
		/'FB_ERRMSG_LOOPWITHOUTDO                      '/ @"LOOP without DO", _
		/'FB_ERRMSG_NEXTWITHOUTFOR                     '/ @"NEXT without FOR", _
		/'FB_ERRMSG_WENDWITHOUTWHILE                   '/ @"WEND without WHILE", _
		/'FB_ERRMSG_ENDWITHWITHOUTWITH                 '/ @"END WITH without WITH", _
		/'FB_ERRMSG_ENDIFWITHOUTIF                     '/ @"END IF without IF", _
		/'FB_ERRMSG_ENDSELECTWITHOUTSELECT             '/ @"END SELECT without SELECT", _
		/'FB_ERRMSG_ENDSUBWITHOUTSUB                   '/ @"END SUB or FUNCTION without SUB or FUNCTION",_
		/'FB_ERRMSG_ENDSCOPEWITHOUTSCOPE               '/ @"END SCOPE without SCOPE", _
		/'FB_ERRMSG_ENDNAMESPACEWITHOUTNAMESPACE       '/ @"END NAMESPACE without NAMESPACE", _
		/'FB_ERRMSG_ENDEXTERNWITHOUTEXTERN             '/ @"END EXTERN without EXTERN", _
		/'FB_ERRMSG_ELSEIFWITHOUTIF                    '/ @"ELSEIF without IF", _
		/'FB_ERRMSG_ELSEWITHOUTIF                      '/ @"ELSE without IF", _
		/'FB_ERRMSG_CASEWITHOUTSELECT                  '/ @"CASE without SELECT", _
		/'FB_ERRMSG_CONSTANTCANTBECHANGED              '/ @"Cannot modify a constant", _
		/'FB_ERRMSG_EXPECTEDPERIOD                     '/ @"Expected period ('.')", _
		/'FB_ERRMSG_EXPECTEDENDNAMESPACE               '/ @"Expected 'END NAMESPACE'", _
		/'FB_ERRMSG_ILLEGALINSIDEANAMESPC              '/ @"Illegal inside a NAMESPACE block", _
		/'FB_ERRMSG_CANTREMOVENAMESPCSYMBOLS           '/ @"Symbols defined inside namespaces cannot be removed", _
		/'FB_ERRMSG_EXPECTEDENDEXTERN                  '/ @"Expected 'END EXTERN'", _
		/'FB_ERRMSG_EXPECTEDENDSUB                     '/ @"Expected 'END SUB'", _
		/'FB_ERRMSG_EXPECTEDENDFUNCTION                '/ @"Expected 'END FUNCTION'", _
		/'FB_ERRMSG_EXPECTEDENDCTOR                    '/ @"Expected 'END CONSTRUCTOR'", _
		/'FB_ERRMSG_EXPECTEDENDDTOR                    '/ @"Expected 'END DESTRUCTOR'", _
		/'FB_ERRMSG_EXPECTEDENDOPERATOR                '/ @"Expected 'END OPERATOR'", _
		/'FB_ERRMSG_EXPECTEDENDPROPERTY                '/ @"Expected 'END PROPERTY'", _
		/'FB_ERRMSG_DECLOUTSIDENAMESPC                 '/ @"Declaration outside the original namespace", _
		/'FB_ERRMSG_EXPECTEDENDCOMMENT                 '/ @"No end of multi-line comment, expected ""'/""", _
		/'FB_ERRMSG_TOOMANYERRORS                      '/ @"Too many errors, exiting", _
		/'FB_ERRMSG_EXPECTEDMACRO                      '/ @"Expected 'ENDMACRO'", _
		/'FB_ERRMSG_CANNOTINITEXTERNORCOMMON           '/ @"EXTERN or COMMON variables cannot be initialized", _
		/'FB_ERRMSG_DYNAMICEXTERNCANTHAVEBOUNDS        '/ @"EXTERN or COMMON dynamic arrays cannot have initial bounds", _
		/'FB_ERRMSG_ATLEASTONEPARAMMUSTBEANUDT         '/ @"At least one parameter must be a user-defined type", _
		/'FB_ERRMSG_PARAMORRESULTMUSTBEANUDT           '/ @"Parameter or result must be a user-defined type", _
		/'FB_ERRMSG_SAMEPARAMETERTYPES                 '/ @"Both parameters can't be of the same type", _
		/'FB_ERRMSG_SAMEPARAMANDRESULTTYPES            '/ @"Parameter and result can't be of the same type", _
		/'FB_ERRMSG_INVALIDRESULTTYPEFORTHISOP         '/ @"Invalid result type for this operator", _
		/'FB_ERRMSG_PARAMTYPEINCOMPATIBLEWITHPARENT    '/ @"Invalid parameter type, it must be the same as the parent TYPE/CLASS", _
		/'FB_ERRMSG_VARARGPARAMNOTALLOWED              '/ @"Vararg parameters are not allowed in overloaded functions", _
		/'FB_ERRMSG_ILLEGALOUTSIDEANOPERATOR           '/ @"Illegal outside an OPERATOR block", _
		/'FB_ERRMSG_PARAMCANTBEOPTIONAL                '/ @"Parameter cannot be optional", _
		/'FB_ERRMSG_ONLYVALIDINLANG                    '/ @"Only valid in -lang", _
		/'FB_ERRMSG_DEFTYPEONLYVALIDINLANG             '/ @"Default types or suffixes are only valid in -lang", _
		/'FB_ERRMSG_SUFFIXONLYVALIDINLANG              '/ @"Suffixes are only valid in -lang", _
		/'FB_ERRMSG_IMPLICITVARSONLYVALIDINLANG        '/ @"Implicit variables are only valid in -lang", _
		/'FB_ERRMSG_AUTOVARONLYVALIDINLANG             '/ @"Auto variables are only valid in -lang", _
		/'FB_ERRMSG_INVALIDARRAYINDEX                  '/ @"Invalid array index", _
		/'FB_ERRMSG_OPMUSTBEAMETHOD                    '/ @"Operator must be a member function", _
		/'FB_ERRMSG_OPCANNOTBEAMETHOD                  '/ @"Operator cannot be a member function", _
		/'FB_ERRMSG_METHODINANONUDT                    '/ @"Method declared in anonymous UDT", _
		/'FB_ERRMSG_CONSTINANONUDT                     '/ @"Constant declared in anonymous UDT", _
		/'FB_ERRMSG_STATICVARINANONUDT                 '/ @"Static variable declared in anonymous UDT", _
		/'FB_ERRMSG_EXPECTEDOPERATOR                   '/ @"Expected operator", _
		/'FB_ERRMSG_DECLOUTSIDECLASS                   '/ @"Declaration outside the original namespace or class", _
		/'FB_ERRMSG_DTORCANTCONTAINPARAMS              '/ @"A destructor should not have any parameters", _
		/'FB_ERRMSG_EXPECTEDCLASSID                    '/ @"Expected class or UDT identifier", _
		/'FB_ERRMSG_VARLENSTRINGINUNION                '/ @"Var-len strings cannot be part of UNION's or nested TYPE's", _
		/'FB_ERRMSG_DYNAMICARRAYINUNION                '/ @"Dynamic arrays cannot be part of UNION's or nested TYPE's", _
		/'FB_ERRMSG_CTORINUNION                        '/ @"Fields with constructors cannot be part of UNION's or nested TYPE's", _
		/'FB_ERRMSG_DTORINUNION                        '/ @"Fields with destructors cannot be part of UNION's or nested TYPE's", _
		/'FB_ERRMSG_ILLEGALOUTSIDEACTOR                '/ @"Illegal outside a CONSTRUCTOR block", _
		/'FB_ERRMSG_ILLEGALOUTSIDEADTOR                '/ @"Illegal outside a DESTRUCTOR block", _
		/'FB_ERRMSG_STRUCTISNOTUNIQUE                  '/ @"UDT's with methods must have unique names", _
		/'FB_ERRMSG_PARENTISNOTACLASS                  '/ @"Parent is not a class or UDT", _
		/'FB_ERRMSG_CTORCHAINMUSTBEFIRST               '/ @"CONSTRUCTOR() chain call not at top of constructor", _
		/'FB_ERRMSG_BASEINITMUSTBEFIRST                '/ @"BASE() initializer not at top of constructor", _
		/'FB_ERRMSG_REDIMCTORMUSTBECDEL                '/ @"REDIM on UDT with non-CDECL constructor", _
		/'FB_ERRMSG_REDIMDTORMUSTBECDEL                '/ @"REDIM on UDT with non-CDECL destructor", _
		/'FB_ERRMSG_REDIMCTORMUSTHAVEONEPARAM          '/ @"REDIM on UDT with non-parameterless default constructor", _
		/'FB_ERRMSG_ERASECTORMUSTBECDEL                '/ @"ERASE on UDT with non-CDECL constructor", _
		/'FB_ERRMSG_ERASEDTORMUSTBECDEL                '/ @"ERASE on UDT with non-CDECL destructor", _
		/'FB_ERRMSG_ERASECTORMUSTHAVEONEPARAM          '/ @"ERASE on UDT with non-parameterless default constructor", _
		/'FB_ERRMSG_CANTUNDEF                          '/ @"This symbol cannot be undefined", _
		/'FB_ERRMSG_RETURNMIXEDWITHASSIGN              '/ @"RETURN mixed with 'FUNCTION =' or EXIT FUNCTION (using both styles together is unsupported when returning objects with constructors)", _
		/'FB_ERRMSG_ASSIGNMIXEDWITHRETURN              '/ @"'FUNCTION =' or EXIT FUNCTION mixed with RETURN (using both styles together is unsupported when returning objects with constructors)", _
		/'FB_ERRMSG_MISSINGRETURNFORCTORRESULT         '/ @"Missing RETURN to copy-construct function result", _
		/'FB_ERRMSG_ILLEGALASSIGNMENT                  '/ @"Invalid assignment/conversion", _
		/'FB_ERRMSG_INVALIDSUBSCRIPT                   '/ @"Invalid array subscript", _
		/'FB_ERRMSG_NODEFAULTCTORDEFINED               '/ @"TYPE or CLASS has no default constructor", _
		/'FB_ERRMSG_RESULTHASNODEFCTOR                 '/ @"Function result TYPE has no default constructor", _
		/'FB_ERRMSG_NOBASEINIT                         '/ @"Missing BASE() initializer (base UDT without default constructor requires manual initialization)", _
		/'FB_ERRMSG_NEEDEXPLICITDEFCTOR                '/ @"Missing default constructor implementation (base UDT without default constructor requires manual initialization)", _
		/'FB_ERRMSG_NEEDEXPLICITCOPYCTOR               '/ @"Missing UDT.constructor(byref as UDT) implementation (base UDT without default constructor requires manual initialization)", _
		/'FB_ERRMSG_NEEDEXPLICITCOPYCTORCONST          '/ @"Missing UDT.constructor(byref as const UDT) implementation (base UDT without default constructor requires manual initialization)", _
		/'FB_ERRMSG_INVALIDPRIORITY                    '/ @"Invalid priority attribute", _
		/'FB_ERRMSG_PARAMCNTFORPROPGET                 '/ @"PROPERTY GET should have no parameter, or just one if indexed", _
		/'FB_ERRMSG_PARAMCNTFORPROPSET                 '/ @"PROPERTY SET should have one parameter, or just two if indexed", _
		/'FB_ERRMSG_EXPECTEDPROPERTY                   '/ @"Expected 'PROPERTY'", _
		/'FB_ERRMSG_ILLEGALOUTSIDEAPROPERTY            '/ @"Illegal outside a PROPERTY block", _
		/'FB_ERRMSG_PROPERTYHASNOGETMETHOD             '/ @"PROPERTY has no GET method/accessor", _
		/'FB_ERRMSG_PROPERTYHASNOSETMETHOD             '/ @"PROPERTY has no SET method/accessor", _
		/'FB_ERRMSG_PROPERTYHASNOIDXGETMETHOD          '/ @"PROPERTY has no indexed GET method/accessor", _
		/'FB_ERRMSG_PROPERTYHASNOIDXSETMETHOD          '/ @"PROPERTY has no indexed SET method/accessor", _
		/'FB_ERRMSG_UDTINFORNEEDSOPERATORS             '/ @"Missing overloaded operator: ", _
		/'FB_ERRMSG_EXPLICITCTORCALLINVECTOR           '/ @"The NEW[] operator does not allow explicit calls to constructors", _
		/'FB_ERRMSG_VECTORCANTBEINITIALIZED            '/ @"The NEW[] operator only supports the { ANY } initialization", _
		/'FB_ERRMSG_NEWCANTBEUSEDWITHFIXLENSTRINGS     '/ @"The NEW operator cannot be used with fixed-length strings", _
		/'FB_ERRMSG_ILLEGALMEMBERACCESS                '/ @"Illegal member access", _
		/'FB_ERRMSG_EXPECTEDSTMTSEP                    '/ @"Expected ':'", _
		/'FB_ERRMSG_NOACCESSTODEFAULTCTOR              '/ @"The default constructor has no public access", _
		/'FB_ERRMSG_NOACCESSTOCTOR                     '/ @"Constructor has no public access", _
		/'FB_ERRMSG_NOACCESSTODTOR                     '/ @"Destructor has no public access", _
		/'FB_ERRMSG_NOACCESSTOBASEDEFCTOR              '/ @"Accessing base UDT's private default constructor", _
		/'FB_ERRMSG_NOACCESSTOBASEDTOR                 '/ @"Accessing base UDT's private destructor", _
		/'FB_ERRMSG_ACCESSTONONSTATICMEMBER            '/ @"Illegal non-static member access", _
		/'FB_ERRMSG_ABSTRACTCTOR                       '/ @"Constructor declared ABSTRACT", _
		/'FB_ERRMSG_VIRTUALCTOR                        '/ @"Constructor declared VIRTUAL", _
		/'FB_ERRMSG_ABSTRACTDTOR                       '/ @"Destructor declared ABSTRACT", _
		/'FB_ERRMSG_MEMBERCANTBESTATIC                 '/ @"Member cannot be static", _
		/'FB_ERRMSG_MEMBERISNTSTATIC                   '/ @"Member isn't static", _
		/'FB_ERRMSG_STATICMEMBERHASNOINSTANCEPTR       '/ @"Only static members can be accessed from static functions and parameter initializers", _
		/'FB_ERRMSG_PRIVORPUBTTRIBNOTALLOWED           '/ @"The PRIVATE and PUBLIC attributes are not allowed with REDIM, COMMON or EXTERN", _
		/'FB_ERRMSG_PROCPROTOTYPENOTSTATIC             '/ @"STATIC used here, but not the in the DECLARE statement", _
		/'FB_ERRMSG_PROCPROTOTYPENOTCONST              '/ @"CONST used here, but not the in the DECLARE statement", _
		/'FB_ERRMSG_PROCPROTOTYPENOTVIRTUAL            '/ @"VIRTUAL used here, but not the in the DECLARE statement", _
		/'FB_ERRMSG_PROCPROTOTYPENOTABSTRACT           '/ @"ABSTRACT used here, but not the in the DECLARE statement", _
		/'FB_ERRMSG_VIRTUALWITHOUTRTTI                 '/ @"Method declared VIRTUAL, but UDT does not extend OBJECT", _
		/'FB_ERRMSG_ABSTRACTWITHOUTRTTI                '/ @"Method declared ABSTRACT, but UDT does not extend OBJECT", _
		/'FB_ERRMSG_OVERRIDINGNOTHING                  '/ @"Not overriding any virtual method", _
		/'FB_ERRMSG_ABSTRACTBODY                       '/ @"Implemented body for an ABSTRACT method", _
		/'FB_ERRMSG_OVERRIDERETTYPEDIFFERS             '/ @"Override has different return type than overridden method", _
		/'FB_ERRMSG_OVERRIDECALLCONVDIFFERS            '/ @"Override has different calling convention than overridden method", _
		/'FB_ERRMSG_IMPLICITDTOROVERRIDECALLCONVDIFFERS'/ @"Implicit destructor override would have different calling convention", _
		/'FB_ERRMSG_IMPLICITLETOVERRIDECALLCONVDIFFERS '/ @"Implicit LET operator override would have different calling convention", _
		/'FB_ERRMSG_OVERRIDEISNTCONSTMEMBER            '/ @"Override is not a CONST member like the overridden method", _
		/'FB_ERRMSG_OVERRIDEISCONSTMEMBER              '/ @"Override is a CONST member, but the overridden method is not", _
		/'FB_ERRMSG_OVERRIDEPARAMSDIFFER               '/ @"Override has different parameters than overridden method", _
		/'FB_ERRMSG_OPERATORCANTBESTATIC               '/ @"This operator cannot be STATIC", _
		/'FB_ERRMSG_OPERATORCANTBEVIRTUAL              '/ @"This operator is implicitly STATIC and cannot be VIRTUAL or ABSTRACT", _
		/'FB_ERRMSG_OPERATORCANTBECONST                '/ @"This operator is implicitly STATIC and cannot be CONST", _
		/'FB_ERRMSG_PARAMMUSTBEANINTEGER               '/ @"Parameter must be an integer", _
		/'FB_ERRMSG_PARAMMUSTBEAPOINTER                '/ @"Parameter must be a pointer", _
		/'FB_ERRMSG_AUTONEEDSINITIALIZER               '/ @"Expected initializer", _
		/'FB_ERRMSG_KEYWORDFIELDSNOTALLOWEDINCLASSES   '/ @"Fields cannot be named as keywords in TYPE's that contain member functions or in CLASS'es", _
		/'FB_ERRMSG_ILLEGALOUTSIDEFORSTMT              '/ @"Illegal outside a FOR compound statement", _
		/'FB_ERRMSG_ILLEGALOUTSIDEDOSTMT               '/ @"Illegal outside a DO compound statement", _
		/'FB_ERRMSG_ILLEGALOUTSIDEWHILESTMT            '/ @"Illegal outside a WHILE compound statement", _
		/'FB_ERRMSG_ILLEGALOUTSIDESELSTMT              '/ @"Illegal outside a SELECT compound statement", _
		/'FB_ERRMSG_EXPECTEDFOR                        '/ @"Expected 'FOR'", _
		/'FB_ERRMSG_EXPECTEDDO                         '/ @"Expected 'DO'", _
		/'FB_ERRMSG_EXPECTEDWHILE                      '/ @"Expected 'WHILE'", _
		/'FB_ERRMSG_EXPECTEDSELECT                     '/ @"Expected 'SELECT'", _
		/'FB_ERRMSG_NOENCLOSEDFORSTMT                  '/ @"No outer FOR compound statement found", _
		/'FB_ERRMSG_NOENCLOSEDDOSTMT                   '/ @"No outer DO compound statement found", _
		/'FB_ERRMSG_NOENCLOSEDWHILESTMT                '/ @"No outer WHILE compound statement found", _
		/'FB_ERRMSG_NOENCLOSEDSELSTMT                  '/ @"No outer SELECT compound statement found", _
		/'FB_ERRMSG_INVALIDEXITSTMT                    '/ @"Expected 'CONSTRUCTOR', 'DESTRUCTOR', 'DO', 'FOR', 'FUNCTION', 'OPERATOR', 'PROPERTY', 'SELECT', 'SUB' or 'WHILE'", _
		/'FB_ERRMSG_INVALIDCONTINUESTMT                '/ @"Expected 'DO', 'FOR' or 'WHILE'", _
		/'FB_ERRMSG_ILLEGALOUTSIDEASUB                 '/ @"Illegal outside a SUB block", _
		/'FB_ERRMSG_ILLEGALOUTSIDEAFUNCTION            '/ @"Illegal outside a FUNCTION block", _
		/'FB_ERRMSG_AMBIGUOUSSYMBOLACCESS              '/ @"Ambiguous symbol access, explicit scope resolution required", _
		/'FB_ERRMSG_NOELEMENTSDEFINED                  '/ @"An ENUM, TYPE or UNION cannot be empty", _
		/'FB_ERRMSG_NONSCOPEDENUM                      '/ @"ENUM's declared inside EXTERN .. END EXTERN blocks don't open new scopes", _
		/'FB_ERRMSG_STATICNONMEMBERPROC                '/ @"STATIC used on non-member procedure", _
		/'FB_ERRMSG_CONSTNONMEMBERPROC                 '/ @"CONST used on non-member procedure", _
		/'FB_ERRMSG_ABSTRACTNONMEMBERPROC              '/ @"ABSTRACT used on non-member procedure", _
		/'FB_ERRMSG_VIRTUALNONMEMBERPROC               '/ @"VIRTUAL used on non-member procedure", _
		/'FB_ERRMSG_INVALIDINITIALIZER                 '/ @"Invalid initializer", _
		/'FB_ERRMSG_NOOOPINFUNCTIONS                   '/ @"Objects with default [con|de]structors or methods are only allowed in the module level", _
		/'FB_ERRMSG_NOSTATICMEMBERVARINNESTEDUDT       '/ @"Static member variable in nested UDT (only allowed in toplevel UDTs)", _
		/'FB_ERRMSG_EXPECTEDUDT                        '/ @"Symbol not a CLASS, ENUM, TYPE or UNION type", _
		/'FB_ERRMSG_TOOMANYELEMENTS                    '/ @"Too many elements", _
		/'FB_ERRMSG_NOTADATAMEMBER                     '/ @"Only data members supported", _
		/'FB_ERRMSG_UNIONSNOTALLOWED                   '/ @"UNIONs are not allowed", _
		/'FB_ERRMSG_ARRAYSNOTALLOWED                   '/ @"Arrays are not allowed", _
		/'FB_ERRMSG_COMMONCANTBEOBJINST                '/ @"COMMON variables cannot be object instances of CLASS/TYPE's with cons/destructors", _
		/'FB_ERRMSG_CLONECANTTAKESELFBYVAL             '/ @"Cloning operators (LET, Copy constructors) can't take a byval arg of the parent's type", _
		/'FB_ERRMSG_INVALIDREFERENCETOLOCAL            '/ @"Local symbols can't be referenced", _
		/'FB_ERRMSG_EXPECTEDPTRORPOINTER               '/ @"Expected 'PTR' or 'POINTER'", _
		/'FB_ERRMSG_TOOMANYPTRINDIRECTIONS             '/ @"Too many levels of pointer indirection", _
		/'FB_ERRMSG_DYNAMICARRAYSCANTBECONST           '/ @"Dynamic arrays can't be const", _
		/'FB_ERRMSG_CONSTUDTTONONCONSTMETHOD           '/ @"Const UDT cannot invoke non-const method", _
		/'FB_ERRMSG_ELEMENTSMUSTBEEMPTY                '/ @"Elements must be empty for strings and arrays", _
		/'FB_ERRMSG_NOGOSUB                            '/ @"GOSUB disabled, use 'OPTION GOSUB' to enable", _
		/'FB_ERRMSG_INVALIDLANG                        '/ @"Invalid -lang", _
		/'FB_ERRMSG_CANTUSEANYINITELLIPSIS             '/ @"Can't use ANY as initializer in array with ellipsis bound", _
		/'FB_ERRMSG_MUSTHAVEINITWITHELLIPSIS           '/ @"Must have initializer with array with ellipsis bound", _
		/'FB_ERRMSG_CANTUSEELLIPSISASLOWERBOUND        '/ @"Can't use ... as lower bound", _
		/'FB_ERRMSG_FORNEXTVARIABLEMISMATCH            '/ @"FOR/NEXT variable name mismatch", _
		/'FB_ERRMSG_OPTIONREQUIRESSSE                  '/ @"Selected option requires an SSE FPU mode", _
		/'FB_ERRMSG_EXPECTEDRELOP                      '/ @"Expected relational operator ( =, >, <, <>, <=, >= )", _
		/'FB_ERRMSG_STMTUNSUPPORTEDINGCC               '/ @"Unsupported statement in -gen gcc mode", _
		/'FB_ERRMSG_TOOMANYLABELS                      '/ @"Too many labels", _
		/'FB_ERRMSG_UNSUPPORTEDFUNCTION                '/ @"Unsupported function", _
		/'FB_ERRMSG_EXPECTEDSUB                        '/ @"Expected sub", _
		/'FB_ERRMSG_EXPECTEDPPENDIF                    '/ @"Expected '#ENDIF'", _
		/'FB_ERRMSG_RCFILEWRONGTARGET                  '/ @"Resource file given for target system that does not support them", _
		/'FB_ERRMSG_OBJFILEWITHOUTINPUTFILE            '/ @"-o <file> option without corresponding input file", _
		/'FB_ERRMSG_EXPECTEDCLASSTYPE                  '/ @"Not extending a TYPE/UNION (a TYPE/UNION can only extend other TYPEs/UNIONs)", _
		/'FB_ERRMSG_ILLEGALOUTSIDEAMETHOD              '/ @"Illegal outside a CLASS, TYPE or UNION method", _
		/'FB_ERRMSG_CLASSNOTDERIVED                    '/ @"CLASS, TYPE or UNION not derived", _
		/'FB_ERRMSG_CLASSWITHOUTCTOR                   '/ @"CLASS, TYPE or UNION has no constructor", _
		/'FB_ERRMSG_TYPEHASNORTTI                      '/ @"Symbol type has no Run-Time Type Info (RTTI)", _
		/'FB_ERRMSG_TYPESARENOTRELATED                 '/ @"Types have no hierarchical relation", _
		/'FB_ERRMSG_TYPEMUSTBEAUDT                     '/ @"Expected a CLASS, TYPE or UNION symbol type", _
		/'FB_ERRMSG_CASTDERIVEDPTRFROMINCOMPATIBLE     '/ @"Casting derived UDT pointer from incompatible pointer type", _
		/'FB_ERRMSG_CASTDERIVEDPTRFROMUNRELATED        '/ @"Casting derived UDT pointer from unrelated UDT pointer type", _
		/'FB_ERRMSG_CASTDERIVEDPTRTOINCOMPATIBLE       '/ @"Casting derived UDT pointer to incompatible pointer type", _
		/'FB_ERRMSG_CASTDERIVEDPTRTOUNRELATED          '/ @"Casting derived UDT pointer to unrelated UDT pointer type", _
		/'FB_ERRMSG_EMPTYALIASSTRING                   '/ @"ALIAS name string is empty", _
		/'FB_ERRMSG_EMPTYLIBSTRING                     '/ @"LIB name string is empty", _
		/'FB_ERRMSG_OBJECTOFABSTRACTCLASS              '/ @"UDT has unimplemented abstract methods", _
		/'FB_ERRMSG_CALLTOABSTRACT                     '/ @"Non-virtual call to ABSTRACT method", _
		/'FB_ERRMSG_PPASSERT_FAILED                    '/ @"#ASSERT condition failed", _
		/'FB_ERRMSG_EXPECTEDGT                         '/ @"Expected '>'", _
		/'FB_ERRMSG_INVALIDSIZE                        '/ @"Invalid size", _
		/'FB_ERRMSG_DIFFERENTALIASTHANPROTO            '/ @"ALIAS name here does not match ALIAS given in DECLARE prototype", _
		/'FB_ERRMSG_VARARGONLYALLOWEDINCDECL           '/ @"vararg parameters are only allowed in CDECL procedures", _
		/'FB_ERRMSG_VARARGNOTALLOWEDASFIRSTPARAM       '/ @"the first parameter in a procedure may not be vararg", _
		/'FB_ERRMSG_CONSTCTOR                          '/ @"CONST used on constructor (not needed)", _
		/'FB_ERRMSG_CONSTDTOR                          '/ @"CONST used on destructor (not needed)", _
		/'FB_ERRMSG_NOBYREFFUNCTIONRESULT              '/ @"Byref function result not set", _
		/'FB_ERRMSG_RESULTASSIGNOUTSIDEFUNCTION        '/ @"Function result assignment outside of the function", _
		/'FB_ERRMSG_TYPEMISMATCHINBYREFRESULTASSIGN    '/ @"Type mismatch in byref function result assignment", _
		/'FB_ERRMSG_ASMOPTIONGIVENFORNONX86            '/ @"-asm att|intel option given, but not supported for this target (only x86 or x86_64)", _
		/'FB_ERRMSG_MISSINGREFINIT                     '/ @"Reference not initialized", _
		/'FB_ERRMSG_INCOMPATIBLEREFINIT                '/ @"Incompatible reference initializer", _
		/'FB_ERRMSG_ARRAYOFREFS                        '/ @"Array of references - not supported yet", _
		/'FB_ERRMSG_INVALIDCASERANGE                   '/ @"Invalid CASE range, start value is greater than the end value", _
		/'FB_ERRMSG_BYREFFIXSTR                        '/ @"Fixed-length string combined with BYREF (not supported)", _
		/'FB_ERRMSG_ILLEGALUSEOFRESERVEDSYMBOL         '/ @"Illegal use of reserved symbol", _
		/'FB_ERRMSG_EXPECTEDCOMMAORSEMICOLON           '/ @"Expected ',' or ';'", _
		/'FB_ERRMSG_EXPECTEDFILENUMBEREXPRESSION       '/ @"Expected file number expression", _
		/'FB_ERRMSG_MALFORMEDSOURCEDATEEPOCH           '/ @"Malformed SOURCE_DATE_EPOCH environment variable" _
	}


sub errPreInit( )
	errctx.hide_further_messages = FALSE
end sub

sub errInit( )
	'' fbc.bas will call err*() even before errInit() or after errEnd()
	errctx.inited += 1

	errctx.cnt = 0
	errctx.hide_further_messages = FALSE
	errctx.lastline = -1
	errctx.laststmt = -1

	'' alloc the undefined symbols tb, used to not report them more than once
	hashInit( @errctx.undefhash, 64, TRUE )

	listInit( @errctx.paramlocations, 4, sizeof( ERRPARAMLOCATION ) )
end sub

sub errEnd( )
	listEnd( @errctx.paramlocations )
	hashEnd( @errctx.undefhash )

	errctx.inited -= 1
end sub

sub errHideFurtherErrors( )
	errctx.hide_further_messages = TRUE
end sub

function errGetCount( ) as integer
	return errctx.cnt
end function

sub errPushParamLocation _
	( _
		byval proc as FBSYMBOL ptr, _
		byval tk as integer, _
		byval paramnum as integer, _
		byval paramid as zstring ptr _
	)

	dim as ERRPARAMLOCATION ptr l = any

	if( proc ) then
		'' don't count the instance pointer
		if( symbIsMethod( proc ) ) then
			if( paramnum > 1 ) then
				paramnum -= 1
			end if
		end if
	end if

	l = listNewNode( @errctx.paramlocations )
	l->proc = proc
	l->tk = tk
	l->paramnum = paramnum
	l->paramid = paramid
end sub

sub errPopParamLocation( )
	assert( listGetTail( @errctx.paramlocations ) )
	listDelNode( @errctx.paramlocations, listGetTail( @errctx.paramlocations ) )
end sub

private function errHaveParamLocation( ) as integer
	function = (listGetTail( @errctx.paramlocations ) <> NULL)
end function

'':::::
private sub hPrintErrMsg _
	( _
		byval errnum as integer, _
		byval msgex as const zstring ptr, _
		byval options as FB_ERRMSGOPT, _
		byval linenum as integer, _
		byval showerror as integer = TRUE, _
		byval customText as const zstring ptr = 0 _
	) static

	dim as const zstring ptr msg
	dim as string token_pos

	if( (errnum < 1) or (errnum >= FB_ERRMSGS) ) then
		msg = NULL
	else
		msg = errorMsgs(errnum)
	end if

	if( msgex = NULL ) then
		msgex = @""
	end if

	if( len( env.inf.name ) > 0 ) then
		print env.inf.name; "(";
		if( linenum > 0 ) then
			print str( linenum );
		end if
		print ") ";
	end if

	print "error";

	if( errnum >= 0 ) then
		print " " & errnum & ": " & *msg;
		if( customText ) then
			print *customText;
		end if

		if( showerror ) then
			showerror = (linenum > 0)
		end if

		if( len( *msgex ) > 0 ) then
			if( (options and FB_ERRMSGOPT_ADDCOMMA) <> 0 ) then
				print ", ";
			elseif( (options and FB_ERRMSGOPT_ADDCOLON) <> 0 ) then
				print ": ";
			else
				print " ";
			end if

			if( (options and FB_ERRMSGOPT_ADDQUOTES) <> 0 ) then
				print QUOTE;
			end if

			print *msgex;

			if( (options and FB_ERRMSGOPT_ADDQUOTES) <> 0 ) then
				print QUOTE;
			end if
		end if

		if( showerror ) then
			dim as string ln
			ln = lexPeekCurrentLine( token_pos, fbLangOptIsSet( FB_LANG_OPT_SINGERRLINE ) )

			if( len( ln ) > 0 ) then
				if( fbLangOptIsSet( FB_LANG_OPT_SINGERRLINE ) ) then
					print " in '" & ln & "'"
				else
					print
					print lexPeekCurrentLine( token_pos, FALSE )
					print token_pos
				end if
			else
				print
			end if
		else
			print
		end if

	else
		print ": "; *msgex
	end if

end sub

'':::::
sub errReportEx _
	( _
		byval errnum as integer, _
		byval msgex as const zstring ptr, _
		byval linenum as integer, _
		byval options as FB_ERRMSGOPT, _
		byval customText as const zstring ptr _
	)

	'' Don't show if already too many errors displayed
	if( errctx.hide_further_messages ) then
		exit sub
	end if

	if( errctx.inited > 0 ) then
		msgex = hMakeParamDesc( msgex )
	end if

	if( linenum = 0 ) then
		'' only one error per stmt
		if( parser.stmt.cnt = errctx.laststmt ) then
			exit sub
		end if

		if( lex.ctx <> NULL ) then
			linenum = lexLineNum( )
		end if

		errctx.lastline = linenum
		errctx.laststmt = parser.stmt.cnt
	end if

	hPrintErrMsg( errnum, msgex, options, linenum, env.clopt.showerror, customText )

	errctx.cnt += 1

	if( errctx.cnt >= env.clopt.maxerrors ) then
		hPrintErrMsg( FB_ERRMSG_TOOMANYERRORS, NULL, 0, linenum, FALSE )
		errHideFurtherErrors( )
	end if
end sub

private function hAddToken _
	( _
		byval isbefore as integer, _
		byval addcomma as integer, _
		byval msgex as zstring ptr = NULL _
	) as const zstring ptr

	static as string res, token

	res = ""

	if( msgex = NULL ) then
		token = *lexGetText( )
	else
		token = *msgex
	end if

	if( len( token ) > 0 ) then
		'' don't print control chars
		select case lexGetToken( )
		case is <= CHAR_SPACE, FB_TK_EOL, FB_TK_EOF

		case else
			if( addcomma ) then
				res += ", "
			end if

			if( isbefore ) then
				res += "before '"
			else
				res += "found '"
			end if

			res += token + "'"
		end select
	end if

	function = strptr( res )
end function

'':::::
sub errReport _
	( _
		byval errnum as integer, _
		byval isbefore as integer = FALSE, _
		byval customText as const zstring ptr _
	)

	dim as const zstring ptr msgex = any

	if( errHaveParamLocation( ) ) then
		msgex = NULL
	else
		msgex = hAddToken( isbefore, FALSE )
	end if

	errReportEx( errnum, msgex, , , customText )

end sub

'':::::
sub errReportWarnEx _
	( _
		byval msgnum as integer, _
		byval msgex as const zstring ptr, _
		byval linenum as integer, _
		byval options as FB_ERRMSGOPT, _
		byval customText as const zstring ptr _
	)

	if( (msgnum < 1) or (msgnum >= FB_WARNINGMSGS) ) then
		exit sub
	end if

	if( warningMsgs(msgnum).level < env.clopt.warninglevel ) then
		exit sub
	end if

	if( errctx.hide_further_messages ) then
		exit sub
	end if

	if( fbPdCheckIsSet( FB_PDCHECK_ERROR ) ) then
		errctx.cnt += 1
	end if

	if( errctx.inited > 0 ) then
		msgex = hMakeParamDesc( msgex )
	end if

	if( len( env.inf.name ) > 0 ) then
		print env.inf.name;
	else
		if( msgex <> NULL ) then
			print *msgex;
			msgex = NULL
		end if
	end if

	if( linenum > 0 ) then
		print "(" & linenum & ")";
	else
		print "()";
	end if

	if( fbPdCheckIsSet( FB_PDCHECK_ERROR ) ) then
		print " error";
	end if

	print " warning " & msgnum & "(" & warningMsgs(msgnum).level & "): ";
	print *warningMsgs(msgnum).text;
	if( customText ) then
		print *customText;
	end if

	if( msgex <> NULL ) then
		if( (options and FB_ERRMSGOPT_ADDCOMMA) <> 0 ) then
			print ", ";
		elseif( (options and FB_ERRMSGOPT_ADDCOLON) <> 0 ) then
			print ": ";
		else
			print " ";
		end if

		if( (options and FB_ERRMSGOPT_ADDQUOTES) <> 0 ) then
			print QUOTE;
		end if

		print *msgex;

		if( (options and FB_ERRMSGOPT_ADDQUOTES) <> 0 ) then
			print QUOTE;
		end if
	end if

	print

end sub

'':::::
sub errReportWarn _
	( _
		byval msgnum as integer, _
		byval msgex as const zstring ptr, _
		byval options as FB_ERRMSGOPT, _
		byval customText as const zstring ptr _
	)

	errReportWarnEx( msgnum, msgex, lexLineNum( ), options, customText )

end sub

private function getNotAllowedMsg _
	( _
		byval opt as FB_LANG_OPT, _
		byval msgex as zstring ptr = NULL _
	) as string

	dim as string msg = ""
	dim as integer i, langs

	langs = 0
	for i = 0 to FB_LANGS-1
		if( (fbGetLangOptions( i ) and opt) <> 0 ) then
			if( langs > 0 ) then
				msg += " or "
			end if
			msg += fbGetLangName( i )
			langs += 1
		end if
	next

	msg += *hAddToken( FALSE, langs > 0, msgex )

	return msg

end function

'':::::
sub errReportNotAllowed _
	( _
		byval opt as FB_LANG_OPT, _
		byval errnum as integer, _
		byval msgex as zstring ptr _
	)

	dim msg as string = getNotAllowedMsg( opt, msgex )

	errReportEx( errnum, msg, , FB_ERRMSGOPT_NONE )

end sub

private function hMakeParamDesc _
	( _
		byval msgex as const zstring ptr _
	) as const zstring ptr

	static as string desc
	dim as ERRPARAMLOCATION ptr paramloc = any
	dim as FBSYMBOL ptr proc = any
	dim as zstring ptr pname = any, pid = any
	dim as integer pnum = any, addprnts = any

	paramloc = listGetTail( @errctx.paramlocations )
	if( paramloc = NULL ) then
		return msgex
	end if

	proc = paramloc->proc
	pnum = paramloc->paramnum
	pid = paramloc->paramid
	desc = ""
	if( msgex ) then
		desc = *msgex + " "
	end if

	if( pnum > 0 ) then
		desc += "at parameter " + str( pnum )
		if( pid = NULL ) then
			if( proc <> NULL ) then
				dim as FBSYMBOL ptr param = symbGetProcHeadParam( proc )
				dim as integer cnt = iif( symbIsMethod( proc ), 0, 1 )

				do while( param <> NULL )
					if( cnt = pnum ) then
						exit do
					end if
					cnt += 1
					param = param->next
				loop

				if( param <> NULL ) then
					pid = symbGetName( param )
				end if
			end if
		end if

		if( pid <> NULL ) then
			if( len(*pid) > 0 ) then
				desc += " ("
				desc += *pid
				desc += ")"
			end if
		end if
	end if

	if( proc <> NULL ) then
		dim as integer showname = TRUE

		'' part of the rtlib?
		pname = NULL
		if( symbGetIsRTL( proc ) ) then
			'' any name set?
			if( symbGetName( proc ) <> NULL ) then
				'' starts with "FB_"?
				if( left( *symbGetName( proc ), 3 ) = "FB_" ) then
					showname = FALSE
				end if
			else
				showname = FALSE
			end if
		else
			static s as string

			'' function pointer?
			if( symbGetIsFuncPtr( proc ) ) then
				s = symbProcPtrToStr( proc )
				pname = strptr( s )
			'' method?
			elseif( (proc->pattrib and (FB_PROCATTRIB_CONSTRUCTOR or _
							FB_PROCATTRIB_DESTRUCTOR1 or FB_PROCATTRIB_DESTRUCTOR0 or _
							FB_PROCATTRIB_OPERATOR)) <> 0 ) then
				s = symbMethodToStr( proc )
				pname = strptr( s )
			end if
		end if

		if( showname ) then
			if( pname = NULL ) then
				addprnts = TRUE
				pname = symbGetName( proc )
				if( pname <> NULL ) then
					if( len( *pname ) = 0 ) then
						pname = symbGetMangledName( proc )
					end if
				end if
			else
				addprnts = FALSE
			end if

			if( pname <> NULL ) then
				if( pnum > 0 ) then
					desc += " of "
				end if
				desc += *pname
				if( addprnts ) then
					desc += "()"
				end if
			end if
		end if
	else
		if( pnum > 0 ) then
			desc += " of "
		end if
		desc += *symbKeywordGetText( paramloc->tk )
	end if

	function = strptr( desc )
end function

sub errReportParam _
	( _
		byval proc as FBSYMBOL ptr, _
		byval paramnum as integer, _
		byval paramid as zstring ptr, _
		byval msgnum as integer _
	)

	errPushParamLocation( proc, -1, paramnum, paramid )
	errReportEx( msgnum, NULL )
	errPopParamLocation( )

end sub

sub errReportParamWarn _
	( _
		byval proc as FBSYMBOL ptr, _
		byval paramnum as integer, _
		byval paramid as zstring ptr, _
		byval msgnum as integer _
	)

	errPushParamLocation( proc, -1, paramnum, paramid )
	errReportWarn( msgnum, NULL )
	errPopParamLocation( )

end sub

'':::::
sub errReportUndef _
	( _
		byval errnum as integer, _
		byval id as zstring ptr _
	)

	dim as uinteger hash
	dim as zstring ptr id_cpy

	'' already reported?
	hash = hashHash( id )
	if( hashLookupEx( @errctx.undefhash, id, hash ) <> NULL ) then
		exit sub
	end if

	'' add to hash and report the error
	id_cpy = NULL
	ZStrAssign( @id_cpy, id )

	hashAdd( @errctx.undefhash, id_cpy, id_cpy, hash )

	errReportEx( errnum, id )

end sub
