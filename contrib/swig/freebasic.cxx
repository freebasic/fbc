/*
 *
 * SWIG FreeBASIC wrapper -- mar/2005 by v1ctor (av1ctor@yahoo.com.br)
 *
 */
 
/* TODO:
	[ ] check how inline subs are parsed (skip body?)
 */

char cvsroot_freebasic_cxx[] = "$Header: /cvsroot/swig/SWIG/Source/Modules/freebasic.cxx,v 0.01 2005/03/05 18:36:31 v1ctor Exp $";

#include "swigmod.h"

typedef enum {
	EMIT_HEADER,
	EMIT_FOOTER,
	EMIT_INCLUDE,
	EMIT_DEFINE,
	EMIT_ENUM,
	EMIT_TYPEDEF,
	EMIT_FUNCTION,
	EMIT_STRUCT,
	EMIT_UNION,
	EMIT_CLASS	
} EMIT_TYPE;


typedef struct _FBCTX {
	File *outf;
	EMIT_TYPE lastemit;
	String *laststructname;
} FBCTX;	

class FREEBASIC : public Language {
public:
	virtual void main(int argc, char *argv[]);
	virtual int top(Node *n);
	
	FREEBASIC( );
	~FREEBASIC( );
	
private:
	FBCTX ctx;
	Hash *inctb;
	Hash *usertb;
	String *callconv;
	String *baseincdir;
	String *curr_header;
	bool isdll;
  
	int init( Node *n, String *name, bool ismodule = false );
	void end( Node *n, bool ismodule = false );
	int emit( Node *n );

  	int emit_header( Node *n, String *name, bool ismodule = false );
  	int emit_footer( Node *n, bool ismodule = false );
  	
  	int emit_usertb( );

  	bool emit_include( Node *n, bool isdup );
  	
  	int emit_constant( Node *n );
  	int emit_enum( Node *n );
  	int emit_enumitem( Node *n );
  	int emit_typedef( Node *n );
  	int emit_function( Node *n );
  	int emit_field( Node *n );
  	int emit_struct( Node *n );
  	int emit_union( Node *n );
  	int emit_class( Node *n );
  	int emit_extern( Node *n );
  	
	String *remap_type( Node *n, bool byteptrtostring );
	String *remap_typeex( SwigType *type, SwigType *decl, bool byteptrtostring, bool byteptrtozstring );
  	String *remap_funcptr( Node *n );
  	
	String *conv_ops( String *def );

  	String *field_getarraydims( Node *n );
  	String *field_getbitfield( Node *n );
  	String *field_getfixstring( Node *n );
  	bool getparam( Node *n, int p, String *paramlist );
  	String *getparamlist( Node *n );
  	String *getfuncres( Node *n );
  	String *getfuncptr( SwigType *type, SwigType *basetype );
  	
  	String *strip_struct( String *s );
  	
  	void notfoundsymb_add( String *s );
  	
  	String *strip_path( String *name );

};

/*:::::*/
FREEBASIC :: FREEBASIC( )
{
  	callconv 	= NewString( "cdecl" );
  	
  	baseincdir 	= NewString( "" );
  	
  	isdll	 	= false;
  	
  	inctb 	 	= NewHash( );
  	
  	usertb 	 	= NewHash( );
  	
  	curr_header	= NULL;

}

/*:::::*/
FREEBASIC :: ~FREEBASIC( )
{
	if( curr_header != NULL )
		Delete( curr_header );
		
	Delete( inctb );
	
	Delete( usertb );
	
	Delete( callconv );
}

