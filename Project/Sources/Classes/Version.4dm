

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
	This:C1470.valid:=True:C214
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
							This:C1470.valid:=False:C215
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
							This:C1470.valid:=False:C215
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
			This:C1470.valid:=False:C215
	End case 
	
Function compareTo
	C_VARIANT:C1683($1)
	C_LONGINT:C283($0)
	C_OBJECT:C1216($that)
	$that:=cs:C1710.Version.new($1)
	
	Case of 
		: (This:C1470.major>$that.major)
			$0:=1
		: (This:C1470.major<$that.major)
			$0:=-1
		Else   // major equal
			Case of 
				: (This:C1470.minor>$that.minor)
					$0:=1
				: (This:C1470.minor<$that.minor)
					$0:=-1
				Else   // minor equal
					Case of 
						: (This:C1470.patch>$that.patch)
							$0:=1
						: (This:C1470.patch<$that.patch)
							$0:=-1
						Else   // patch equal
							$0:=0
					End case 
			End case 
	End case 
	
Function gt
	C_VARIANT:C1683($1)
	C_BOOLEAN:C305($0)
	$0:=This:C1470.compareTo($1)>0
	
Function gte
	C_VARIANT:C1683($1)
	C_BOOLEAN:C305($0)
	$0:=This:C1470.compareTo($1)>=0
	
Function lt
	C_VARIANT:C1683($1)
	C_BOOLEAN:C305($0)
	$0:=This:C1470.compareTo($1)<0
	
Function lte
	C_VARIANT:C1683($1)
	C_BOOLEAN:C305($0)
	$0:=This:C1470.compareTo($1)<=0
	
Function eq
	C_VARIANT:C1683($1)
	C_BOOLEAN:C305($0)
	$0:=This:C1470.equalTo($1)
	
Function neq
	C_VARIANT:C1683($1)
	C_BOOLEAN:C305($0)
	$0:=Not:C34(This:C1470.eq($1))  // PERF: implement it instead of using Not
	
Function equalTo
	C_VARIANT:C1683($1)
	C_BOOLEAN:C305($0)
	C_OBJECT:C1216($that)
	$that:=cs:C1710.Version.new($1)
	
	If (This:C1470.major#$that.major)
		$0:=False:C215
	Else   // major equal
		If (This:C1470.minor#$that.minor)
			$0:=False:C215
		Else   // minor equal
			If (This:C1470.patch#$that.patch)
				$0:=False:C215
			Else   // patch equal
				$0:=True:C214
			End if 
		End if 
	End if 
	
Function inc
	C_TEXT:C284($1)
	This:C1470.increment($1)
	
Function increment
	C_TEXT:C284($1)
	Case of 
		: ($1="major")
			This:C1470.major:=This:C1470.major+1
		: ($1="minor")
			This:C1470.minor:=This:C1470.minor+1
		: ($1="patch")
			This:C1470.patch:=This:C1470.patch+1
		Else 
			ALERT:C41(False:C215;"Incorrect type of level "+String:C10($1))
	End case 