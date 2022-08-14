/* serial port driver for Dos */

#include "../fb.h"
#include "../io_serial_private.h"
#include <dos.h>
#include <pc.h>
#include <go32.h>
#include <dpmi.h>

/* PIC port addresses. */
#define ICU1_BASE	0x20
#define ICU1_OCW2	(ICU1_BASE + 0)
#define ICU1_MASK	(ICU1_BASE + 1)

#define ICU2_BASE	0xA0
#define ICU2_OCW2	(ICU2_BASE + 0)
#define ICU2_MASK	(ICU2_BASE + 1)

/* UART port registers */
#define UART_RBR	0x00  /* DLAB = 0 - Receive Buffer*/
#define UART_THR	0x00  /* DLAB = 0 - Transmit Hold */
#define UART_IER	0x01  /* interrupt enable register */
#define UART_IIR	0x02  /* interrupt ID register */
#define UART_FCR	0x02  /* FIFO control register */
#define UART_LCR	0x03  /* line control / data format */
#define UART_MCR	0x04  /* modem control register */
#define UART_LSR	0x05  /* line status register */
#define UART_MSR	0x06  /* modem status register */
#define UART_SCR	0x07  /* scratch register */
#define UART_DL_LSB 0x00  /* DLAB = 1 */
#define UART_DL_MSB 0x01  /* DLAB = 1 */

#define LCR_DLAB 0x80

#define MCR_OUT2 8
#define MCR_OUT1 4
#define MCR_RTS 2
#define MCR_DTR 1

#define IER_SINP 8
#define IER_EBRK 4
#define IER_TBE  2
#define IER_RXRD 1

/* FLAGS */
#define FLAG_KEEP_DTR 1
#define FLAG_SUPPRESS_RTS 2

/* UART types */
#define UART_IS_NONE   0
#define UART_IS_8250   1
#define UART_IS_16450  2
#define UART_IS_16550  3
#define UART_IS_16550A 4

#define DEFAULT_BUFFERSIZE 2048
#define MAX_BUFFERSIZE 0x40000000

#define COMM_CHECKED_CHIPTYPE 1
#define COMM_HAVE_BUFFER 2

/* irq3 to irq15 are supported */
#define FIRST_IRQ 3
#define IRQ_COUNT 13
#define LAST_IRQ (FIRST_IRQ+IRQ_COUNT-1)

#define MAX_COMM 4

#define COMM_PROPS( n ) &comm_props[n-1]
#define IRQ_PROPS( n ) &irq_props[n-FIRST_IRQ]

/*
	This define will make this source use the "built-in" 
	DOS-ISR	management routines. My tests failed under 
	win98 using the fb_isr_set() routines whereas the 
	ones defined in this module appear to work OK. 
	(jeffm)

	#define FB_MANAGED_IRQ
*/

typedef struct
{
	int usecount;						/* irq usage count for IRQ sharing */
	int old_pic1_mask;					/* old pic1 mask (master) */
	int old_pic2_mask;					/* old pic2 mask (slave) */
	int first;							/* first comm in shared IRQ chain */
#ifndef FB_MANAGED_IRQ
	int irq;
	int intnum;							/* interrupt number */
	void (*irq_handler) ( void );		/* irq handler */
	_go32_dpmi_seginfo old_rmhandler;
	_go32_dpmi_seginfo old_pmhandler;
	_go32_dpmi_seginfo new_rmhandler;
	_go32_dpmi_seginfo new_pmhandler;
	_go32_dpmi_registers regs;
#endif
} irq_props_t;

typedef struct
{
	unsigned char * data;	/* pointer to buffer */
	int size;				/* size of buffer */
	int head;				/* next char position to get */
	int tail;				/* next char position to put */
	int length; 			/* length of chars to get in the buffer */
} buffer_t;

typedef struct
{
	int baseaddr;	/* base port address */
	int def_irq;	/* default irq number */
	int irq;		/* actual irq number in use */
	int initflags;	/* initialization flags */
	int inuse;		/* in use flag */
	int chiptype;	/* chiptype */
	int counter;	/* interrupt counter */
	int next;		/* next comm in shared IRQ */
	buffer_t rxbuf; /* receive buffer */
	buffer_t txbuf; /* transmit buffer */
	int txclear;	/* transmit buffer cleared */
	int flags;		/* additional flags */
} comm_props_t;

/* private local procs */
static int UART_detect_chiptype( unsigned int baseaddr );
static int UART_set_baud( unsigned int baseaddr, int baud );
static int UART_set_data_format( unsigned int baseaddr,
	int parity, int data, int stop );
static int comm_isr( unsigned irq );
static int comm_init( int com_num, unsigned int baseaddr, int irq );
static void comm_exit( int com_num );