/*:::::*/
void FREEBASIC :: main(int argc, char *argv[]) 
{
	
	//SWIG_library_directory( "freebasic" ); 
	//SWIG_config_file( "freebasic.swg" );

	for(int i = 1;  i < argc; i++ ) 
	{
    	// set calling convention?
    	if( strcmp( argv[i], "-callconv" ) == 0 ) 
    	{      		
      		if( argv[i+1] == NULL )
				Swig_arg_error( );

			callconv = NewString( argv[i+1] );
			
      		Swig_mark_arg( i );
      		Swig_mark_arg( i+1 );
      		i++;
      	}
    	// base dir?
    	else if( strcmp( argv[i], "-baseincdir" ) == 0 ) 
    	{      		
      		if( argv[i+1] == NULL )
				Swig_arg_error( );

			baseincdir = NewString( argv[i+1] );
			Append( baseincdir, "/" );
			
      		Swig_mark_arg( i );
      		Swig_mark_arg( i+1 );
      		i++;
      	}
    	// dll?
    	else if( strcmp( argv[i], "-dll" ) == 0 ) 
    	{      		
			isdll = true;
			Swig_mark_arg( i );
      	}
      	else if( strcmp( argv[i], "-help" ) == 0 ) 
      	{
      		fprintf( stderr, "FreeBASIC Options:\n");
      		fprintf( stderr, "     -callconv <name> "
      						 "- Set the calling convention (default: cdecl)\n"
      						 "     -baseincdir <name> "
      						 "- Add a base directory to #include'd files\n"
      						 "     -dll "
      						 "- Declare all external symbols as import\n"
					);
	    }
	}
	
}

/*:::::*/
int FREEBASIC :: init( Node *n, String *name, bool ismodule )
{
	int result = SWIG_OK;
	String *filename = NewString( "" );	
  	
  	curr_header = Copy( name );
  	
  	Printf( filename, "%s%s.bi", SWIG_output_directory( ), name );
	
  	//Printf( stdout, "%s\n", filename );
  	
  	ctx.outf = NewFile( filename, "w" );
  	if( ctx.outf == NULL )
  	{
    	Printf(	stderr, "Unable to open %s for writing\n", filename );
    	SWIG_exit( EXIT_FAILURE );
  	}
  	
  	emit_header( n, name, ismodule );
  	
  	ctx.laststructname = NULL;
  		
  	return result;
}

/*:::::*/
void FREEBASIC :: end( Node *n, bool ismodule )
{
  	
  	emit_footer( n, ismodule );
  	
  	Close( ctx.outf );
  	Delete( ctx.outf ); 							// del handle
}

/*:::::*/
int FREEBASIC :: top(Node *n)
{
	int result;
	String *module;
	
	module = NewString( "mod_" );
	Append( module, Getattr( n, "name" ) );
	
	init( n, module );
	
	result = emit( n );
	
	end( n, true );
	
	return result;	
}

/*:::::*/
int FREEBASIC :: emit( Node *n )
{
	int result = SWIG_OK;
	bool recursive;
	
	if( n == NIL )
		return result;
	
	Node *child = firstChild( n );
    
    while( child != NIL ) 
    {
      String *nodetype = nodeType( child );
      String *storage;
      String *kind;
      SwigType *decl;
      
      //Printf( stdout, "%s\n", nodetype );
      
      recursive = true;
      
      if( Strcmp( nodetype, "include" ) == 0 ) 
      	recursive = emit_include( child, false );

      if( Strcmp( nodetype, "includedup" ) == 0 ) 
      	recursive = emit_include( child, true );
      
      else if( Strcmp( nodetype, "constant" ) == 0 ) 
      	result |= emit_constant( child );
      
      else if( Strcmp( nodetype, "enum" ) == 0 ) 
      	result |= emit_enum( child );
      
      else if( Strcmp( nodetype, "cdecl" ) == 0 )
      {      	
      	storage = Getattr( child, "storage" );
      	decl 	= Getattr( child, "decl" );
      	
      	if( (storage != NIL) && (Strcmp( storage, "typedef" ) == 0) ) 
      	{      		
      		result |= emit_typedef( child );
      	}
      	else if( (decl != NIL) && (SwigType_isfunction( decl )) ) 
      	{      		      		      		      		
      		result |= emit_function( child );
      	}
      	else if( (storage != NIL) && (Strcmp( storage, "extern" ) == 0) ) 
      	{      		
      		result |= emit_extern( child );
      	}
      	
      }
      else if( Strcmp( nodetype, "class" ) == 0 )
      {
      	kind = Getattr( child, "kind" );
      	if( Strcmp( kind, "struct" ) == 0 ) 
      		emit_struct( child );
      	else if( Strcmp( kind, "union" ) == 0 ) 
      		emit_union( child );
      	else
      		emit_class( child );
      }
       
      if( recursive )
      	result |= emit( child );
      
      child = nextSibling( child );
    }

	return result;	
}

