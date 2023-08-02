property set : Collection

Class constructor($variant : Variant)
	
	Case of 
		: (Value type:C1509($variant)=Is collection:K8:32)
			
			If (($variant.length=2) && OB Instance of:C1731($variant.first(); cs:C1710.Version) && OB Instance of:C1731($variant.last(); cs:C1710.Version))
				This:C1470.min:=$variant.first()
				This:C1470.max:=$variant.last()
			Else 
				
				// XXX: could support also a collection of cs.Range
				ASSERT:C1129(False:C215; "range must count two version")
			End if 
			
		: (Value type:C1509($variant)=Is object:K8:27)
			
			If (($variant.min#Null:C1517) & ($variant.max#Null:C1517))
				This:C1470.min:=cs:C1710.Version.new($variant.min)
				This:C1470.max:=cs:C1710.Version.new($variant.max)
			Else   // one version passed?
				This:C1470.min:=cs:C1710.Version.new($variant)
				This:C1470.max:=This:C1470.min
			End if 
			
		: (Value type:C1509($variant)=Is text:K8:3)
			
			$variant:=This:C1470._str_trim($variant)  // CLEAN: could also clean double or more space
			
			ASSERT:C1129(Length:C16($variant)>0; "range could not be empty text")
			
			This:C1470.set:=Split string:C1554($variant; "||").flatMap(This:C1470._parseRangeFormula; This:C1470)
			// XXX maybe remote all invalid one before (or useless like <0.0.0)
			ASSERT:C1129(This:C1470.set.length>0; "range could not be empty text")
			
			If (This:C1470.set.length=1)  // re-address as unique range, no more composite
				This:C1470.min:=This:C1470.set[0].min
				This:C1470.max:=This:C1470.set[0].max
				This:C1470.set:=Null:C1517
			End if 
			
			// OPTI: if one of the set is * (ie. any) then just take it, remove all other
			
		: ($variant=Null:C1517)
			
			// just empty one, to fill it later
			
		Else 
			
			ASSERT:C1129(False:C215; "Unknown input for range version")
			
	End case 
	
Function firstSatisfying($versions : Collection) : cs:C1710.Version
	var $version : Variant
	For each ($version; $versions)
		If (This:C1470.satisfiedBy($version))
			If ((Value type:C1509($version)=Is object:K8:27) && OB Instance of:C1731($version; cs:C1710.Version))
				return $version
			End if 
			return cs:C1710.Version.new($version)
		End if 
	End for each 
	return Null:C1517
	
Function lastSatisfying($versions : Collection) : cs:C1710.Version
	return This:C1470.firstSatisfying($versions.reverse())
	
Function maxSatisfying($versions : Collection)->$result : cs:C1710.Version
	var $version : Variant
	For each ($version; $versions)
		If ((($result=Null:C1517) || ($result.lt($version)) && (This:C1470.satisfiedBy($version))))
			If ((Value type:C1509($version)=Is object:K8:27) && OB Instance of:C1731($version; cs:C1710.Version))
				$result:=$version
			Else 
				$result:=cs:C1710.Version.new($version)
			End if 
		End if 
	End for each 
	
Function minSatisfying($versions : Collection)->$result : cs:C1710.Version
	var $version : Variant
	For each ($version; $versions)
		If ((($result=Null:C1517) || ($result.gt($version)) && (This:C1470.satisfiedBy($version))))
			If ((Value type:C1509($version)=Is object:K8:27) && OB Instance of:C1731($version; cs:C1710.Version))
				$result:=$version
			Else 
				$result:=cs:C1710.Version.new($version)
			End if 
		End if 
	End for each 
	
Function satisfiedBy($version : Variant)->$result : Boolean
	If (This:C1470.set#Null:C1517)
		var $comp : cs:C1710.Range
		For each ($comp; This:C1470.set)
			
			If ($comp.satisfiedBy($version))
				return True:C214
			End if 
			
		End for each 
		return False:C215
	End if 
	
	$result:=This:C1470.min.lte($version)
	If ($result)
		$result:=This:C1470.max.gte($version)
	End if 
	
Function _parseRangeFormula($object : Object; $this : cs:C1710.Range)
	$object.result:=$this.parseRange($this._str_trim($object.value))
	
Function parseRange($text : Text)->$range : cs:C1710.Range
	
	$range:=cs:C1710.Range.new()
	//%W-533.1
	Case of 
		: (($text[[1]]="*") && (Length:C16($text)=1))  // all
			
			$range.min:=cs:C1710.Instance.new().v0  // CONST 
			$range.max:=cs:C1710.Instance.new().vMax  // CONST
			
		: ($text[[1]]="^")  // up to major
			
			$range.min:=cs:C1710.Version.new(Substring:C12($text; 2))
			$range.max:=$range.min.maxMajor()
			
		: ($text[[1]]="~")  // up to minor
			
			$range.min:=cs:C1710.Version.new(Substring:C12($text; 2))
			$range.max:=$range.min.maxMinor()
			
		: ($text[[1]]=">")  // up to minor
			
			If ($text[[2]]="=")  // up to minor
				$range.min:=cs:C1710.Version.new(Substring:C12($text; 3))
			Else 
				$range.min:=cs:C1710.Version.new(Substring:C12($text; 2))
				$range.min.increment("patch")
			End if 
			$range.max:=cs:C1710.Instance.new().vMax  // CONST
			
		: ($text[[1]]="<")  // up to minor
			
			If ($text[[2]]="=")
				$range.max:=cs:C1710.Version.new(Substring:C12($text; 3))
			Else 
				$range.max:=cs:C1710.Version.new(Substring:C12($text; 2))
				$range.max.decrement("patch")
			End if 
			$range.min:=cs:C1710.Instance.new().v0  // CONST 
			
		: ($text[[1]]="=")  // equal to
			
			$range.min:=cs:C1710.Version.new(Substring:C12($text; 2))
			$range.max:=$range.min
			
		: (Position:C15(" - "; $text)>0)  //CLEAN:  maybe "-"
			var $versions : Collection
			$versions:=Split string:C1554($text; " - ")
			$range.min:=cs:C1710.Version.new($versions[0])
			$range.max:=cs:C1710.Version.new($versions[1])
			
		Else   // simple one, ie. exact version
			$range.min:=cs:C1710.Version.new($text)
			$range.max:=$range.min
	End case 
	//%W+533.1
	
	// True if max = min
Function isOne() : Boolean
	If ((This:C1470.min#Null:C1517) && (This:C1470.min.eq(This:C1470.max)))
		return True:C214
	End if 
	If ((This:C1470.set=Null:C1517) || (This:C1470.set.length#1))
		return False:C215  // CLEAN: could have concrete in this case if all sub are equals; but...
	End if 
	return This:C1470.set[0].isOne()
	
	// True if not v0
Function isValid() : Boolean
	If (This:C1470.min#Null:C1517)
		If (This:C1470.min.eq(cs:C1710.Instance.new().v0) && This:C1470.min.eq(This:C1470.max))
			return False:C215
		End if 
		return True:C214
	End if 
	
	If ((This:C1470.set=Null:C1517) || (This:C1470.set.length=0))
		return False:C215
	End if 
	var $sub : cs:C1710.Range
	For each ($sub; This:C1470.set)
		If ($sub.isValid())
			return True:C214
		End if 
	End for each 
	
	return False:C215
	
	// True if match any version (like *)
Function isAny() : Boolean
	If ((This:C1470.min#Null:C1517) && (This:C1470.max#Null:C1517))
		If (This:C1470.min.eq(cs:C1710.Instance.new().v0) && This:C1470.max.eq(cs:C1710.Instance.new().vMax))
			return True:C214
		End if 
		return False:C215
	End if 
	
	If ((This:C1470.set=Null:C1517) || (This:C1470.set.length=0))
		return False:C215  // invalid?
	End if 
	
	var $sub : cs:C1710.Range
	For each ($sub; This:C1470.set)
		If ($sub.isAny())
			return True:C214
		End if 
	End for each 
	
Function union($added : cs:C1710.Range)->$newRange : cs:C1710.Range
	$newRange:=cs:C1710.Range.new()
	$newRange.set:=New collection:C1472(This:C1470; $added)
	
	// MARK:- string utils
	
Function _str_trim($txt : Text)->$res : Text
	var $tPattern; $t : Text
	$tPattern:="(?m-si)^(\\s*)"
	
	$res:=$txt
	
	// trimLeading
	$t:=Split string:C1554($res; "").reverse().join("")
	var $position; $length : Integer
	If (Match regex:C1019($tPattern; $t; 1; $position; $length; *))
		
		$res:=Split string:C1554(Delete string:C232($t; $position; $length); "").reverse().join("")
		
	End if 
	
	// trimTrailing
	$t:=$res
	
	If (Match regex:C1019($tPattern; $t; 1; $position; $length; *))
		
		$res:=Delete string:C232($t; $position; $length)
		
	End if 
	
	