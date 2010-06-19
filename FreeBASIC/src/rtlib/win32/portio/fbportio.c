/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * fbportio.c -- tiny Win32 kernel driver to enable I/O ports access
 *
 * chng: aug/2005 written [lillo]
 *
 */

/*
 * Many thanks to these useful references:
 *
 * http://www.beyondlogic.org/porttalk/porttalk.htm
 * http://www.codeproject.com/system/kportII.asp
 * http://www.logix4u.net/inpout32.htm
 *
 * This code was written to provide a tiny implementation of the theory described there.
 */

#ifndef __GNUC__
#include <ntddk.h>
#undef STDCALL
#define STDCALL __stdcall
#else
#include <ddk/ntddk.h>
#endif

#include "fbportio.h"

#define DEVICE_NAME			L"\\Device\\fbportio"
#define DEVICE_DOS_NAME		L"\\DosDevices\\fbportio"
#define IOPM_SIZE			0x2000


typedef UCHAR IOPM[IOPM_SIZE];

static IOPM *IOPM_map = NULL;


/* some undocumented kernel API calls ;) */
NTSTATUS NTAPI PsLookupProcessByProcessId( IN ULONG, OUT struct _EPROCESS ** );
void NTAPI Ke386SetIoAccessMap( int, IOPM * );
void NTAPI Ke386IoSetAccessProcess( PEPROCESS, int );


/*:::::*/
static NTSTATUS STDCALL device_dispatch( IN PDEVICE_OBJECT DeviceObject, IN PIRP Irp )
{
    Irp->IoStatus.Information = 0;
    Irp->IoStatus.Status = STATUS_SUCCESS;
    IoCompleteRequest( Irp, IO_NO_INCREMENT );
    
    return STATUS_SUCCESS;
}


/*:::::*/
static NTSTATUS STDCALL device_control( IN PDEVICE_OBJECT DeviceObject, IN PIRP Irp )
{
    PIO_STACK_LOCATION stack;
    PULONG ldata;
    PUSHORT sdata;
    ULONG in_size, out_size, pid;
    ULONG written_bytes = 0;
    NTSTATUS status;
    struct _EPROCESS *process;
    
    stack = IoGetCurrentIrpStackLocation( Irp );
    in_size = stack->Parameters.DeviceIoControl.InputBufferLength;
    out_size = stack->Parameters.DeviceIoControl.OutputBufferLength;
    ldata = (PULONG)Irp->AssociatedIrp.SystemBuffer;
    sdata = (PUSHORT)Irp->AssociatedIrp.SystemBuffer;

	switch( stack->Parameters.DeviceIoControl.IoControlCode ) {
	
		case IOCTL_GRANT_IOPM:
			if( in_size < 4 )
				status = STATUS_BUFFER_TOO_SMALL;
			else {
				pid = ldata[0];
				status = PsLookupProcessByProcessId( pid, &process );
				if( NT_SUCCESS( status ) ) {
					/* copy the IOPM bitmap to the process task state segment */
					Ke386SetIoAccessMap( 1, IOPM_map );
					/* inform the kernel the process has a custom IOPM bitmap */
					Ke386IoSetAccessProcess( process, 1 );
					status = STATUS_SUCCESS;
				}
			}
			break;
		
		case IOCTL_GET_VERSION:
			if( out_size < 2 )
				status = STATUS_BUFFER_TOO_SMALL;
			else {
				sdata[0] = FBPORTIO_VERSION;
				written_bytes = 2;
				status = STATUS_SUCCESS;
			}
			break;
			
		default:
			status = STATUS_UNSUCCESSFUL;
			break;
	}
	
	Irp->IoStatus.Information = written_bytes;
	Irp->IoStatus.Status = status;
	IoCompleteRequest( Irp, IO_NO_INCREMENT );
	
	return status;
}


/*:::::*/
static VOID STDCALL driver_unload( IN PDRIVER_OBJECT DriverObject )
{
    WCHAR dos_name_buffer[] = DEVICE_DOS_NAME;
    UNICODE_STRING unicode_dos_name;

    if( IOPM_map )
    	MmFreeNonCachedMemory( IOPM_map, sizeof(IOPM) );
    
    RtlInitUnicodeString( &unicode_dos_name, dos_name_buffer );
    IoDeleteSymbolicLink( &unicode_dos_name );
    IoDeleteDevice( DriverObject->DeviceObject );
}


/*:::::*/
NTSTATUS STDCALL DriverEntry( IN PDRIVER_OBJECT DriverObject, IN PUNICODE_STRING RegistryPath )
{
    PDEVICE_OBJECT device_object;
    NTSTATUS status;
    WCHAR name_buffer[] = DEVICE_NAME;
    WCHAR dos_name_buffer[] = DEVICE_DOS_NAME;
    UNICODE_STRING unicode_name, unicode_dos_name;

    IOPM_map = MmAllocateNonCachedMemory( sizeof(IOPM) );
    if( !IOPM_map )
    	return STATUS_INSUFFICIENT_RESOURCES;

	/* clear all bits of the IOPM map, granting access to all ports */
	RtlZeroMemory( IOPM_map, sizeof(IOPM) );

    RtlInitUnicodeString( &unicode_name, name_buffer );
    RtlInitUnicodeString( &unicode_dos_name, dos_name_buffer );

    status = IoCreateDevice( DriverObject, 0, &unicode_name, FILE_DEVICE_UNKNOWN, 0, FALSE, &device_object );
    if( !NT_SUCCESS( status ) )
        return status;

    status = IoCreateSymbolicLink ( &unicode_dos_name, &unicode_name );
    if( !NT_SUCCESS( status ) )
        return status;

    DriverObject->MajorFunction[IRP_MJ_CREATE] =
        device_dispatch;
    DriverObject->MajorFunction[IRP_MJ_DEVICE_CONTROL] =
        device_control;
    DriverObject->DriverUnload =
        driver_unload;

    return STATUS_SUCCESS;
}
