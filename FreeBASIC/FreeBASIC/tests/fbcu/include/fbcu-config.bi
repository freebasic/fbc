'// fbcu-config.bi : defines internal macros used for testing
'//
'// this is an internal header used by fbcu,
'// and should not be included directly

# ifndef FB_CU_CONFIG_BI
# define FB_CU_CONFIG_BI

':: FIXME: hack ...
# if defined (FBCU_CONFIG_BASIC)

	# if defined (FBCU_CONFIG_BRM_SILENT)
		# define FBCU_CONFIG_BRM() CU_BRM_SILENT

	# elseif defined (FBCU_CONFIG_BRM_VERBOSE)
		# define FBCU_CONFIG_BRM() CU_BRM_VERBOSE

	# else
		# define FBCU_CONFIG_BRM() CU_BRM_NORMAL

	# endif

# else

	# define FBCU_CONFIG_BRM() CU_BRM_NORMAL

# endif


':: cunit runtime error behavior

' # define FBCU_REB_IGNORE		runtime errors are ignored (default)
' # define FBCU_REB_FAIL		runtime errors stop test runs
' # define FBCU_REB_ABORT		runtime errors abort test

' # define FBCU_CONFIG_REB()	used internally

# if defined (FBCU_REB_FAIL)
	#	define FBCU_CONFIG_REB() CUEA_FAIL

# elseif defined (FBCU_REB_ABORT)
	#	define FBCU_CONFIG_REB() CUEA_ABORT

# else
	#	define FBCU_CONFIG_REB() CUEA_IGNORE

# endif

# endif	'## include guard
