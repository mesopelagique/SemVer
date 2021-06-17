
Class constructor($variant : Variant)
	
	Case of 
		: (Value type:C1509($variant)=Is collection:K8:32)
			
			ASSERT:C1129(($variant.length=2); "range must count two version")
			This:C1470.min:=$variant[0]/*first*/
			This:C1470.max:=$variant[$variant.length-1]/*last*/
			
		: (Value type:C1509($variant)=Is object:K8:27)
			
			If (($variant.min#Null:C1517) & ($variant.max#Null:C1517))
				This:C1470.min:=cs:C1710.Version.new($variant.min)
				This:C1470.max:=cs:C1710.Version.new($variant.max)
			Else   // one version passed?
				This:C1470.min:=cs:C1710.Version.new($variant)
				This:C1470.max:=This:C1470.min
			End if 
			
		: (Value type:C1509($variant)=Is text:K8:3)
			
			
			
		Else 
			ASSERT:C1129(False:C215; "Unknown input for range version")
	End case 
	
	
Function satisfiedBy($version : Variant)->$result : Boolean
	$result:=This:C1470.min.lte($version)
	If ($result)
		$result:=This:C1470.max.gte($version)
	End if 
	