option explicit
option private

#include once "libxml/xmlreader.bi"

#define NULL 0

'':::::
function asstring( byval p as byte ptr ) as string
	asstring = *p
end function

'':::::
sub processNode( byval reader as xmlTextReaderPtr )
    dim constname as xmlChar ptr, value as xmlChar ptr
    dim namestr as string

    constname = xmlTextReaderConstName( reader )
    if( constname = NULL ) then
		namestr = "--"
	else
		namestr = *constname
	end if

    value = xmlTextReaderConstValue( reader )

    print xmlTextReaderDepth( reader ); xmlTextReaderNodeType( reader ); _
	      namestr; _
	      xmlTextReaderIsEmptyElement(reader); xmlTextReaderHasValue( reader );
    
    if( value = NULL ) then
		print
    else
		print asstring( value )
    end if
end sub

'':::::
sub streamFile( byval filename as string )
    dim reader as xmlTextReaderPtr
    dim ret as integer

    reader = xmlReaderForFile( filename, NULL, 0 )
    
    if (reader <> NULL) then
        ret = xmlTextReaderRead( reader )
        do while( ret = 1 )
            processNode( reader )
            ret = xmlTextReaderRead( reader )
        loop
        
        xmlFreeTextReader( reader )
        
        if( ret <> 0 ) then
            print "failed to parse: "; filename
        end if
    else
        print "Unable to open "; filename
    end if

end sub


''::::::
    dim filename as string
    
    filename = command$(1)
    
    if( len( filename ) = 0 ) then
    	print "Usage: read1 filename"
    	end 1
	end if
    	
    LIBXML_TEST_VERSION
    	
    streamFile( filename )

    xmlCleanupParser( )
    
    xmlMemoryDump()
    
