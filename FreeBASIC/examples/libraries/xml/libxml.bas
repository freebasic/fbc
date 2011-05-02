
#include once "libxml/xmlreader.bi"

#define NULL 0

'':::::
sub processNode( byval reader as xmlTextReaderPtr )
    dim constname as zstring ptr, value as zstring ptr

    constname = xmlTextReaderConstName( reader )

    value = xmlTextReaderConstValue( reader )

    print xmlTextReaderDepth( reader ); xmlTextReaderNodeType( reader ); _
	      " "; *constname; _
	      xmlTextReaderIsEmptyElement(reader); xmlTextReaderHasValue( reader );
    
	print *value
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
    
    filename = command(1)
    
    if( len( filename ) = 0 ) then
    	print "Usage: libxml filename"
    	end 1
	end if
    	
    'LIBXML_TEST_VERSION
    	
    streamFile( filename )

    xmlCleanupParser( )
    
    xmlMemoryDump()
    
