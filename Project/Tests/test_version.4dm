//%attributes = {}

C_OBJECT:C1216(_;$version)

_:=spec ()
While (_.describe("Version created without args"))
	
	While (_.it(" must be 0 version"))
		$version:=semver .version()
		_.expect($version.major).to(_.beEqualTo(0))
		_.expect($version.minor).to(_.beEqualTo(0))
		_.expect($version.patch).to(_.beEqualTo(0))
	End while 
	
End while 

While (_.describe("Version created by longs"))
	
	While (_.it(" must be associated to correct place with 3 args"))
		$version:=semver .version(1;2;3)
		_.expect($version.major).to(_.beEqualTo(1))
		_.expect($version.minor).to(_.beEqualTo(2))
		_.expect($version.patch).to(_.beEqualTo(3))
	End while 
	
	While (_.it(" must be associated to correct place with 2 args"))
		$version:=semver .version(1;2)
		_.expect($version.major).to(_.beEqualTo(1))
		_.expect($version.minor).to(_.beEqualTo(2))
		_.expect($version.patch).to(_.beEqualTo(0))
	End while 
	
	While (_.it(" must be associated to correct place with 1 args"))
		$version:=semver .version(1)
		_.expect($version.major).to(_.beEqualTo(1))
		_.expect($version.minor).to(_.beEqualTo(0))
		_.expect($version.patch).to(_.beEqualTo(0))
	End while 
	
End while 

While (_.describe("Version created by collection"))
	
	While (_.it(" must be associated to correct place with 3 objects"))
		$version:=semver .version(New collection:C1472(1;2;3))
		_.expect($version.major).to(_.beEqualTo(1))
		_.expect($version.minor).to(_.beEqualTo(2))
		_.expect($version.patch).to(_.beEqualTo(3))
	End while 
	
	While (_.it(" must be associated to correct place with 2 objects"))
		$version:=semver .version(New collection:C1472(1;2))
		_.expect($version.major).to(_.beEqualTo(1))
		_.expect($version.minor).to(_.beEqualTo(2))
		_.expect($version.patch).to(_.beEqualTo(0))
	End while 
	
	While (_.it(" must be associated to correct place with 1 objects"))
		$version:=semver .version(New collection:C1472(1))
		_.expect($version.major).to(_.beEqualTo(1))
		_.expect($version.minor).to(_.beEqualTo(0))
		_.expect($version.patch).to(_.beEqualTo(0))
	End while 
	
	While (_.describe("but empty"))
		$version:=semver .version(New collection:C1472())
		
		While (_.it(" must be 0 version"))
			_.expect($version.major).to(_.beEqualTo(0))
			_.expect($version.minor).to(_.beEqualTo(0))
			_.expect($version.patch).to(_.beEqualTo(0))
		End while 
	End while 
	
	While (_.describe("with incorrect type"))
		$version:=semver .version(New collection:C1472("aa"))
		
		While (_.it(" must be 0 version"))
			_.expect($version.major).to(_.beEqualTo(0))
			_.expect($version.minor).to(_.beEqualTo(0))
			_.expect($version.patch).to(_.beEqualTo(0))
		End while 
	End while 
	
	  // could alert if not convertible, maybe check assert
	
End while 

While (_.describe("Version created by string"))
	
	While (_.it(" must be associated to correct place with 3 separated digits"))
		$version:=semver .version("1.2.3")
		_.expect($version.major).to(_.beEqualTo(1))
		_.expect($version.minor).to(_.beEqualTo(2))
		_.expect($version.patch).to(_.beEqualTo(3))
	End while 
	
	While (_.it(" must be associated to correct place with 2 separated digits"))
		$version:=semver .version("1.2")
		_.expect($version.major).to(_.beEqualTo(1))
		_.expect($version.minor).to(_.beEqualTo(2))
		_.expect($version.patch).to(_.beEqualTo(0))
	End while 
	
	While (_.it(" must be associated to correct place with 1 digits"))
		$version:=semver .version("1")
		_.expect($version.major).to(_.beEqualTo(1))
		_.expect($version.minor).to(_.beEqualTo(0))
		_.expect($version.patch).to(_.beEqualTo(0))
	End while 
	
End while 

