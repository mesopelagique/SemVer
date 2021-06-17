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

While (_.describe("Compare text range with major ^"))
	var $range : Object
	$range:=semver.range("^1.0.0")
	
	While (_.it(" must have lower bound equal to v1"))
		_.expect($range.min).to(_.beEqualTo(semver.v1))
	End while 
	
	While (_.it(" must be satisfied by versions"))
		_.expect($range.satisfiedBy(semver.v1)).to(_.beTrue())
		_.expect($range.satisfiedBy(semver.version(1; 0; 2))).to(_.beTrue())
		_.expect($range.satisfiedBy(semver.version(1; 1; 2))).to(_.beTrue())
		_.expect($range.satisfiedBy(semver.version("1.4.5"))).to(_.beTrue())
	End while 
	
	While (_.it(" must not be satisfied by versions"))
		_.expect($range.satisfiedBy(semver.v0)).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version(0; 1; 2))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version("0.5"))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version("2.4.5"))).to(_.beFalse())
	End while 
	
End while 

While (_.describe("Compare text range with major ^"))
	var $range : Object
	$range:=semver.range("^5.3.2")
	
	While (_.it(" must have lower bound equal to 5;3;2"))
		_.expect($range.min).to(_.beEqualTo(semver.version(5; 3; 2)))
	End while 
	
	While (_.it(" must be satisfied by versions"))
		_.expect($range.satisfiedBy(semver.version(5; 3; 2))).to(_.beTrue())
		_.expect($range.satisfiedBy(semver.version(5; 5; 7))).to(_.beTrue())
		_.expect($range.satisfiedBy(semver.version("5.9.10"))).to(_.beTrue())
	End while 
	
	While (_.it(" must not be satisfied by versions"))
		_.expect($range.satisfiedBy(semver.v0)).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version(0; 1; 2))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version("0.5"))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version("2.4.5"))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version("6.4.5"))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version(5; 3; 0))).to(_.beFalse())
	End while 
	
End while 


While (_.describe("Compare text range with major ~"))
	var $range : Object
	$range:=semver.range("~5.3.2")
	
	While (_.it(" must have lower bound equal to 5;3;2"))
		_.expect($range.min).to(_.beEqualTo(semver.version(5; 3; 2)))
	End while 
	
	While (_.it(" must be satisfied by versions"))
		_.expect($range.satisfiedBy(semver.version(5; 3; 2))).to(_.beTrue())
		_.expect($range.satisfiedBy(semver.version(5; 3; 8))).to(_.beTrue())
	End while 
	
	While (_.it(" must not be satisfied by versions"))
		_.expect($range.satisfiedBy(semver.v0)).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version("5.9.10"))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version(0; 1; 2))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version("0.5"))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version("2.4.5"))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version("6.4.5"))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version(5; 3; 0))).to(_.beFalse())
	End while 
	
End while 

While (_.describe("Compare text range with major ~"))
	var $range : Object
	$range:=semver.range("~1.0.0")
	
	While (_.it(" must have lower bound equal to v1"))
		_.expect($range.min).to(_.beEqualTo(semver.v1))
	End while 
	
	While (_.it(" must be satisfied by versions"))
		_.expect($range.satisfiedBy(semver.v1)).to(_.beTrue())
		_.expect($range.satisfiedBy(semver.version(1; 0; 2))).to(_.beTrue())
		_.expect($range.satisfiedBy(semver.version("1.0.50"))).to(_.beTrue())
	End while 
	
	While (_.it(" must not be satisfied by versions"))
		_.expect($range.satisfiedBy(semver.version("1.4.5"))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version(1; 1; 2))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.v0)).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version(0; 1; 2))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version("0.5"))).to(_.beFalse())
		_.expect($range.satisfiedBy(semver.version("2.4.5"))).to(_.beFalse())
	End while 
	
End while 

While (_.describe("Parse some range string "))
	
	While (_.it("~1.0 must have lower bound equal to v1"))
		_.expect(semver.range("~1.0").min).to(_.beEqualTo(semver.v1))
	End while 
	
	While (_.it("~1 must have lower bound equal to v1"))
		_.expect(semver.range("~1").min).to(_.beEqualTo(semver.v1))
	End while 
	
	While (_.it("0.0 - 1 must have lower bound equal to v0 and upper to v1"))
		_.expect(semver.range("0.0 - 1").min).to(_.beEqualTo(semver.v0))
		_.expect(semver.range("0.0 - 1").max).to(_.beEqualTo(semver.v1))
		_.expect(semver.range("0.0 - 1").satisfiedBy(semver.version("0.5"))).to(_.beTrue())
		_.expect(semver.range("0.0 - 1").satisfiedBy(semver.version("1.5"))).to(_.beFalse())
	End while 
	
	While (_.it(">1 must have lower bound equal to 1.0.1"))
		_.expect(semver.range(">1").min).to(_.beEqualTo(semver.version("1.0.1")))
		_.expect(semver.range(">1").satisfiedBy(semver.version("0.5"))).to(_.beFalse())
		_.expect(semver.range(">1").satisfiedBy(semver.version("1.5"))).to(_.beTrue())
	End while 
	
	While (_.it("<1 must have lower bound equal to v0"))
		_.expect(semver.range("<1").min).to(_.beEqualTo(semver.v0))
		_.expect(semver.range("<1").satisfiedBy(semver.version("0.5"))).to(_.beTrue())
		_.expect(semver.range("<1").satisfiedBy(semver.version("1.5"))).to(_.beFalse())
	End while 
	
End while 