/*:::::*/
String *FREEBASIC :: strip_path( String *name )
{
	String *p;

  	p = name;
  	while( (p = Strchr( p, '\\' )) != NULL )
  	{
  		++((char *)p);
  		name = p;
  	}
  	
  	return name;
}


/*:::::*/
int FREEBASIC :: emit_header( Node *n, String *name, bool ismodule )
{
	String *defname = NewString( "" );

  	ctx.lastemit = EMIT_HEADER;
  	
	name = strip_path( name );
	
	Printf( ctx.outf, "''\n" );
	Printf( ctx.outf, "''\n" );
	Printf( ctx.outf, "'' %s -- ", name );
	Printf( ctx.outf, "header translated with help of SWIG FB wrapper\n" );
	Printf( ctx.outf, "''\n" );
	Printf( ctx.outf, "'' NOTICE: This file is part of the FreeBASIC Compiler package and can't\n" );
	Printf( ctx.outf, "''         be included in other distributions without authorization.\n" );
	Printf( ctx.outf, "''\n" );
	Printf( ctx.outf, "''\n" );
  	
  	Printf( defname, "__%s_bi__", name );
  	Replace( defname, "-", "_", DOH_REPLACE_ANY );
	
	Printf( ctx.outf, "#ifndef %s\n", defname );
	Printf( ctx.outf, "#define %s\n", defname );
	
	return SWIG_OK;	
}

/*:::::*/
int FREEBASIC :: emit_usertb( )
{
	List *keylist = Keys( usertb );
	
	if( Len( keylist ) <= 0 )
		return SWIG_OK;
		
	Printf( ctx.outf, "\n\n'' List of symbols not found:\n\n" );
	
	for( int i = 0; i < Len( keylist ); i++ )
	{
		String *name = Getitem( keylist, i );
		String *headers = Getattr( usertb, name );
		Printf( ctx.outf, "'' %s at %s\n", name, headers );
	}
	
	Printf( ctx.outf, "\n" );

	return SWIG_OK;
}

/*:::::*/
int FREEBASIC :: emit_footer( Node *n, bool ismodule )
{

	ctx.lastemit = EMIT_FOOTER;

	Printf( ctx.outf, "\n#endif\n" );
	
	if( ismodule )
		emit_usertb( );
	
	return SWIG_OK;	
}

/*:::::*/
bool FREEBASIC :: emit_include( Node *n, bool isdup )
{
	FBCTX ctxcopy;
	bool iscxx;
	
	String *name = Copy( Getattr( n, "name" ) );
	
	// only if ending with .h
	if( Strstr( name, ".h" ) != 0 )
		iscxx = false;
	else if( Strstr( name, ".cxx" ) != 0 )
		iscxx = true;
	else
		return true;
	
	if( ctx.lastemit != EMIT_INCLUDE )
		Printf( ctx.outf, "\n" );

  	ctx.lastemit = EMIT_INCLUDE;
  	
	if( !iscxx ) 
		Replace( name, ".h", "", DOH_REPLACE_FIRST );	
	else
		Replace( name, ".cxx", "", DOH_REPLACE_FIRST );
	
	Printf( ctx.outf, "#include once \"%s%s.bi\"\n", baseincdir, name );
	
	// not parsed already?
	if( !isdup )
		if( Setattr( inctb, name, "" ) == 0 )
		{
			ctxcopy = ctx;
	
			init( n, name );
	
			emit( n );
	
			end( n );
	
			ctx = ctxcopy;
		}
	
	return false;	
}

