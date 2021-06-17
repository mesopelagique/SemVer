//%attributes = {}

_:=spec()

While (_.describe("Compare collection range v0 v1"))
	var $range : Object
	$range:=semver.range(New collection:C1472(semver.v0; semver.v1))
	While (_.it(" must be satisfied by versions"))
		_.expect($range.satisfiedBy(semver.v0)).to(_.beTrue())
		_.expect($range.satisfiedBy(semver.v1)).to(_.beTrue())
		_.expect($range.satisfiedBy(semver.version(0; 1; 2))).to(_.beTrue())
		_.expect($range.satisfiedBy(semver.version("0.5"))).to(_.beTrue())
	End while 
	
	While (_.it(" must not be satisfied by versions"))
		_.expect($range.satisfiedBy(semver.version(1; 1; 2))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version("1.4.5"))).to(_.beFalse())
	End while 
	
End while 

While (_.describe("Compare version v1 as range "))
	var $range : Object
	$range:=semver.range(semver.v1)
	While (_.it(" must be satisfied by versions"))
		_.expect($range.satisfiedBy(semver.v1)).to(_.beTrue())
	End while 
	
	While (_.it(" must not be satisfied by versions"))
		_.expect($range.satisfiedBy(semver.v0)).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version(0; 1; 2))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version("0.5"))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version(1; 1; 2))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version("1.4.5"))).to(_.beFalse())
	End while 
	
End while 

While (_.describe("Compare object range min v0 max v1"))
	var $range : Object
	$range:=semver.range(New object:C1471("min"; semver.v0; "max"; semver.v1))
	While (_.it(" must be satisfied by versions"))
		_.expect($range.satisfiedBy(semver.v0)).to(_.beTrue())
		_.expect($range.satisfiedBy(semver.v1)).to(_.beTrue())
		_.expect($range.satisfiedBy(semver.version(0; 1; 2))).to(_.beTrue())
		_.expect($range.satisfiedBy(semver.version("0.5"))).to(_.beTrue())
	End while 
	
	While (_.it(" must not be satisfied by versions"))
		_.expect($range.satisfiedBy(semver.version(1; 1; 2))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version("1.4.5"))).to(_.beFalse())
	End while 
	
End while 