#ifndef FB_MANAGED_IRQ	

static void comm_handler_irq_3 ( void );
static void comm_handler_irq_4 ( void );
static void comm_handler_irq_5 ( void );
static void comm_handler_irq_6 ( void );
static void comm_handler_irq_7 ( void );
static void comm_handler_irq_8 ( void );
static void comm_handler_irq_9 ( void );
static void comm_handler_irq_10( void );
static void comm_handler_irq_11( void );
static void comm_handler_irq_12( void );
static void comm_handler_irq_13( void );
static void comm_handler_irq_14( void );
static void comm_handler_irq_15( void );

static int comm_init_irq( irq_props_t *ip );
static void comm_exit_irq( irq_props_t *ip );
#define ENABLE() enable()
#define DISABLE() disable()

#else /* !FB_MANAGED_IRQ */

#define ENABLE() fb_dos_sti()
#define DISABLE() fb_dos_cli()

#endif /* FB_MANAGED_IRQ */

/* public procs */
int comm_open( int com_num, 
	int baud, int parity, int data, int stop, 
	int txbufsize, int rxbufsize, int flags, int irq );
int comm_close( int com_num );
int comm_putc( int com_num, int ch );
int comm_getc( int com_num );
int comm_bytes_remaining( int com_num );

/* local state */
static int comm_init_count = 0;

#ifndef FB_MANAGED_IRQ
static irq_props_t irq_props[IRQ_COUNT] = {
	{ 0, 0, 0, 0,  3, 0x0b, comm_handler_irq_3 , { 0 }, { 0 }, { 0 }, { 0 }, { { 0 } } },
	{ 0, 0, 0, 0,  4, 0x0c, comm_handler_irq_4 , { 0 }, { 0 }, { 0 }, { 0 }, { { 0 } } },
	{ 0, 0, 0, 0,  5, 0x0d, comm_handler_irq_5 , { 0 }, { 0 }, { 0 }, { 0 }, { { 0 } } },
	{ 0, 0, 0, 0,  6, 0x0e, comm_handler_irq_6 , { 0 }, { 0 }, { 0 }, { 0 }, { { 0 } } },
	{ 0, 0, 0, 0,  7, 0x0f, comm_handler_irq_7 , { 0 }, { 0 }, { 0 }, { 0 }, { { 0 } } },
	{ 0, 0, 0, 0,  8, 0x70, comm_handler_irq_8 , { 0 }, { 0 }, { 0 }, { 0 }, { { 0 } } },
	{ 0, 0, 0, 0,  9, 0x71, comm_handler_irq_9 , { 0 }, { 0 }, { 0 }, { 0 }, { { 0 } } },
	{ 0, 0, 0, 0, 10, 0x72, comm_handler_irq_10, { 0 }, { 0 }, { 0 }, { 0 }, { { 0 } } },
	{ 0, 0, 0, 0, 11, 0x73, comm_handler_irq_11, { 0 }, { 0 }, { 0 }, { 0 }, { { 0 } } },
	{ 0, 0, 0, 0, 12, 0x74, comm_handler_irq_12, { 0 }, { 0 }, { 0 }, { 0 }, { { 0 } } },
	{ 0, 0, 0, 0, 13, 0x75, comm_handler_irq_13, { 0 }, { 0 }, { 0 }, { 0 }, { { 0 } } },
	{ 0, 0, 0, 0, 14, 0x76, comm_handler_irq_14, { 0 }, { 0 }, { 0 }, { 0 }, { { 0 } } },
	{ 0, 0, 0, 0, 15, 0x77, comm_handler_irq_15, { 0 }, { 0 }, { 0 }, { 0 }, { { 0 } } }
};
#else
static irq_props_t irq_props[IRQ_COUNT] = {
	{ 0, 0, 0 },
	{ 0, 0, 0 },
	{ 0, 0, 0 },
	{ 0, 0, 0 },
	{ 0, 0, 0 },
	{ 0, 0, 0 },
	{ 0, 0, 0 },
	{ 0, 0, 0 },
	{ 0, 0, 0 },
	{ 0, 0, 0 },
	{ 0, 0, 0 },
	{ 0, 0, 0 },
	{ 0, 0, 0 }
};
#endif

static comm_props_t comm_props[MAX_COMM] = {
	{ 0x3f8, 4, 4, 0, 0, 0, 0, 0, { 0, 0, 0, 0, 0 }, { 0, 0, 0, 0, 0 }, 0, 0 },
	{ 0x2f8, 3, 3, 0, 0, 0, 0, 0, { 0, 0, 0, 0, 0 }, { 0, 0, 0, 0, 0 }, 0, 0 },
	{ 0x3e8, 4, 4, 0, 0, 0, 0, 0, { 0, 0, 0, 0, 0 }, { 0, 0, 0, 0, 0 }, 0, 0 },
	{ 0x2e8, 3, 3, 0, 0, 0, 0, 0, { 0, 0, 0, 0, 0 }, { 0, 0, 0, 0, 0 }, 0, 0 }
};