/*:::::*/
String * FREEBASIC :: conv_ops( String *def )
{
	String *value = Copy( def );

	/* shift */
	if( Strstr( value, ">>" ) != NULL )
    	Replace( value, ">>", " shr ", DOH_REPLACE_ANY );

	if( Strstr( value, "<<" ) != NULL )
    	Replace( value, "<<", " shl ", DOH_REPLACE_ANY );

	/* logical */
	if( Strstr( value, "||" ) != NULL )
    	Replace( value, "||", " or ", DOH_REPLACE_ANY );

	if( Strstr( value, "&&" ) != NULL )
    	Replace( value, "&&", " and ", DOH_REPLACE_ANY );

	if( Strstr( value, "!" ) != NULL )
    	Replace( value, "!", " not ", DOH_REPLACE_ANY );
	
	/* bitwise */
	if( Strstr( value, "|" ) != NULL )
    	Replace( value, "|", " or ", DOH_REPLACE_ANY );

	if( Strstr( value, "&" ) != NULL )
    	Replace( value, "&", " and ", DOH_REPLACE_ANY );

	if( Strstr( value, "~" ) != NULL )
    	Replace( value, "~", " not ", DOH_REPLACE_ANY );

	/* num prefixes */
	if( Strstr( value, "0x" ) != NULL )
    	Replace( value, "0x", "&h", DOH_REPLACE_ANY );

	if( Strstr( value, "0b" ) != NULL )
		Replace( value, "0b", "&b", DOH_REPLACE_ANY );

	
	return value;
}

/*:::::*/
int FREEBASIC :: emit_constant( Node *n )
{
	String *name  = Getattr( n, "name" );
    String *value = Getattr( n, "value" );
    SwigType *type= Getattr( n, "type" );
      
	if( ctx.lastemit != EMIT_DEFINE )
		Printf( ctx.outf, "\n" );
		
	ctx.lastemit = EMIT_DEFINE;

    switch( SwigType_type( type ) )
    {
    case T_STRING:
    	Printf( ctx.outf, "#define %s \"%s\"\n", name, value );
		break;
	
	case T_CHAR:
    	Printf( ctx.outf, "#define %s asc(\"%s\")\n", name, value );
    	break;
    
    default:
    	Printf( ctx.outf, "#define %s %s\n", name, conv_ops( value ) );
    }
      
	return SWIG_OK;	
}

/*:::::*/
int FREEBASIC :: emit_enumitem( Node *n )
{
	String *name  = Getattr( n, "name" );
    String *value = Copy( Getattr( n, "enumvalue" ) );
	SwigType *type= Getattr( n, "type" );
      
    if( value )
    {
    	if( SwigType_type( type ) == T_CHAR )
    		Printf( ctx.outf, "\t%s = asc(\"%s\")\n", name, value );
    	else
    		Printf( ctx.outf, "\t%s = %s\n", name, conv_ops( value ) );
    }
	else
		Printf( ctx.outf, "\t%s\n", name );
      
	return SWIG_OK;	
}

/*:::::*/
int FREEBASIC :: emit_enum( Node *n )
{
	String *name  = Getattr( n, "name" );
      
	ctx.lastemit = EMIT_ENUM;

	if( name != NULL )
		ctx.laststructname = Copy( name );
    
	Printf( ctx.outf, "\nenum %s\n", name );
      
    Node *child = firstChild( n );
    
    while( child != NIL )
    {
      if( Strcmp( nodeType( child ), "enumitem" ) == 0 ) 
      		emit_enumitem( child );
      
      child = nextSibling( child );
    }
    
    Printf( ctx.outf, "end enum\n" );

	return SWIG_OK;	
}

/*:::::*/
int FREEBASIC :: emit_typedef( Node *n )
{
	String *name  = Getattr( n, "name" );
	String *type  = Getattr( n, "type" );
      
	if( ctx.lastemit != EMIT_TYPEDEF )
		Printf( ctx.outf, "\n" );
		
	ctx.lastemit = EMIT_TYPEDEF;

	// don't emit enum's as typedef
	if( Strncmp( type, "enum", 4 ) == 0 )
	{
		Replace( type, "enum ", "", DOH_REPLACE_FIRST );
		
		// unless they have different names
		if( Strcmp( name, type ) != 0 )
			if( Strncmp( type, "$unnamed", 8 ) != 0 )
				Printf( ctx.outf, "type %s as %s\n", name, type );	
			
		return SWIG_OK;
	}

	//
	//handle function ptr
	type = remap_funcptr( n );
	if( type == NULL )
		type = remap_type( n, false );

	// same?
	if( Strcmp( name, type ) == 0 )
		type = NewString( "any" );
	
	Printf( ctx.outf, "type %s as %s\n", name, type );
	
	return SWIG_OK;	
}

