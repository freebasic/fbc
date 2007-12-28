#include <stdio.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include "fb_gfx.h"

const char *strTokDelim = " \t";
typedef struct _data_column {
    char *pszToken;
    struct _data_column *pNext;
} data_column;

typedef struct _data_entry {
    unsigned char *pData;
    size_t Size;
    struct _data_entry *pNext;
} data_entry;

static __inline__
char *GetColumnToken( const data_column *pColumns, size_t columns, size_t index )
{
    assert( index<columns );
    index = columns - index - 1;
    while( index-- )
        pColumns = pColumns->pNext;
    return pColumns->pszToken;
}

#define OUTPUT_DAT FALSE

static char *make_fullpath( const char *path, const char *filename )
{
	int len = strlen( path );
	int addslash;

	if( len == 0 )
		return strdup( filename );

	addslash = (path[len - 1] == '/'? 0 : 1);
	
	char *fullpath = (char *)malloc( len + strlen( filename ) + 1 + addslash );
	fullpath[0] = '\0';
	
	strcat( fullpath, path );
	
	if( addslash != 0 )
    	strcat( fullpath, "/" );
    	
    strcat( fullpath, filename );
    
    return fullpath;
}

int main(int argc, char **argv)
{
    const char *pszDataListPath = "data/";
    const char *pszDataListFileName = "data.lst";
#if OUTPUT_DAT
    const char *pszDataFileName = "data.dat";
#endif
    const char *pszDataSourceFileName = "data.c";
    char *pszFullDataFilePath;

    int data_size_raw, data_size_compressed;
    unsigned char *data_raw;
    unsigned char *data_compressed;
    data_entry *pEntry;

    FILE *fpDataIn, *fpSourceOut;
#if OUTPUT_DAT
    FILE *fpDataOut;
#endif
    char data_list_entry[256];
    unsigned data_offset = 0;
    data_entry *data_start = NULL, *data_end = NULL;

    int i;
    int arg_index;

    if( argc!=0 ) {
        const char *arg_prev = NULL;
        for( arg_index=1; arg_index!=argc; ++arg_index ) {
            const char *arg = argv[arg_index];
            if( arg_prev!=NULL ) 
            {
                if( strcmp( arg_prev, "-o" )==0 ) 
                {
                    pszDataSourceFileName = arg;
                }
                else if( strcmp( arg_prev, "-I" )==0 ) 
                {
					pszDataListPath = arg;
                } 
                else 
                {
                    assert( FALSE );
                }
                arg_prev = NULL;
            } 
            else 
            {
                if( strcmp( arg, "-o" )==0 ) 
                {
                    arg_prev = arg;
                }
                else if( strcmp( arg, "-I" )==0 ) 
                {
                    arg_prev = arg;
                } 
                else 
                {
                    fprintf( stderr, "Unknown argument '%s'\n", arg );
                    return 4;
                }
            }
        }
    }

    pszFullDataFilePath = make_fullpath( pszDataListPath, pszDataListFileName );
    
    fpDataIn = fopen( pszFullDataFilePath, "r");
    if ( fpDataIn==NULL ) {
        fprintf( stderr, "Failed to open '%s'\n", pszFullDataFilePath );
        return 1;
    }
    
    free( pszFullDataFilePath );

#if OUTPUT_DAT
    fpDataOut = fopen(pszDataFileName, "wb");
    if ( fpDataOut==NULL ) {
        fprintf( stderr, "Failed to create '%s'\n", pszDataFileName );
        return 1;
    }
#endif

    fpSourceOut = fopen(pszDataSourceFileName, "w");
    if ( fpSourceOut==NULL ) {
        fprintf( stderr, "Failed to create '%s'\n", pszDataSourceFileName );
        return 1;
    }

    fprintf( fpSourceOut,
             "/* DO NOT EDIT! This file was automatically created by mk_dat */\n"
             "\n"
             "/* data.c -- internal font/palette compressed data */\n"
             "\n"
             "#include \"fb_gfx.h\"\n"
             "\n" 
             "static unsigned char internal_data[], inited = FALSE;\n"
           );


    while( fgets( data_list_entry, sizeof(data_list_entry)-1, fpDataIn )!=NULL ) {
        char *strToken;
        data_column *pColumns;
        size_t columns;
        size_t line_len;

        data_list_entry[sizeof(data_list_entry)-1]=0;
        line_len = strlen( data_list_entry );
        while( line_len!=0 && (data_list_entry[line_len-1]=='\n' || data_list_entry[line_len-1]=='\r') )
            --line_len;
        if( line_len==0 )
            continue;
        data_list_entry[line_len] = 0;

        if( data_list_entry[0]==';' )
            continue;

        /* Split the columns */
        pColumns = NULL;
        columns = 0;
        strToken = strtok( data_list_entry, strTokDelim );
        if( strToken!=NULL ) {
            do {
                data_column *pColumn = (data_column*) calloc( 1, sizeof( data_column ) );
                pColumn->pszToken = strdup( strToken );
                pColumn->pNext = pColumns;
                pColumns = pColumn;
                ++columns;
            } while( (strToken = strtok( NULL, strTokDelim ))!=NULL );
        }

        if( columns!=6 ) {
            fprintf( stderr, "Invalid number of columns in data list\n" );
            return 3;
        }

        {
            FILE *fpDataFile;
            const char *pszType = GetColumnToken( pColumns, columns, 0 );
            const char *pszOffsetDefine = GetColumnToken( pColumns, columns, 1 );
            const char *pszVarName = GetColumnToken( pColumns, columns, 2 );
            const char *pszNumValue1 = GetColumnToken( pColumns, columns, 3 );
            const char *pszNumValue2 = GetColumnToken( pColumns, columns, 4 );
            const char *pszFileName = GetColumnToken( pColumns, columns, 5 );
            long lDataSize;

            fprintf( fpSourceOut,
                     "#define DATA_%s\t0x%08x\n",
                     pszOffsetDefine,
                     data_offset );
            if( strcmp( pszType, "FONT" )==0 ) {
                fprintf( fpSourceOut,
                         "const %s %s\t= { %s, %s, &internal_data[DATA_%s] };\n",
                         pszType,
                         pszVarName,
                         pszNumValue1,
                         pszNumValue2,
                         pszOffsetDefine );
            } else {
                fprintf( fpSourceOut,
                         "const %s %s\t= { %s, &internal_data[DATA_%s] };\n",
                         pszType,
                         pszVarName,
                         pszNumValue1,
                         pszOffsetDefine );
            }

            {
                pszFullDataFilePath = make_fullpath( pszDataListPath, pszFileName );
                fpDataFile = fopen(pszFullDataFilePath, "rb");
                if( fpDataFile==NULL ) {
                    fprintf( stderr, "Failed to open '%s'\n", pszFullDataFilePath );
                    return 1;
                }
                free( pszFullDataFilePath );
            }

            fseek( fpDataFile, 0, SEEK_END );
            lDataSize = ftell( fpDataFile );
            fseek( fpDataFile, 0, SEEK_SET );

            pEntry = (data_entry*) calloc( 1, sizeof( data_entry ));
            pEntry->Size = lDataSize;
            pEntry->pData = (unsigned char*) malloc( pEntry->Size );
            fread( pEntry->pData, pEntry->Size, 1, fpDataFile );

            if( data_start==NULL ) {
                data_start = data_end = pEntry;
            } else {
                data_end->pNext = pEntry;
                data_end = pEntry;
            }

            fclose( fpDataFile );

            data_offset += pEntry->Size;
        }

        /* Free the columns */
        while( pColumns!=NULL ) {
            data_column *pNext = pColumns->pNext;
            free( pColumns->pszToken );
            free( pColumns );
            pColumns = pNext;
        }
    }
    if( !feof( fpDataIn ) ) {
        fprintf( stderr, "Read error\n" );
        return 2;
    }

    data_size_raw = data_offset;
    data_size_compressed = data_size_raw;
    data_raw = (unsigned char *)malloc( data_size_raw );
    data_compressed = (unsigned char *)malloc( data_size_compressed );

    data_offset = 0;
    pEntry = data_start;
    while( pEntry!=NULL ) {
        memcpy( data_raw + data_offset,
                pEntry->pData,
                pEntry->Size );
        data_offset += pEntry->Size;
        pEntry = pEntry->pNext;
    }

#if OUTPUT_DAT
    fwrite( data_raw, data_size_raw, 1, fpDataOut );
#endif

    fb_hEncode(data_raw,
               data_size_raw,
               data_compressed,
               &data_size_compressed);

    fprintf( fpSourceOut,
             "\n"
             "static const unsigned char compressed_data[] = {\n" );

    for( i=0; i!=data_size_compressed; ) {
        size_t remaining = data_size_compressed - i;
        if( remaining > 16 )
            remaining = 16;
        i += remaining;
        fprintf( fpSourceOut,
                "    " );
        while( remaining ) {
            fprintf( fpSourceOut,
                     "0x%02X",
                     (unsigned) data_compressed[i-remaining] );
            if( --remaining!=0 ) {
                fprintf( fpSourceOut, ", " );
            }
        }
        if( i!=data_size_compressed ) {
            fprintf( fpSourceOut, "," );
        }
        fprintf( fpSourceOut, "\n" );
    }

    fprintf( fpSourceOut,
             "};\n"
             "\n" );

    fprintf( fpSourceOut,
             "#define DATA_SIZE %u\n"
             "static unsigned char internal_data[DATA_SIZE];\n"
             "\n",
             data_size_raw );

    fprintf( fpSourceOut,
             "void fb_hSetupData(void)\n"
             "{\n"
             "    int size = DATA_SIZE;\n"
             "    if (inited)\n"
             "        return;\n"
             "    fb_hDecode(compressed_data, sizeof(compressed_data), internal_data, &size);\n"
             "    inited = TRUE;\n"
             "}\n"
             "\n"
           );

    fclose( fpSourceOut );
#if OUTPUT_DAT
    fclose( fpDataOut );
#endif
    fclose( fpDataIn );
    
    printf("mk_dat: %d bytes in, %d bytes out (%f:1 ratio)\n",
    	data_size_raw, data_size_compressed, (float)data_size_raw / (float)data_size_compressed);
    
    return 0;
}