static inline unsigned int next_pow2( unsigned int n )
{
	--n;
	n |= n >> 16;
	n |= n >> 8;
	n |= n >> 4;
	n |= n >> 2;
	n |= n >> 1;
	++n;
	return n;
}

static void BUFFER_reset( buffer_t * buf )
{
	if( buf )
	{
		if( buf->data && buf->size )
			memset( buf->data, 0, buf->size);
		buf->head = buf->tail = buf->length = 0;
	}
}

static int BUFFER_alloc( buffer_t * buf, int size )
{
	size = next_pow2( size );

	buf->size = 0;

	buf->data = malloc( size );
	if( buf->data )
	{
		buf->size = size;
		fb_dos_lock_data( buf->data, buf->size);
	}

	BUFFER_reset( buf );

	/* TRUE = success */
	return ( buf->size != 0 ); 
}

static void BUFFER_free( buffer_t * buf )
{
	if( buf->data )
	{
		memset( buf->data, 0, buf->size);
		fb_dos_unlock_data( buf->data, buf->size);
		free( buf->data );
		buf->data = NULL;
	}
	buf->head = buf->tail = buf->size = buf->length = 0;
}

static int BUFFER_putc( buffer_t * buf, int ch )
{
	if( buf->length == buf->size )
		return -1;

	buf->data[ buf->tail ] = ch;
	buf->tail = (buf->tail + 1) & ( buf->size - 1 );
	buf->length++;

	return ch;
}
static void end_BUFFER_putc( void ) { }

static int BUFFER_getc( buffer_t * buf )
{
	int ch = -1;
	if( buf->length )
	{
		ch = buf->data[ buf->head ];
		buf->head = (buf->head + 1) & ( buf->size - 1 );
		buf->length--;
	}
	return ch;
}
static void end_BUFFER_getc( void ) { }

static int UART_detect_chiptype( unsigned int baseaddr )
{
	int tmp;

	/* test for LCR */
	outportb( baseaddr + UART_LCR ,0x1b );
	if ( inportb( baseaddr + UART_LCR ) != 0x1b )
		return UART_IS_NONE;

	outportb( baseaddr + UART_LCR, 0x3 );
	if ( inportb( baseaddr + UART_LCR ) != UART_LCR )
		return UART_IS_NONE;

	/* test for scratch register */
	outportb( baseaddr + UART_SCR, 0x55 );
	if ( inportb( baseaddr + UART_SCR ) != 0x55 )
		return UART_IS_8250;

	outportb( baseaddr + UART_SCR, 0xAA );
	if ( inportb( baseaddr + UART_SCR ) != 0xAA )
		return UART_IS_8250;

	/* check for FIFO */
	outportb(baseaddr + UART_FCR, 1);
	tmp = inportb( baseaddr + UART_IIR);

	if ( ( tmp & 0x80 ) == 0 )
		return UART_IS_16450;
	if ( ( tmp & 0x40 ) == 0 )
		return UART_IS_16550;

	/* clear FCR */
	outportb( baseaddr + UART_FCR, 0x0 );

	return UART_IS_16550A;
}

static int UART_set_baud( unsigned int baseaddr, int baud )
{
	int divisor, lsb, msb, tmp;

	if(( baud < 50 ) || ( baud > 115200 ))
		return FALSE;

	divisor = 115200 / baud;
	lsb = divisor & 0xff;
	msb = divisor >> 8;

	tmp = inportb( baseaddr + UART_LCR );
	tmp |= LCR_DLAB;
	outportb( baseaddr + UART_LCR, tmp );

	outportb( baseaddr + UART_DL_LSB, lsb );
	outportb( baseaddr + UART_DL_MSB, msb );

	tmp = inportb( baseaddr + UART_LCR );
	tmp &= ~LCR_DLAB;
	outportb( baseaddr + UART_LCR, tmp );

	return( TRUE );
}