/*:::::*/
int FREEBASIC :: emit_field( Node *n )
{
	String *name = Getattr( n, "name" );
      
	// nameless? (happens with named inner-structs when moved outside)
	if( name == NIL )
		return SWIG_OK;
	
	// handle char[]
	String *fieldstr = field_getfixstring( n );
	if( fieldstr != NULL )
		Printf( ctx.outf, "\t%s as %s\n", name, fieldstr );
	else
	{
		//handle function ptr
		fieldstr = remap_funcptr( n );
		if( fieldstr != NULL )
			Printf( ctx.outf, "\t%s as %s\n", name, fieldstr );
		else
		{
			Printf( ctx.outf, "\t%s%s%s", name, field_getarraydims( n ), field_getbitfield( n ) );
			// can't be done in the same call as n's "decl" attrib can be modified by getarraydims()
			Printf( ctx.outf, " as %s\n", remap_typeex( Copy( Getattr( n, "type" ) ), 
														Copy( Getattr( n, "decl" ) ), 
														false, 
														true ) );
		}
	}
	
	return SWIG_OK;	
}

/*:::::*/
int FREEBASIC :: emit_struct( Node *n )
{
	String *name  = Getattr( n, "name" );
      
	ctx.lastemit = EMIT_STRUCT;
	
	if( name != NULL )
		ctx.laststructname = Copy( name );
	
	Printf( ctx.outf, "\ntype %s\n", name );
      
    Node *child = firstChild( n );
    
    while( child != NIL )
    {
      emit_field( child );
      
      child = nextSibling( child );
    }
    
    Printf( ctx.outf, "end type\n" );

	return SWIG_OK;	
}

/*:::::*/
int FREEBASIC :: emit_union( Node *n )
{
	String *name  = Getattr( n, "name" );
      
	ctx.lastemit = EMIT_UNION;

	if( name != NULL )
		ctx.laststructname = Copy( name );
	
	Printf( ctx.outf, "\nunion %s\n", name );
      
    Node *child = firstChild( n );
    
    while( child != NIL )
    {
      emit_field( child );
      
      child = nextSibling( child );
    }
    
    Printf( ctx.outf, "end union\n" );

	return SWIG_OK;	
}

/*:::::*/
int FREEBASIC :: emit_class( Node *n )
{
	String *name  = Getattr( n, "name" );
      
	ctx.lastemit = EMIT_CLASS;

	if( name != NULL )
		ctx.laststructname = Copy( name );

	//Printf( ctx.outf, "\nclass %s\n", name );
      
    Node *child = firstChild( n );
    
    while( child != NIL )
    {
      //emit_???( child );
      
      child = nextSibling( child );
    }
    
    //Printf( ctx.outf, "end class\n" );

	return SWIG_OK;	
}


/*:::::*/
bool FREEBASIC :: getparam( Node *n, int p, String *paramlist )
{
	String *name  = Getattr( n, "name" );
	String *type  = Getattr( n, "type" );
      
	// void?
	if( type == NIL || ((p == 0) && (SwigType_type( type ) == T_VOID)) )
		return false;
	
	// varargs?
	if( SwigType_isvarargs( type ) )
	{
		Append( paramlist, "..." );
	}
	else
	{
		if( name != NIL )
		{
			Append( paramlist, "byval " );
			Append( paramlist, name );
			Append( paramlist, " as " );
		}
		else
			Append( paramlist, "byval as " );
	
		Append( paramlist, remap_type( n, true ) );
	}
	
	
	return true;	
}

