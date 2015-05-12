
o Command-line options added:
  ===========================

  -callconv <name> - Set the calling convention (default: cdecl)

  -baseincdir <name> - Add a base directory to #include'd files
  
  -dll - Declare all external symbols as "import"



o Tips:
  =====

  1) all argument-less #define's with typecasting's must be cleaned, that's it, 
     "#define foo ((bar)1234)" must become "#define foo (1234)"
   
  2) #define's with arguments (macros) are not emited, they will have to be translated 
     by hand

  3) no anonymous/nameless inner unions and structs are allowed, move 
     them out and create dummy fields - FB support only anonymous inner structs, so
     they can be converted back after been translated

  4) inner structs are moved outside the parent structs BUT the field declaring the
     struct will be moved to the END of the parent struct, they have to be fixed by
     hand - they all have _NESTED_ added to their names to make it easier to find

  5) function pointers won't preserve the argument's names, just the types

  6) calling conventions are not supported, like __stdcall, __cdecl, __pascal, use the 
     cmm-line option's to change the default one (cdecl), type swig -help for more info.



o Converting someincfile.h to someincfile.bi:
  ===========================================

Assuming a someincfile.i interface file was created, containing for example:

%module someincfile
%include someincfile.h


Invoke SWIG using: swig [options] someincfile.i

The mod_someincfile.bi and someincfile.bi files will be created, the mod_???.bi 
file is generated only for listing the missing symbols and such, it should not be used.



For more details and for SWIG's docs/tutorials see: http://www.swig.org/