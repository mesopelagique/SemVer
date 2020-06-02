//%attributes = {}

_:=spec ()

While (_.describe("Extract digit from string"))
	
	While (_.it(" must extract major"))
		_.expect(semver .major("1.2.3")).to(_.beEqualTo(1))
		_.expect(semver .major("1.2")).to(_.beEqualTo(1))
		_.expect(semver .major("1")).to(_.beEqualTo(1))
		_.expect(semver .major("")).to(_.beEqualTo(0))
	End while 
	
	While (_.it(" must extract major"))
		_.expect(semver .minor("1.2.3")).to(_.beEqualTo(2))
		_.expect(semver .minor("1.2")).to(_.beEqualTo(2))
		_.expect(semver .minor("1")).to(_.beEqualTo(0))
	End while 
	
	While (_.it(" must extract major"))
		_.expect(semver .patch("1.2.3")).to(_.beEqualTo(3))
		_.expect(semver .patch("1.2")).to(_.beEqualTo(0))
		_.expect(semver .patch("1")).to(_.beEqualTo(0))
	End while 
	
End while 