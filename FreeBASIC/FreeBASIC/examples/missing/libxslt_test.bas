

#include once "libxml/xmlmemory.bi"
#include once "libxml/debugXML.bi"
#include once "libxml/HTMLtree.bi"
#include once "libxml/xmlIO.bi"
#include once "libxml/xinclude.bi"
#include once "libxml/catalog.bi"
#include once "libxslt/xslt.bi"
#include once "libxslt/xsltInternals.bi"
#include once "libxslt/transform.bi"
#include once "libxslt/xsltutils.bi"

#ifndef NULL
#define NULL 0
#endif

extern import xmlLoadExtDtdDefaultValue alias "__xmlLoadExtDtdDefaultValue" as integer

	dim as xsltStylesheetPtr cur
	dim as xmlDocPtr doc, res
	dim as string xmlfile, xslfile, params(0 to 16)
	dim as zstring ptr paramptrs(0 to 16)
	dim as integer i, p
	
	xmlfile = command(1)
	xslfile = command(2)
	
	if( len( xmlfile ) = 0 or len( xslfile ) = 0 ) then
		print "Usage: xml_file stylesheet_file [name value (pass a (parameter,value) pair)]"	
		end 1
	end if
	
	'' read the params
	p = 0
	do
		params(i) = command( 2 + p )
		if( len( params(p) ) = 0 ) then
			exit do
		end if
		p += 1
	loop 
	
	'' create a table with pointers to params()
	for i = 0 to p-1
		paramptrs(i) = strptr( params(i) )
	next i
	paramptrs(p) = NULL
	
	''
	xmlSubstituteEntitiesDefault( 1 )
	xmlLoadExtDtdDefaultValue = 1
	cur = xsltParseStylesheetFile( xmlfile )
	doc = xmlParseFile( xslfile )
	res = xsltApplyStylesheet( cur, doc, @paramptrs(0) )
	''xsltSaveResultToFile( f???, res, cur )

	xsltFreeStylesheet(cur)
	xmlFreeDoc(res)
	xmlFreeDoc(doc)

    xsltCleanupGlobals()
    xmlCleanupParser()
