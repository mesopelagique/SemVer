property major : Integer
property minor : Integer
property patch : Integer

property build : Text
property preRelease : Text

Class constructor
	var $1; $2; $3 : Variant
	var $counts : Integer
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
					var $text : Text
					var $col : Collection
					var $sepPos : Integer
					
					If (Length:C16($1)=0)
						This:C1470.major:=0
						This:C1470.minor:=0
						This:C1470.patch:=0
						return 
					End if 
					
					$text:=$1
					//%W-533.1
					If ($text[[1]]="v")
						$text:=Delete string:C232($text; 1; 1)
					End if 
					//%W+533.1
					
					$sepPos:=Position:C15("+"; $text)
					If ($sepPos>0)
						This:C1470.build:=Substring:C12($text; $sepPos+1)
						$text:=Substring:C12($text; 1; $sepPos-1)
					End if 
					$sepPos:=Position:C15("-"; $text)
					If ($sepPos>0)
						This:C1470.preRelease:=Substring:C12($text; $sepPos+1)
						$text:=Substring:C12($text; 1; $sepPos-1)
					End if 
					
					$col:=Split string:C1554($text; ".")
					Case of 
						: ($col.length>2)
							This:C1470.major:=This:C1470._parseNumText($col[0])
							This:C1470.minor:=This:C1470._parseNumText($col[1])
							This:C1470.patch:=This:C1470._parseNumText($col[2])
						: ($col.length>1)
							This:C1470.major:=This:C1470._parseNumText($col[0])
							This:C1470.minor:=This:C1470._parseNumText($col[1])
							This:C1470.patch:=0
						: ($col.length>0)
							This:C1470.major:=This:C1470._parseNumText($col[0])
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
							This:C1470.major:=This:C1470._parseNum($1[0])
							This:C1470.minor:=This:C1470._parseNum($1[1])
							This:C1470.patch:=This:C1470._parseNum($1[2])
						: ($1.length>1)
							This:C1470.major:=This:C1470._parseNum($1[0])
							This:C1470.minor:=This:C1470._parseNum($1[1])
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
					This:C1470.major:=This:C1470._parseNum($1)
					This:C1470.minor:=0
					This:C1470.patch:=0
			End case 
		: ($counts=2)
			This:C1470.major:=This:C1470._parseNum($1)
			This:C1470.minor:=This:C1470._parseNum($2)
			This:C1470.patch:=0
		: ($counts>2)
			This:C1470.major:=This:C1470._parseNum($1)
			This:C1470.minor:=This:C1470._parseNum($2)
			This:C1470.patch:=This:C1470._parseNum($3)
		Else 
			This:C1470.major:=0
			This:C1470.minor:=0
			This:C1470.patch:=0
	End case 
	
	This:C1470.isValid:=(This:C1470.major#0) || (This:C1470.minor#0) || (This:C1470.patch#0)
	
Function compareTo($version : Variant)->$result : Integer
	var $that : Object
	$that:=cs:C1710.Version.new($version)
	
	Case of 
		: (This:C1470.major>$that.major)
			$result:=1
		: (This:C1470.major<$that.major)
			$result:=-1
		Else   // major equal
			Case of 
				: (This:C1470.minor>$that.minor)
					$result:=1
				: (This:C1470.minor<$that.minor)
					$result:=-1
				Else   // minor equal
					Case of 
						: (This:C1470.patch>$that.patch)
							$result:=1
						: (This:C1470.patch<$that.patch)
							$result:=-1
						Else   // patch equal
							$result:=0
					End case 
			End case 
	End case 
	
Function gt($version : Variant)->$result : Boolean
	$result:=This:C1470.compareTo($version)>0
	
Function gte($version : Variant)->$result : Boolean
	$result:=This:C1470.compareTo($version)>=0
	
Function lt($version : Variant)->$result : Boolean
	$result:=This:C1470.compareTo($version)<0
	
Function lte($version : Variant)->$result : Boolean
	$result:=This:C1470.compareTo($version)<=0
	
Function eq($version : Variant)->$result : Boolean
	$result:=This:C1470.equalTo($version)
	
Function neq($version : Variant)->$result : Boolean
	$result:=Not:C34(This:C1470.eq($version))  // PERF: implement it instead of using Not
	
Function equalTo($version : Variant)->$result : Boolean
	var $that : Object
	$that:=cs:C1710.Version.new($version)
	
	If (This:C1470.major#$that.major)
		$result:=False:C215
	Else   // major equal
		If (This:C1470.minor#$that.minor)
			$result:=False:C215
		Else   // minor equal
			If (This:C1470.patch#$that.patch)
				$result:=False:C215
			Else   // patch equal
				$result:=True:C214
			End if 
		End if 
	End if 
	
Function inc($part : Text) : cs:C1710.Version
	return This:C1470.increment($part)
	
	// Increment current version
	// $part: "major", "minor" or "patch"
	// Return current object
Function increment($part : Text) : cs:C1710.Version
	Case of 
		: ($part="major")
			This:C1470.major:=This:C1470.major+1
		: ($part="minor")
			This:C1470.minor:=This:C1470.minor+1
		: ($part="patch")
			This:C1470.patch:=This:C1470.patch+1
		Else 
			ASSERT:C1129(False:C215; "Incorrect type of level "+String:C10($part))
	End case 
	return This:C1470
	
	// Decrement current version
	// $part: "major", "minor" or "patch"
	// Return current object
Function decrement($part : Text) : cs:C1710.Version
	Case of 
		: ($part="major")
			ASSERT:C1129(This:C1470.major>0; "Cannot decrement a 0 major version")
			This:C1470.major:=This:C1470.major-1
			
		: ($part="minor")
			If (This:C1470.minor=0)
				This:C1470.minor:=MAXLONG:K35:2
				This:C1470.decrement("major")
			Else 
				This:C1470.minor:=This:C1470.minor-1
			End if 
			
		: ($part="patch")
			If (This:C1470.patch=0)
				This:C1470.patch:=MAXLONG:K35:2
				This:C1470.decrement("minor")
			Else 
				This:C1470.patch:=This:C1470.patch-1
			End if 
		Else 
			ASSERT:C1129(False:C215; "Incorrect type of level "+String:C10($part))
	End case 
	return This:C1470
	
	// Return a new version with max patch number, ie. max for the minor
Function maxMinor()->$version : cs:C1710.Version
	$version:=cs:C1710.Version.new(This:C1470.major; This:C1470.minor; MAXLONG:K35:2)
	
	// Return a new version with max minor number, ie. max for the major
Function maxMajor()->$version : cs:C1710.Version
	$version:=cs:C1710.Version.new(This:C1470.major; MAXLONG:K35:2; MAXLONG:K35:2)
	
Function _parseNumText($text : Text) : Integer
	If (Match regex:C1019("\\d*"; $text))
		return Num:C11($text)
	End if 
	return 0
	
Function _parseNum($value : Variant) : Integer
	If (Value type:C1509($value)=Is text:K8:3)
		return This:C1470._parseNumText($value)
	End if 
	return Num:C11($value)
	
	