static int UART_set_data_format( unsigned int baseaddr,
	int parity, int data, int stop )
{
	int fmt = 0;

	switch( data )
	{
	case 5:
		break;
	case 6:
		fmt |= 1;
		break;
	case 7:
		fmt |= 2;
		break;
	case 8:
		fmt |= 3;
		break;
	default:
		return FALSE;
	}

	switch( parity )
	{
	case FB_SERIAL_PARITY_NONE:
		break;
	case FB_SERIAL_PARITY_ODD:
		fmt |= 1 << 3;
		break;
	case FB_SERIAL_PARITY_EVEN:
		fmt |= 3 << 3;
		break;
	case FB_SERIAL_PARITY_MARK:
		fmt |= 5 << 3;
		break;
	case FB_SERIAL_PARITY_SPACE:
		fmt |= 7 << 3;
		break;
	default:
		return FALSE;
	}

	switch( stop )
	{
	case FB_SERIAL_STOP_BITS_1:
		break;
	case FB_SERIAL_STOP_BITS_1_5:
		if( data != 5 )
			return FALSE;
		break;
	case FB_SERIAL_STOP_BITS_2:
		fmt |= 4;
		break;
	default:
		return FALSE;
	}

	/* set data format - assumes DLAB is clear */
	outportb( baseaddr + UART_LCR, fmt );

	return TRUE;
}

#ifndef FB_MANAGED_IRQ	

static void comm_handler_irq_3( void ) { comm_isr( 3 ); } static void end_comm_handler_irq_3( void ) { }
static void comm_handler_irq_4( void ) { comm_isr( 4 ); } static void end_comm_handler_irq_4( void ) { }
static void comm_handler_irq_5( void ) { comm_isr( 5 ); } static void end_comm_handler_irq_5( void ) { }
static void comm_handler_irq_6( void ) { comm_isr( 6 ); } static void end_comm_handler_irq_6( void ) { }
static void comm_handler_irq_7( void ) { comm_isr( 7 ); } static void end_comm_handler_irq_7( void ) { }
static void comm_handler_irq_8( void ) { comm_isr( 8 ); } static void end_comm_handler_irq_8( void ) { }
static void comm_handler_irq_9( void ) { comm_isr( 9 ); } static void end_comm_handler_irq_9( void ) { }
static void comm_handler_irq_10( void ) { comm_isr( 10 ); } static void end_comm_handler_irq_10( void ) { }
static void comm_handler_irq_11( void ) { comm_isr( 11 ); } static void end_comm_handler_irq_11( void ) { }
static void comm_handler_irq_12( void ) { comm_isr( 12 ); } static void end_comm_handler_irq_12( void ) { }
static void comm_handler_irq_13( void ) { comm_isr( 13 ); } static void end_comm_handler_irq_13( void ) { }
static void comm_handler_irq_14( void ) { comm_isr( 14 ); } static void end_comm_handler_irq_14( void ) { }
static void comm_handler_irq_15( void ) { comm_isr( 15 ); } static void end_comm_handler_irq_15( void ) { }

#endif /* #ifndef FB_MANAGED_IRQ */

static int comm_isr( unsigned irq )
{
	comm_props_t *cp;
	irq_props_t *ip;
	int ret, i, ch;

	if( irq >= 8 )
	{
		/* end-of-interrupt */
		outportb( ICU2_OCW2, 0x20 );
	}
	/* end-of-interrupt */
	outportb( ICU1_OCW2, 0x20 );

#if 0
	ENABLE();
#endif

	ip = IRQ_PROPS(irq);

	if( ip->usecount == 0)
		return 0;

	i = ip->first;

	/* TODO: FIFO Support on UARTs that support it */

	while(i)
	{
		cp = COMM_PROPS(i);

		while(1)
		{
			ret = inportb( cp->baseaddr + UART_IIR ) & 0xf;

			if( ret == 1)
				break;

			switch( ret )
			{
			case 4:
				/* receive data */
				ch = inportb( cp->baseaddr + UART_RBR );
				BUFFER_putc( &cp->rxbuf, ch );
				break;

			case 2:
				/* tx buffer empty */
				ch = BUFFER_getc( &cp->txbuf );
				if( ch >= 0 )
				{
					cp->txclear = FALSE;
					outportb( cp->baseaddr + UART_THR, ch );

					/* TODO: check CTS if CS option set and start timer */

				}
				else
				{
					ret = inportb( cp->baseaddr + UART_IIR );
					cp->txclear = TRUE;
				}
				break;

			case 0:
				/* change in input signal */
				ret = inportb( cp->baseaddr + UART_MSR );

				/* TODO: start DSR low timer if DS option set  */
				/* TODO: start DCD low timer if CD option set  */
				/* TODO: check errors */

				break;

			case 6:
				/* reception error or break */
				ret = inportb( cp->baseaddr + UART_LSR );

				/* TODO: check errors */

				break;

			default:
				break;
			}

		}

		/* next comm port in a shared IRQ chain */
		i = cp->next;
	}
	return 0;
}
static void end_comm_isr( void ) { };