/*:::::*/
String * FREEBASIC :: getparamlist( Node *n )
{
    String *paramlist;
    int p = 0;
    
	paramlist = NewString( "(" );
	while( n != NIL )
    {      
		if( !getparam( n, p, paramlist ) )
			break;
      
      n = nextSibling( n );
      
      if( n != NIL )
      	Append( paramlist, ", " );
      	
      ++p;
    }    
    Append( paramlist, ")" );
    
    return paramlist;
}

/*:::::*/
String * FREEBASIC :: getfuncres( Node *n )
{
	String *funcres;
	SwigType *type= Copy( Getattr( n, "type" ) );
	SwigType *decl = Copy( Getattr( n, "decl" ) );
	
    if( decl != NULL )
    	SwigType_pop_function( decl );
    
    //Printf( stdout, "%s %s %s\n", Getattr( n, "name" ), type, decl );
    
    if( type == NIL || SwigType_type( type ) == T_VOID && ((decl == NULL) || (Len( decl ) == 0)) )
    	funcres = NewString( "" );
    else
    {    	
    	funcres = NewString( " as " );
    	Append( funcres, remap_typeex( type, decl, false, true ) );
    }
    	    	
    return funcres;
}

/*:::::*/
int FREEBASIC :: emit_function( Node *n )
{
	String *name  = Getattr( n, "name" );
	//SwigType *type= Getattr( n, "type" );
	String *suborfunc;	
	
	if( ctx.lastemit != EMIT_FUNCTION )
		Printf( ctx.outf, "\n" );
		
	ctx.lastemit = EMIT_FUNCTION;
	
	// parameters
	String *paramlist = getparamlist( Getattr( n, "parms" ) );
    
    // result
    String *funcres = getfuncres( n );

	if( Len( funcres ) == 0 )
		suborfunc = NewString( "sub" );
	else
		suborfunc = NewString( "function" );
      
	Printf( ctx.outf, "declare %s %s %s alias \"%s\" %s%s\n", suborfunc, name, callconv, name, paramlist, funcres );
	
	return SWIG_OK;	
}


/*:::::*/
String * FREEBASIC :: strip_struct( String *s )
{
	if( s == NIL )
		return s;
	
	String *res = Copy( s );
	
	// remove "struct" and "union" from names
	if( Strncmp( res, "struct ", 7 ) == 0 )
		Replace( res, "struct ", "", DOH_REPLACE_FIRST );
	else if( Strncmp( res, "union ", 6 ) == 0 )
		Replace( res, "union ", "", DOH_REPLACE_FIRST );
	// "enum" too
	else if( Strncmp( res, "enum ", 5 ) == 0 )
		Replace( res, "enum ", "", DOH_REPLACE_FIRST );
		
	return res;
}

/*:::::*/
int FREEBASIC :: emit_extern( Node *n )
{
	String *import = (isdll? NewString( " import" ) : NewString( "" ));
	String *arraydim = NewString( "" );
	String *type;
	String *name = Getattr( n, "name" );
      
	// handle char[]
	type = field_getfixstring( n );
	if( type == NULL )
	{
		//handle function ptr
		type = remap_funcptr( n );
		if( type == NULL )
		{
			arraydim = field_getarraydims( n );
			type = remap_typeex( Copy( Getattr( n, "type" ) ), Copy( Getattr( n, "decl" ) ), false, true );
		}
	}
	
	Printf( ctx.outf, "extern%s %s%s alias \"%s\" as %s\n", import, name, arraydim, name, type );
	
	return SWIG_OK;	
}

/*:::::*/
String * FREEBASIC :: getfuncptr( SwigType *type, SwigType *basetype )
{
	if( type == NIL )
		return NewString( "sub" );
	
	ParmList *pl = SwigType_function_parms( type );
	String *res;
		
	// sub or function?
	if( basetype == NIL || SwigType_type( basetype ) == T_VOID )
		res = NewString( "sub " );
	else
		res = NewString( "function " );
      
	// calling convention
	Append( res, callconv );
	
	// parameters
	Append( res, getparamlist( pl ) );
    	
    // sub? there's no result type
    if( SwigType_type( basetype ) == T_VOID )
    	return res;
    	
    // otherwise, make result
    Append( res, " as " );    	
    Append( res, remap_typeex( Copy( basetype ), NULL, false, true ) );

	// remove function (from original)
	SwigType_pop_function( type );
	
	// function pointer returning pointers?
	while( SwigType_ispointer( type ) )
	{
		SwigType_del_pointer( type );
		Append( res, " ptr" );
	}
    
    return res;    
}

