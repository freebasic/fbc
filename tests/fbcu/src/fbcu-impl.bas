/'::

	fbcu-impl.bas : implementation of internal interface

::'/

# include once "fbcu-common.bi"
# include once "fbcu-impl.bi"

namespace fbcu

	dim shared fbcu_ctx as fbcu_Context
	

'::
':: initialization
'::

	declare sub init_auto_mode ()
	declare sub init_basic_mode ()
	declare sub init_console_mode ()

	private _
	sub init_fbcu ()

		fbcu_ctx.status_ = fbcu_initializing
		
		dim result as CU_ErrorCode = CU_initialize_registry()
		if (CUE_SUCCESS <> result) then

			fbcu_ctx.status_ = fbcu_error
			fbcu_ctx.errorCond_ = fbcu_err_regInitFailed
			return

		end if
		
		fbcu_ctx.regSuite_ = NULL
		
		# if defined (FBCU_CONFIG_AUTO)
			init_auto_mode()
		
		# elseif defined (FBCU_CONFIG_BASIC)
			init_basic_mode()
		
		# elseif defined (FBCU_CONFIG_CONSOLE)
			init_console_mode()
		
		# else
			':: no run mode selected, compiling only
		
		# endif

		if (fbcu_ctx.status_ = fbcu_error) then
			return
		end if

		':: set run-time error behavior
		CU_set_error_action(FBCU_CONFIG_REB())

		fbcu_ctx.status_ = fbcu_ready

	end sub
	
	':: check and init cunit
	public _
	sub check_fbcu_initialization ()

		static initialized as integer = 0
		
		if (0 = initialized) then
			init_fbcu()
			if (fbcu_ctx.status_ = fbcu_error) then
				':: TODO: debugging
				return
			end if
		end if
		
		initialized = -1

	end sub

	sub cleanup_fbcu () destructor
		CU_cleanup_registry()
	end sub


	':: FIXME: hack ...
	# define FBCU_STRINGIZE(x) #x


	':: one of these private functions is called to actually
	':: init the run mode, depending on a config #define.
	private _
	sub init_auto_mode ()
		CU_set_output_filename(FBCU_STRINGIZE(FBCU_CONFIG_OFILE))
	end sub

	private _
	sub init_basic_mode ()
		' set output type for basic runs
		CU_basic_set_mode(FBCU_CONFIG_BRM())
	end sub

	private _
	sub init_console_mode ()
	end sub


'::
':: test runs
'::
	
	declare sub run_automated_tests ()
	declare sub run_basic_tests()
	declare sub run_console_tests()

	public _
	sub run_tests()

		if not (fbcu_ready <> fbcu_ctx.status_) then
			':: TODO: error-handling
		end if
		
		fbcu_ctx.status_ = fbcu_testing

		# if defined (FBCU_CONFIG_AUTO)
			run_automated_tests()

		# elseif defined (FBCU_CONFIG_BASIC)
			run_basic_tests()

		# elseif defined (FBCU_CONFIG_CONSOLE)
			run_console_tests()

		# endif

		if (fbcu_ctx.status_ = fbcu_error) then
			':: TODO: error-handling
		end if
		
		fbcu_ctx.status_ = fbcu_ready

	end sub

	':: one of these private functions is called to actually
	':: run the tests, depending on a config #define.
	private _
	sub run_automated_tests ()
		CU_automated_run_tests()
		
		# if defined (FBCU_CONFIG_LFILE)
			CU_list_tests_to_file()
		# endif
	end sub

	private _
	sub run_basic_tests()
		CU_basic_run_tests()
'		CU_basic_show_failures(CU_get_failure_list())
	end sub

	private _
	sub run_console_tests()
		CU_console_run_tests()
	end sub

end namespace