static void comm_init_addref( void )
{
	/* lock memory when comm ports are in use */
	if( comm_init_count == 0 )
	{
		lock_var( comm_init_count );
		lock_array( irq_props );
		lock_array( comm_props );

#ifndef FB_MANAGED_IRQ	
		lock_proc( comm_handler_irq_3 );
		lock_proc( comm_handler_irq_4 );
		lock_proc( comm_handler_irq_5 );
		lock_proc( comm_handler_irq_6 );
		lock_proc( comm_handler_irq_7 );
		lock_proc( comm_handler_irq_8 );
		lock_proc( comm_handler_irq_9 );
		lock_proc( comm_handler_irq_10 );
		lock_proc( comm_handler_irq_11 );
		lock_proc( comm_handler_irq_12 );
		lock_proc( comm_handler_irq_13 );
		lock_proc( comm_handler_irq_14 );
		lock_proc( comm_handler_irq_15 );
#endif

		lock_proc( comm_isr );

		lock_proc( BUFFER_getc );
		lock_proc( BUFFER_putc );

		comm_init_count++;
	}
}

static void comm_init_release( void )
{
	/* no more com ports in use? */
	if( comm_init_count == 1 )
	{
		unlock_proc( BUFFER_getc );
		unlock_proc( BUFFER_putc );

		unlock_proc( comm_isr );

#ifndef FB_MANAGED_IRQ	
		unlock_proc( comm_handler_irq_3 );
		unlock_proc( comm_handler_irq_4 );
		unlock_proc( comm_handler_irq_5 );
		unlock_proc( comm_handler_irq_6 );
		unlock_proc( comm_handler_irq_7 );
		unlock_proc( comm_handler_irq_8 );
		unlock_proc( comm_handler_irq_9 );
		unlock_proc( comm_handler_irq_10 );
		unlock_proc( comm_handler_irq_11 );
		unlock_proc( comm_handler_irq_12 );
		unlock_proc( comm_handler_irq_13 );
		unlock_proc( comm_handler_irq_14 );
		unlock_proc( comm_handler_irq_15 );
#endif

		unlock_array( comm_props );
		unlock_array( irq_props );
		unlock_var( comm_init_count );
	}

	if( comm_init_count != 0 )
		comm_init_count--;
}

static int comm_init_irq( irq_props_t *ip )
{
	/* setup real mode handler */
	_go32_dpmi_get_real_mode_interrupt_vector (ip->intnum, &ip->old_rmhandler);

	ip->new_rmhandler.pm_selector = _go32_my_cs ();
	ip->new_rmhandler.pm_offset = (unsigned long ) ip->irq_handler;

	if( _go32_dpmi_allocate_real_mode_callback_iret (&ip->new_rmhandler, &ip->regs) )
	{
		/* failed */
		return FALSE;
	}

	if( _go32_dpmi_set_real_mode_interrupt_vector (ip->intnum, &ip->new_rmhandler) )
	{
		/* failed */
		_go32_dpmi_free_real_mode_callback (&ip->new_rmhandler);
		return FALSE;
	}

	/* setup protected mode handler */
	_go32_dpmi_get_protected_mode_interrupt_vector (ip->intnum, &ip->old_pmhandler);

	ip->new_pmhandler.pm_selector = _go32_my_cs ();
	ip->new_pmhandler.pm_offset = (unsigned long) ip->irq_handler;
	_go32_dpmi_allocate_iret_wrapper( &ip->new_pmhandler );

	if( _go32_dpmi_set_protected_mode_interrupt_vector (ip->intnum, &ip->new_pmhandler) )
	{
		/* failed */
		_go32_dpmi_set_real_mode_interrupt_vector (ip->intnum, &ip->old_rmhandler);
		_go32_dpmi_free_real_mode_callback (&ip->new_rmhandler);
		_go32_dpmi_free_iret_wrapper (&ip->new_pmhandler);
		return FALSE;
	}

	/* success - installed */
	return TRUE;
}

static void comm_exit_irq( irq_props_t *ip )
{
	_go32_dpmi_set_real_mode_interrupt_vector (ip->intnum, &ip->old_rmhandler);
	_go32_dpmi_free_real_mode_callback (&ip->new_rmhandler);

	_go32_dpmi_set_protected_mode_interrupt_vector (ip->intnum, &ip->old_pmhandler);
	_go32_dpmi_free_iret_wrapper (&ip->new_pmhandler);
 }

