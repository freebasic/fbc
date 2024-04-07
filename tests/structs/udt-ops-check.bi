
	'' types for TU/TV/TX used by:
	'' - udt-comp-ops-1.bas
	'' - udt-comp-ops-2.bas
	'' - udt-comp-ops-3.bas

	'' constructors/operators defined:
	'' TU_ctor_from_TU
	'' TU_ctor_from_TV
	'' TU_ctor_from_TX
	'' TU_let_from_TU
	'' TU_let_from_TV
	'' TU_let_from_TX
	'' TU_dtor
	'' TV_cast_to_TU
	'' TV_cast_to_TX
	'' op_inequal_from_TU_from_TU
	'' op_inequal_from_TU_from_TV

	dim shared as integer id_count
	dim shared as integer id_TU_constructor
	dim shared as integer id_TU_ctor_from_TU
	dim shared as integer id_TU_ctor_from_TV
	dim shared as integer id_TU_ctor_from_TX
	dim shared as integer id_TU_let_from_TU
	dim shared as integer id_TU_let_from_TV
	dim shared as integer id_TU_let_from_TX
	dim shared as integer id_TU_dtor
	dim shared as integer id_TV_cast_to_TU
	dim shared as integer id_TV_cast_to_TX
	dim shared as integer id_op_inequal_from_TU_from_TU
	dim shared as integer id_op_inequal_from_TU_from_TV

	sub reset_id_counts()
		id_count = 0
		id_TU_constructor = 0
		id_TU_ctor_from_TU = 0
		id_TU_ctor_from_TV = 0
		id_TU_ctor_from_TX = 0
		id_TU_let_from_TU = 0
		id_TU_let_from_TV = 0
		id_TU_let_from_TX = 0
		id_TU_dtor = 0
		id_TV_cast_to_TU = 0
		id_TV_cast_to_TX = 0
		id_op_inequal_from_TU_from_TU = 0
		id_op_inequal_from_TU_from_TV = 0
	end sub

	function get_id_count() as integer
		id_count += 1
		return id_count
	end function

	'' TX type defined:
	enum TX_type
		TX_as_integer
		TX_as_integer_ptr
		TX_as_string
		TX_as_UDT_with_integer
		TX_as_UDT_with_string
	end enum

	#macro gen_TX_decl _
		( _
			ns, _
			TX_id _
		)

		'' TX type defined:

		#if (TX_id = TX_as_integer)
			Type TX As integer
		#endif

		#if (TX_id = TX_as_integer_ptr)
			Type TX As integer Ptr
		#endif

		#if (TX_id = TX_as_string)
			Type TX As String
		#endif

		#if (TX_id = TX_as_UDT_with_integer)
			Type TX
				dim As integer I
			end Type
		#endif

		#if (TX_id = TX_as_UDT_with_string)
			Type TX
				dim As String s
			end Type
		#endif

	#endmacro

	'' for debugging
	#macro dprint ? ( text )
		'' print text
	#endmacro

	#macro gen_type_decl _
		( _
			ns, _
			TU_ctor_from_TU, _
			TU_ctor_from_TV, _
			TU_ctor_from_TX, _
			TU_let_from_TU, _
			TU_let_from_TV, _
			TU_let_from_TX, _
			TU_dtor, _
			TV_cast_to_TU, _
			TV_cast_to_TX, _
			op_inequal_from_TU_from_TU, _
			op_inequal_from_TU_from_TV _
		)

		type _TV As TV

		type TU
			dim As integer I
			declare constructor()
			#if TU_ctor_from_TU <> 0
				declare constructor(byref u As TU)
			#endif
			#if TU_ctor_from_TV <> 0
				declare constructor(byref v As _TV)
			#endif
			#if TU_ctor_from_TX <> 0
				declare constructor(byref s As TX)
			#endif
			#if TU_let_from_TU <> 0
				declare operator Let(byref u As TU)
			#endif
			#if TU_let_from_TV <> 0
				declare operator Let(byref v As _TV)
			#endif
			#if TU_let_from_TX <> 0
				declare operator Let(byref s As TX)
			#endif
			#if TU_dtor <> 0
				declare Destructor()
			#endif
		end type

		type TV
			dim As integer I
			#if TV_cast_to_TU <> 0
				declare operator Cast() byref As TU
			#endif
			#if TV_cast_to_TX <> 0
				declare operator Cast() byref As TX
			#endif
		end type

		type TW extends TU
		end type

		dim shared As TX x0
		dim shared As TU u0
		dim shared As TV v0
		dim shared As TW w0, w1

		constructor TU()
			if (@this <> @u0) and (@this <> @w0) and (@this <> @w1) Then
				dprint #ns; " ";
				dprint "constructor TU()"
				id_TU_constructor = get_id_count()
			end if
		end constructor

		#if TU_ctor_from_TU <> 0
			constructor TU(byref u As TU)
				dprint #ns; " ";
				dprint "constructor TU(byref As TU)"
				id_TU_ctor_from_TU = get_id_count()
			end constructor
		#endif

		#if TU_ctor_from_TV <> 0
			constructor TU(byref v As TV)
				dprint #ns; " ";
				dprint "constructor TU(byref As TV)"
				id_TU_ctor_from_TV = get_id_count()
			end constructor
		#endif

		#if TU_ctor_from_TX <> 0
			constructor TU(byref s As TX)
				dprint #ns; " ";
				dprint "constructor TU(byref As TX)"
				id_TU_ctor_from_TX = get_id_count()
			end constructor
		#endif

		#if TU_let_from_TU <> 0
			operator TU.Let(byref u As TU)
				dprint #ns; " ";
				dprint "operator TU.Let(byref As TU)"
				id_TU_let_from_TU = get_id_count()
			end operator
		#endif

		#if TU_let_from_TV <> 0
			operator TU.Let(byref v As TV)
				dprint #ns; " ";
				dprint "operator TU.Let(byref As TV)"
				id_TU_let_from_TV = get_id_count()
			end operator
		#endif

		#if TU_let_from_TX <> 0
			operator TU.Let(byref s As TX)
				dprint #ns; " ";
				dprint "operator TU.Let(byref As TX)"
				id_TU_let_from_TX = get_id_count()
			end operator
		#endif

		#if TU_dtor <> 0
			destructor TU()
				if (@this <> @u0) and (@this <> @w0) and (@this <> @w1) Then
					dprint #ns; " ";
					dprint "destructor TU()"
					id_TU_dtor = get_id_count()
				end if
			end destructor
		#endif

		#if TV_cast_to_TU <> 0
			operator TV.Cast() byref As TU
				dprint #ns; " ";
				dprint "operator TV.Cast() byref As TU"
				id_TV_cast_to_TU = get_id_count()
				return u0
			end operator
		#endif

		#if TV_cast_to_TX <> 0
			operator TV.Cast() byref As TX
				dprint #ns; " ";
				dprint "operator TV.Cast() byref As TX"
				id_TV_cast_to_TX = get_id_count()
				return x0
			end operator
		#endif

		#if op_inequal_from_TU_from_TU <> 0
			operator <>(byref ul As TU, byref ur As TU) As integer
				dprint #ns; " ";
				dprint "operator <>(byref As TU, byref As TU) As integer"
				id_op_inequal_from_TU_from_TU = get_id_count()
				return ul.i <> ur.i
			end operator
		#endif

		#if op_inequal_from_TU_from_TV <> 0
			operator <>(byref ul As TU, byref vr As TV) As integer
				dprint #ns; " ";
				dprint "operator <>(byref As TU, byref As TV) As integer"
				id_op_inequal_from_TU_from_TV = get_id_count()
				return ul.i <> vr.i
			end operator
		#endif

	#endmacro