/*:::::*/
String * FREEBASIC :: remap_type( Node *n, bool byteptrtostring )
{
	return 	remap_typeex( Copy( Getattr( n, "type" ) ), Copy( Getattr( n, "decl" ) ), byteptrtostring, false );
}

/*:::::*/
String * FREEBASIC :: remap_typeex( SwigType *type, SwigType *decl, bool byteptrtostring, bool byteptrtozstring )
{
	String *res = NULL;
	int ptrcnt = 0;
	bool typechanged;
	bool ischar = false;
	
	//Printf( stdout, "%s:%s \n", type, decl );
	
	// typeless? this happens with typedef's of nameless structs/unions
	if( (type == NULL) || (Strncmp( type, "$unnamed", 8 ) == 0) )
	{
		type = Copy( ctx.laststructname );
		if( type == NULL )
		{
			if( decl == NULL )
				return NewString( "" );
				
			type = decl;
			decl = NULL;
		}
	}
	
	// count pointers and remove qualifiers (const etc)	
	do
	{
		typechanged = false;
		
		// pointer?
		if( SwigType_ispointer( type ) )
		{			
			++ptrcnt;
			// remove it (from original)
			SwigType_del_pointer( type );
			typechanged = true;
		}

		// array?
		if( SwigType_isarray( type ) )
		{
			ptrcnt += SwigType_array_ndim( type );
			// remove it (from original)
			SwigType_del_array( type );
			typechanged = true;
		}
		
		// qualifier?
		if( SwigType_isqualifier( type ) )
		{
			// remove it (from original)
			SwigType_del_qualifier( type );
			typechanged = true;
		}
		
	} while( typechanged );
	
	// function pointer?
	if( SwigType_isfunction( type ) )
	{
		return getfuncptr( type, SwigType_base( type ) );
	}
		
	//
	res = NewString( "" );

	// if it's another complex type, just copy as-is
	if( SwigType_istypedef( type ) || SwigType_isenum( type ) || SwigType_isclass( type ) )
	{
		Append( res, type );
	}
	// otherwise, lookup the FB type
	else
	{
		switch( SwigType_type( type ) ) 
		{
		case T_BOOL:
    	case T_INT:
    	case T_LONG:
			Append( res, "integer" );
			break;
    
    	case T_SHORT:
			Append( res, "short" );
			break;
    
    	case T_CHAR:
    	case T_SCHAR:
			ischar = true;
			if( (ptrcnt == 1) && byteptrtostring ) 
			{
				Append( res, "zstring ptr" );
				ptrcnt = 0;
			} 
			else 
				Append( res, "byte" );
			
			break;
    
    	case T_UINT:
    	case T_ULONG:
			Append( res, "uinteger" );
			break;
    
    	case T_USHORT:
			Append( res, "ushort" );
			break;
    
    	case T_UCHAR:
			Append( res, "ubyte" );
			break;

    	case T_LONGLONG:
			Append( res, "longint" );
			break;
    	
    	case T_ULONGLONG:
			Append( res, "ulongint" );
			break;

    	case T_DOUBLE:
    	case T_LONGDOUBLE:
			Append( res, "double" );
			break;
    
    	case T_FLOAT:
			Append( res, "single" );
			break;
    
    	case T_VOID:
			Append( res, "any" );
			break;
    
		case T_POINTER:
			Append( res, "any ptr" );
			break;
	
    	case T_USER:    		
    		notfoundsymb_add( strip_struct( type ) );

    	case T_ARRAY:
    	case T_REFERENCE:
	
		default:
			Append( res, type );
		}
	}
	
	//
	res = strip_struct( res );
	
	// add pointers, if any
	if( ptrcnt > 0 )
	{
		while( ptrcnt > 0 )
		{
			Append( res, " ptr" );
			--ptrcnt;
		}
			
	}
	// otherwise check if decl is a pointer
	else
	{
		if( decl != NULL )
			do
			{
				typechanged = false;
						
				// qualifier? remove
				if( SwigType_isqualifier( decl ) )
				{
					SwigType_del_qualifier( decl );
					typechanged = true;
				}
			
				// pointer?
				if( SwigType_ispointer( decl ) )
				{
					++ptrcnt;
					SwigType_del_pointer( decl );
					typechanged = true;
				}
		
				// array?
				if( SwigType_isarray( decl ) )
				{
					ptrcnt += SwigType_array_ndim( decl );
					SwigType_del_array( decl );
					typechanged = true;
				}

			} while( typechanged );

		//
		if( ischar && (ptrcnt == 1) && byteptrtozstring )
			res = NewString( "zstring ptr" );
		
		else		
			while( ptrcnt > 0 )
			{
				Append( res, " ptr" );
				--ptrcnt;
			}
	}
	
	return res;
}