static int comm_init( int com_num, unsigned int baseaddr, int irq )
{
	comm_props_t *cp;
	irq_props_t *ip;
	int tmp, i;

	if( com_num < 1 || com_num > MAX_COMM )
		return FALSE;

	cp = COMM_PROPS(com_num);

	comm_init_addref();

	if( baseaddr )
		cp->baseaddr = baseaddr;

	if( irq )
		cp->irq = irq;
	else
		cp->irq = cp->def_irq;

	/* irq is valid? */
	if( (cp->irq < FIRST_IRQ) || (cp->irq > LAST_IRQ) )
	{
		comm_init_release();
		return FALSE;
	}

	outportb( cp->baseaddr + UART_FCR, 0 );

	/* TODO: FIFO setup on UARTs that support it */

	/* flush ints pending */
	for( i = 0; i < 17; i++ )
	{
		tmp = inportb( cp->baseaddr + UART_IIR );
		if( (tmp & 0x38) == 0 )
			break;
		tmp = inportb( cp->baseaddr + UART_RBR );
	}

	/* disable interrupts on the UART */
	outportb( cp->baseaddr + UART_IER, 0 );

	/* clear status ints */
	tmp = inportb( cp->baseaddr + UART_LSR );
	tmp = inportb( cp->baseaddr + UART_MSR );

	/* enable interrupt gate */
	outportb( cp->baseaddr + UART_MCR, MCR_OUT2 );


	/* setup the irq for comm handling */
	ip = IRQ_PROPS(cp->irq);

	if( ip->usecount == 0 )
	{

#ifndef FB_MANAGED_IRQ
		if( !comm_init_irq( ip ) )
#else
		if( !fb_isr_set( cp->irq, comm_isr, 0, 1024 ))
#endif
		{
			comm_init_release();
			return FALSE;
		}

		/* set the interrupt controller mask */
		DISABLE();

		ip->usecount++;

		if( irq >= 8 )
		{
			/* enable irq on slave */
			
			ip->old_pic2_mask = inportb( ICU2_MASK );
			outportb( ICU2_MASK, ip->old_pic2_mask & ~(1 << (cp->irq - 8)) );

/* assume that the host OS already set this up */
#if 1
			/* TODO: chain pic2 to pic1 irq 2 */

			/* enable irq 2 on master */
			ip->old_pic1_mask = inportb( ICU1_MASK );
			outportb( ICU1_MASK, ip->old_pic1_mask & ~(1 << 2) );
#endif
		}
		else
		{
			/* enable irq on master */
			ip->old_pic1_mask = inportb( ICU1_MASK );
			outportb( ICU1_MASK, ip->old_pic1_mask & ~(1 << cp->irq) );
		}

		ENABLE();
	}

	DISABLE();

	/* chain comm ports for IRQ sharing */
	if( ip->first )
		comm_props[ip->first - 1].next = ip->first;
	ip->first = com_num;

	/* enable the UART's interrupts */
	tmp = inportb( cp->baseaddr + UART_IER );
	tmp |= IER_SINP | IER_EBRK | IER_TBE | IER_RXRD;
	outportb( cp->baseaddr + UART_IER, tmp );

	/* TODO: MCR_RTS should be set only after waiting for DSR if the OP/CS protocol option is set */
	tmp = inportb( cp->baseaddr + UART_MCR );
	tmp |= MCR_OUT2 | MCR_RTS | MCR_DTR;
	if( cp->flags & FLAG_SUPPRESS_RTS )
		tmp ^= MCR_RTS;
	outportb( cp->baseaddr + UART_MCR, tmp );


	ENABLE();

	return TRUE;
}

static void comm_exit( int com_num )
{
	comm_props_t *cp;
	irq_props_t *ip;
	int tmp, i;

	DBG_ASSERT( com_num >= 1 && com_num < MAX_COMM );

	cp = COMM_PROPS(com_num);

	/* disable interrupt gate on the UART */
	tmp = inportb( cp->baseaddr + UART_MCR );
	if( cp->flags & FLAG_KEEP_DTR )
		tmp &= ~( MCR_OUT2 | MCR_OUT1 | MCR_RTS );
	else
		tmp &= ~( MCR_OUT2 | MCR_OUT1 | MCR_RTS | MCR_DTR );
	
	outportb( cp->baseaddr + UART_MCR, tmp );

	/* disable interrupts on the UART */
	tmp = inportb( cp->baseaddr + UART_IER );
	tmp &= ~( IER_SINP | IER_EBRK | IER_TBE | IER_RXRD );
	outportb( cp->baseaddr + UART_IER, tmp );

	ip = IRQ_PROPS(cp->irq);

	/* un-chain comm ports for IRQ sharing */
	DISABLE();
	if( ip->first == com_num )
	{
		ip->first = cp->next;
	}
	else
	{
		for( i = 0; i < MAX_COMM; i ++ )
		{
			if( comm_props[i].next == com_num )
			{
				comm_props[i].next = cp->next;
				break;
			}
		}
	}
	cp->next = 0;
	ENABLE();

	/* restore interrupt controller mask */
	if( ip->usecount == 1 )
	{
		DISABLE();

		outportb( ICU1_MASK, inportb( ICU1_MASK ) | (ip->old_pic1_mask & (1 << cp->irq)) );

		if( cp->irq >= 8 )
		{
			/* disable irq on slave */
			outportb( ICU2_MASK, inportb( ICU2_MASK ) | (ip->old_pic2_mask & (1 << (cp->irq - 8))) );

/* assume that the host OS already set this up */
#if 1
			/* disable irq 2 on master */
			outportb( ICU1_MASK, inportb( ICU1_MASK ) | (ip->old_pic1_mask & (1 << 2)) );

			/* TODO: also unchain slave from master */
#endif
		}
		else
		{
			/* disable irq on master */
			outportb( ICU1_MASK, inportb( ICU1_MASK ) | (ip->old_pic1_mask & (1 << cp->irq)) );
		}

		ENABLE();

#ifndef FB_MANAGED_IRQ	
		comm_exit_irq( ip );
#else
		fb_isr_reset( cp->irq );
#endif
	}

	if( ip->usecount != 0 )
		ip->usecount--;

	comm_init_release();
}

