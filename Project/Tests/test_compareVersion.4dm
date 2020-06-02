//%attributes = {}
_:=spec ()

While (_.describe("comparison tests"))
	
	While (_.it(" must be return correct value to be able to sort"))
		_.expect(semver .compare(semver .v0;semver .v1)).to(_.beEqualTo(-1))
		_.expect(semver .compare(semver .v1;semver .v0)).to(_.beEqualTo(1))
		_.expect(semver .compare(semver .v0;semver .v0)).to(_.beEqualTo(0))
		_.expect(semver .compare(semver .v1;semver .v1)).to(_.beEqualTo(0))
	End while 
	
End while 

While (_.describe("equality tests"))
	
	While (_.it(" must be return correct value to be able to sort"))
		_.expect(semver .eq(semver .v0;semver .v1)).to(_.beFalse())
		_.expect(semver .eq(semver .v1;semver .v0)).to(_.beFalse())
		_.expect(semver .eq(semver .v0;semver .v0)).to(_.beTrue()))
		_.expect(semver .eq(semver .v1;semver .v1)).to(_.beTrue())
	End while 
	
End while 

While (_.describe("greater tests"))
	
	While (_.it(" must be return correct value to be able to sort"))
		_.expect(semver .gt(semver .v0;semver .v1)).to(_.beFalse())
		_.expect(semver .gt(semver .v1;semver .v0)).to(_.beTrue())
		_.expect(semver .gt(semver .v0;semver .v0)).to(_.beFalse())
		_.expect(semver .gt(semver .v1;semver .v1)).to(_.beFalse())
	End while 
	
End while 

While (_.describe("lower tests"))
	
	While (_.it(" must be return correct value to be able to sort"))
		_.expect(semver .lt(semver .v0;semver .v1)).to(_.beTrue())
		_.expect(semver .lt(semver .v1;semver .v0)).to(_.beFalse())
		_.expect(semver .lt(semver .v0;semver .v0)).to(_.beFalse())
		_.expect(semver .lt(semver .v1;semver .v1)).to(_.beFalse())
	End while 
	
End while 