/*:::::*/
String * FREEBASIC :: remap_funcptr( Node *n )
{
	SwigType *decl = Copy( Getattr( n, "decl" ) );
	
	if( decl == NIL )
		return NULL;
	
	// pointer?
	if( !SwigType_ispointer( decl ) )
		return NULL;
		
	// remove it (from copy)
	SwigType_del_pointer( decl );
	
	// function?
	if( !SwigType_isfunction( decl ) )
		return NULL;
	
	return getfuncptr( decl, Getattr( n, "type" ) );
}


/*:::::*/
String * FREEBASIC :: field_getbitfield( Node *n )
{
	String *res;
	SwigType *bitfield = Getattr( n, "bitfield" );
	
	//
	if( bitfield != NIL )
	{
		res = NewString( ":" );
		Append( res, bitfield );
	}
	else
		res = NewString( "" );
	
	return res;
}

/*:::::*/
String * FREEBASIC :: field_getarraydims( Node *n )
{
	String *res = NewString( "" );
	SwigType *decl = Getattr( n, "decl" );
	
	// decl contains the array definition
	if( decl != NIL )
	{
		// array?
		if( SwigType_isarray( decl ) )
		{
			// for each dimension..
			Append( res, "(" );
			for( int d = 0; d < SwigType_array_ndim( decl ); d++ )
			{
				Append( res, "0 to " );
				Append( res, SwigType_array_getdim( decl, d ) );
				Append( res, "-1" );
				
				if( d+1 < SwigType_array_ndim( decl ) ) 
					Append( res, ", " );
			}
			Append( res, ")" );
		
			// remove it (from original)
			SwigType_del_array( decl );
		}
	}
	
	return res;
}

/*:::::*/
String * FREEBASIC :: field_getfixstring( Node *n )
{
	SwigType *type = Getattr( n, "type" );	
	
	if( type == NIL )
		return NULL;
	
	// char?
	if( SwigType_type( type ) != T_CHAR )
		return NULL;
	
	// decl contains the array definition
	SwigType *decl = Getattr( n, "decl" );
		
	if( decl == NIL )
		return NULL;
	
	// array?
	if( !SwigType_isarray( decl ) )
		return NULL;
		
	// single dim?
	if( SwigType_array_ndim( decl ) != 1 )
		return NULL;
	
	String *res = NewString( "zstring * " );
	Append( res, SwigType_array_getdim( decl, 0 ) );
	
	return res;
}

/*:::::*/
void FREEBASIC :: notfoundsymb_add( String *s )
{
    String *headers;	
    
    headers = Getattr( usertb, s );
    if( headers == NULL )
    	headers = NewString( curr_header );
    else
    {
    	if( Strstr( headers, curr_header ) == NULL )
    	{
    		Append( headers, "; " );
    		Append( headers, curr_header );
    	}
    }
    	
    Setattr( usertb, s, headers );
    		
}

/*:::::*/
extern "C" Language *swig_freebasic( void ) 
{
	return new FREEBASIC();
}