int comm_open( int com_num,
	int baud, int parity, int data, int stop, 
	int txbufsize, int rxbufsize, int flags, int irq )
{
	comm_props_t *cp;
	int ret = FALSE;

	if( com_num < 1 || com_num > MAX_COMM )
		return FALSE;

	cp = COMM_PROPS(com_num);

	if( cp->inuse )
		return ret;

	if( (cp->initflags & COMM_CHECKED_CHIPTYPE) == 0 )
	{
		cp->chiptype = UART_detect_chiptype( cp->baseaddr );
		cp->initflags |= COMM_CHECKED_CHIPTYPE;
	}

	/* TODO: Autodetect IRQ in use by baseaddr */

	if( cp->chiptype == 0 )
		return FALSE;

	cp->txbuf.data = NULL;
	cp->txbuf.size = cp->txbuf.head = cp->txbuf.tail = 0;
	cp->rxbuf.data = NULL;
	cp->rxbuf.size = cp->rxbuf.head = cp->rxbuf.tail = 0;
	cp->txclear = TRUE;
	cp->flags = flags;

	ret = FALSE;

	if( BUFFER_alloc( &cp->txbuf, txbufsize ))
	if( BUFFER_alloc( &cp->rxbuf, rxbufsize ))
	if( UART_set_baud( cp->baseaddr, baud ))
	if( UART_set_data_format( cp->baseaddr, parity, data, stop ))
	if( comm_init( com_num, 0, irq ))
		ret = TRUE;

	/* TODO: wait for DSR if OP/DS option is set */

	/* TODO: Set RTS if RS option not set */

	/* TODO: wait for DCD if OP/CD option is set */

	/* TODO: Clean-up on TIMEOUT */

	if( ret )
	{
		cp->inuse = TRUE;
	}
	else
	{
		BUFFER_free( &cp->rxbuf);
		BUFFER_free( &cp->txbuf);
	}

	/* TRUE == success */
	return cp->inuse;
}

int comm_close( int com_num )
{
	comm_props_t *cp;

	if( com_num < 1 || com_num > MAX_COMM )
		return FALSE;

	cp = COMM_PROPS(com_num);

	if( cp->inuse == FALSE )
		return FALSE;

	comm_exit( com_num );

	cp->inuse = FALSE;

	BUFFER_free( &cp->rxbuf);
	BUFFER_free( &cp->txbuf);

	return TRUE;
}

int comm_putc( int com_num, int ch )
{
	comm_props_t *cp;
	cp = COMM_PROPS(com_num);

	DISABLE();
	if( cp->txclear )
	{
		cp->txclear = FALSE;
		outportb( cp->baseaddr + UART_THR, ch );
	}
	else
	{
		ch = BUFFER_putc( &cp->txbuf, ch );
	}
	ENABLE();
	return ch;
}

int comm_getc( int com_num )
{
	int ch;
	comm_props_t *cp;
	cp = COMM_PROPS(com_num);
	DISABLE();
	ch = BUFFER_getc( &cp->rxbuf );
	ENABLE();
	return ch;
}

int comm_bytes_remaining( int com_num )
{
	int bytes;
	comm_props_t *cp;
	cp = COMM_PROPS(com_num);
	DISABLE();
	bytes = cp->rxbuf.length;
	ENABLE();
	return bytes;
}

