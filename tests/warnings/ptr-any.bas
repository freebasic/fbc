type UDT
	i as integer
end type

type FWDREF as FWDREF_

dim pb    as byte ptr
dim pub   as ubyte ptr
dim psh   as short ptr 
dim push  as ushort ptr
dim pl    as long ptr
dim pul   as ulong ptr
dim pll   as longint ptr
dim pull  as ulongint ptr
dim pi    as integer ptr
dim pui   as integer ptr
dim pf    as single ptr
dim pd    as double ptr
dim ps    as string ptr
dim pz    as zstring ptr
dim pw    as wstring ptr
dim pudt  as UDT ptr
dim psub  as sub()
dim pfwd  as FWDREF ptr

dim pany  as any ptr
dim ppany as any ptr ptr
dim ppi   as integer ptr ptr

#print "no warnings:"

pany = pb
pany = pub
pany = psh
pany = push
pany = pl
pany = pul
pany = pll
pany = pull
pany = pi
pany = pui
pany = pf
pany = pd
pany = ps
pany = pz
pany = pw
pany = pudt
pany = psub
pany = pfwd

pb   = pany
pub  = pany
psh  = pany
push = pany
pl   = pany
pul  = pany
pll  = pany
pull = pany
pi   = pany
pui  = pany
pf   = pany
pd   = pany
ps   = pany
pz   = pany
pw   = pany
pudt = pany
psub = pany
pfwd = pany

pany = pany
ppany = pany
pany = ppany
pany = ppi
ppi = pany
ppany = ppi
ppi = ppany

#macro warn( statement )
	#print "1 warning:"
	statement
#endmacro

warn( ppany = pb   )
warn( ppany = pub  )
warn( ppany = psh  )
warn( ppany = push )
warn( ppany = pl   )
warn( ppany = pul  )
warn( ppany = pll  )
warn( ppany = pull )
warn( ppany = pi   )
warn( ppany = pui  )
warn( ppany = pf   )
warn( ppany = pd   )
warn( ppany = ps   )
warn( ppany = pz   )
warn( ppany = pw   )
warn( ppany = pudt )
warn( ppany = psub )
warn( ppany = pfwd )

warn( pb   = ppany )
warn( pub  = ppany )
warn( psh  = ppany )
warn( push = ppany )
warn( pl   = ppany )
warn( pul  = ppany )
warn( pll  = ppany )
warn( pull = ppany )
warn( pi   = ppany )
warn( pui  = ppany )
warn( pf   = ppany )
warn( pd   = ppany )
warn( ps   = ppany )
warn( pz   = ppany )
warn( pw   = ppany )
warn( pudt = ppany )
warn( psub = ppany )
warn( pfwd = ppany )
