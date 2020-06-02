

Class constructor
	C_VARIANT:C1683($1;$2;$3)
	C_LONGINT:C283($counts)
	$counts:=Count parameters:C259
	Case of   // fix count parameters from formula
		: (Undefined:C82($1))
			$counts:=0
		: (Undefined:C82($2))
			$counts:=1
		: (Undefined:C82($3))
			$counts:=2
	End case 
	
	Case of 
		: ($counts=1)
			
			Case of 
				: (Value type:C1509($1)=Is text:K8:3)
					C_COLLECTION:C1488($col)
					$col:=Split string:C1554($1;".")
					Case of 
						: ($col.length>2)
							This:C1470.major:=Num:C11($col[0])
							This:C1470.minor:=Num:C11($col[1])
							This:C1470.patch:=Num:C11($col[2])
						: ($col.length>1)
							This:C1470.major:=Num:C11($col[0])
							This:C1470.minor:=Num:C11($col[1])
							This:C1470.patch:=0
						: ($col.length>0)
							This:C1470.major:=Num:C11($col[0])
							This:C1470.minor:=0
							This:C1470.patch:=0
						Else 
							This:C1470.major:=0
							This:C1470.minor:=0
							This:C1470.patch:=0
					End case 
					
				: (Value type:C1509($1)=Is collection:K8:32)
					Case of 
						: ($1.length>2)
							This:C1470.major:=Num:C11($1[0])
							This:C1470.minor:=Num:C11($1[1])
							This:C1470.patch:=Num:C11($1[2])
						: ($1.length>1)
							This:C1470.major:=Num:C11($1[0])
							This:C1470.minor:=Num:C11($1[1])
							This:C1470.patch:=0
						: ($1.length>0)
							This:C1470.major:=Num:C11($1[0])
							This:C1470.minor:=0
							This:C1470.patch:=0
						Else 
							This:C1470.major:=0
							This:C1470.minor:=0
							This:C1470.patch:=0
					End case 
				: (Value type:C1509($1)=Is object:K8:27)
					This:C1470.major:=$1.major
					This:C1470.minor:=$1.minor
					This:C1470.patch:=$1.patch
				Else   // expect num
					This:C1470.major:=Num:C11($1)
					This:C1470.minor:=0
					This:C1470.patch:=0
			End case 
		: ($counts=2)
			This:C1470.major:=Num:C11($1)
			This:C1470.minor:=Num:C11($2)
			This:C1470.patch:=0
		: ($counts>2)
			This:C1470.major:=Num:C11($1)
			This:C1470.minor:=Num:C11($2)
			This:C1470.patch:=Num:C11($3)
		Else 
			This:C1470.major:=0
			This:C1470.minor:=0
			This:C1470.patch:=0
	End case 