int fb_SerialOpen
	(
		FB_FILE *handle,
		int iPort,
		FB_SERIAL_OPTIONS *options,
		const char *pszDevice,
		void **ppvHandle
	)
{
	int ret, flags = 0;

	if( options->TransmitBuffer == 0 )
		options->TransmitBuffer = DEFAULT_BUFFERSIZE;
	else if( options->TransmitBuffer > MAX_BUFFERSIZE )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	if( options->ReceiveBuffer == 0 )
		options->ReceiveBuffer = DEFAULT_BUFFERSIZE;
	else if( options->ReceiveBuffer > MAX_BUFFERSIZE )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	if( options->KeepDTREnabled )
		flags |= FLAG_KEEP_DTR;

	if( options->SuppressRTS )
		flags |= FLAG_SUPPRESS_RTS;

	ret = comm_open( 
		iPort, 
		options->uiSpeed, 
		options->Parity, 
		options->uiDataBits, 
		options->StopBits, 
		options->TransmitBuffer,
		options->ReceiveBuffer,
		flags, 
		options->IRQNumber
		);

	if( ret )
	{
		DOS_SERIAL_INFO *pInfo = (DOS_SERIAL_INFO *) calloc( 1, sizeof(DOS_SERIAL_INFO) );
		DBG_ASSERT( ppvHandle!=NULL );
		*ppvHandle = pInfo;
		pInfo->com_num = iPort;
		pInfo->pOptions = options;
		return fb_ErrorSetNum( FB_RTERROR_OK ); 
	}

	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	/*
		[x]  unsigned            uiSpeed
		[x]  unsigned            uiDataBits
		[x]  FB_SERIAL_PARITY    Parity
		[x]  FB_SERIAL_STOP_BITS StopBits
		[ ]  unsigned            DurationCTS     -- CS[msec] 
		[ ]  unsigned            DurationDSR     -- DS[msec] 
		[ ]  unsigned            DurationCD      -- CD[msec] 
		[ ]  unsigned            OpenTimeout     -- OP[msec] 
		[ ]  int                 SuppressRTS     -- RS 
		[ ]  int                 AddLF           -- LF, or ASC, or BIN 
		[ ]  int                 CheckParity     -- PE 
		[x]  int                 KeepDTREnabled  -- DT 
		[ ]  int                 DiscardOnError  -- FE 
		[ ]  int                 IgnoreAllErrors -- ME 
		[x]  unsigned            IRQNumber       -- IR8..IR15
		[x]  unsigned            IRQNumber       -- IR2..IR7 
		[x]  unsigned            TransmitBuffer  -- TBn - a value 0 means: default value 
		[x]  unsigned            ReceiveBuffer   -- RBn - a value 0 means: default value 
	*/
}

int fb_SerialGetRemaining( FB_FILE *handle, void *pvHandle, fb_off_t *pLength )
{
	int bytes;
	DOS_SERIAL_INFO *pInfo = (DOS_SERIAL_INFO *) pvHandle;

	bytes = comm_bytes_remaining( pInfo->com_num );
	if( bytes < 0 )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	if( pLength )
		*pLength = bytes;

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

int fb_SerialWrite
	(
		FB_FILE *handle,
		void *pvHandle,
		const void *data,
		size_t length
	)
{
	DOS_SERIAL_INFO *pInfo = (DOS_SERIAL_INFO *) pvHandle;
	unsigned char * p = (unsigned char *)data;
	int ch;
	size_t i;

	/* TODO: Support for ASC/LF options */

	for( i=0; i<length; i++ )
	{
		ch = comm_putc( pInfo->com_num, p[i]);
		if( ch < 0 )
			return fb_ErrorSetNum( FB_RTERROR_FILEIO );
	}
	return fb_ErrorSetNum( FB_RTERROR_OK );
}

int fb_SerialRead
	(
		FB_FILE *handle,
		void *pvHandle,
		void *data,
		size_t *pLength
	)
{
	DOS_SERIAL_INFO *pInfo = (DOS_SERIAL_INFO *) pvHandle;
	size_t n = *pLength, i, count = 0;
	int ch;
	unsigned char * p = (unsigned char *)data;
	int res = FB_RTERROR_OK;

	for( i = 0; i < n; i++ )
	{
		ch = comm_getc( pInfo->com_num );
		if( ch < 0 )
		{
			res = FB_RTERROR_FILEIO;
			break;
		}
		p[i] = ch;
		count++;
	}

	*pLength = count;
	
	return fb_ErrorSetNum( res );
}

int fb_SerialClose( FB_FILE *handle, void *pvHandle )
{
	DOS_SERIAL_INFO *pInfo = (DOS_SERIAL_INFO *) pvHandle;
	comm_close( pInfo->com_num );
	free(pInfo);
	return fb_ErrorSetNum( FB_RTERROR_OK );
}
