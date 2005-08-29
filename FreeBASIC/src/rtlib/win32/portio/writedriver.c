#include <stdio.h>

#include "fbportio.h"
#include "fbportio_driver.h"

int main(int argc, char **argv)
{
    FILE *fpDriver = fopen( FBPORTIO_NAME ".sys", "wb" );
    if( fpDriver==NULL ) {
        fprintf( stderr, "Failed to write driver\n" );
    } else {
        if( fwrite( fbportio_driver, FBPORTIO_DRIVER_SIZE, 1, fpDriver )!=1 ) {
            fprintf( stderr, "Failed to write driver\n" );
        }
        fclose( fpDriver );
    }
    return 0;
}
