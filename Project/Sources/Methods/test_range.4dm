//%attributes = {"invisible":true}

var $semver : cs:C1710.Instance
$semver:=cs:C1710.Instance.new()

// $semver:=cs.Instance.new()

var $range; $rangeOther : cs:C1710.Range
$range:=$semver.range("1.0.0")
$rangeOther:=$semver.range($range)

ASSERT:C1129($semver.range("^1.0.0").satisfiedBy("1.0.0"))
ASSERT:C1129($semver.range("^1.0.0").satisfiedBy("1.0.1"))
ASSERT:C1129(Not:C34($semver.range("^1.0.0").satisfiedBy("2.0.1")))

ASSERT:C1129($semver.range("^1.0.0 || ^2.0.0 ").satisfiedBy("1.0.0"))
ASSERT:C1129($semver.range("^1.0.0 || ^2.0.0 ").satisfiedBy("1.0.1"))
ASSERT:C1129($semver.range("^1.0.0 || ^2.0.0 ").satisfiedBy("2.0.1"))
ASSERT:C1129(Not:C34($semver.range("^1.0.0 || ^2.0.0 ").satisfiedBy("3.0.1")))


ASSERT:C1129(Not:C34($semver.range(" >=2.5.0 || 5.0.0 - 7.2.3").satisfiedBy("1.0.0")))

ASSERT:C1129($semver.range(" >=2.5.0 || 5.0.0 - 7.2.3").satisfiedBy("2.6.0"))
ASSERT:C1129($semver.range(" <=2.5.0 || 5.0.0 - 7.2.3").satisfiedBy("5.6.0"))
ASSERT:C1129(Not:C34($semver.range(" <=2.5.0 || 5.0.0 - 7.2.3").satisfiedBy("3.6.0")))
ASSERT:C1129($semver.range(" 5.0.0 - 7.2.3").satisfiedBy("5.6.0"))
ASSERT:C1129(Not:C34($semver.range(" 5.0.0 - 7.2.3").satisfiedBy("4.6.0")))

ASSERT:C1129($semver.range("*").satisfiedBy("1.0.0"))

var $version : cs:C1710.Version
$version:=$semver.range(" >=2.5.0 || 5.0.0 - 7.2.3").firstSatisfying(New collection:C1472("1.0.0"; "4.3"; "5.3"; "8.3"))
ASSERT:C1129(cs:C1710.Version.new("4.3.0").eq($version))

$version:=$semver.range(" <=2.5.0 || 5.0.0 - 7.2.3").lastSatisfying(New collection:C1472("1.0.0"; "4.3"; "5.3"; "8.3"))
ASSERT:C1129(cs:C1710.Version.new("5.3.0").eq($version))

$version:=$semver.range(" >=2.5.0 || 5.0.0 - 7.2.3").lastSatisfying(New collection:C1472("1.0.0"; "4.3"; "5.3"; "8.3"))
ASSERT:C1129(cs:C1710.Version.new("8.3.0").eq($version))

$version:=$semver.range(" <=2.5.0 || 5.0.0 - 7.2.3").maxSatisfying(New collection:C1472("1.0.0"; "4.3"; "5.3"; "8.3"))
ASSERT:C1129(cs:C1710.Version.new("5.3.0").eq($version))

$version:=$semver.range(" <=2.5.0 || 5.0.0 - 7.2.3").maxSatisfying(New collection:C1472("5.3"; "1.0.0"; "4.3"; "8.3"))
ASSERT:C1129(cs:C1710.Version.new("5.3.0").eq($version))

$version:=$semver.range(" >=2.5.0 || 5.0.0 - 7.2.3").minSatisfying(New collection:C1472("5.3"; "1.0.0"; "4.3"; "8.3"))
ASSERT:C1129(cs:C1710.Version.new("4.3.0").eq($version))


var $versionText : Text
For each ($versionText; New collection:C1472("5.3"; "1.0.0"; "4.3"; "8.3"))
	ASSERT:C1129($semver.range($versionText).isOne(); "not concrete?"+$versionText)
End for each 

For each ($versionText; New collection:C1472(">=5.3"; "<=1.0.0"; "^4.3"; "8.3 - 10.5"; "*"))
	ASSERT:C1129(Not:C34($semver.range($versionText).isOne()); "concrete?"+$versionText)
End for each 

For each ($versionText; New collection:C1472("5.3"; "1.0.0"; "4.3"; "8.3"))
	ASSERT:C1129($semver.range($versionText).isValid(); "not valid?"+$versionText)
End for each 

For each ($versionText; New collection:C1472("5.3-pre"; "1.0.0-pre"; "4-pre"))
	ASSERT:C1129($semver.range($versionText).isValid(); "not valid?"+$versionText)
End for each 

For each ($versionText; New collection:C1472(">=5.3"; "<=1.0.0"; "^4.3"; "8.3 - 10.5"; "*"))
	ASSERT:C1129($semver.range($versionText).isValid(); "not valid?"+$versionText)
End for each 

For each ($versionText; New collection:C1472("a"; "hello"; "19R2"; "aze.aze.0"; "0"; "v0"))
	ASSERT:C1129(Not:C34($semver.range($versionText).isValid()); "valid?"+$versionText)
End for each 


For each ($versionText; New collection:C1472("5.3"; "1.0.0"; "4.3"; "8.3"))
	ASSERT:C1129(Not:C34($semver.range($versionText).isAny()); "any?"+$versionText)
End for each 
For each ($versionText; New collection:C1472("a"; "hello"; "19R2"; "aze.aze.0"; "0"))
	ASSERT:C1129(Not:C34($semver.range($versionText).isAny()); "any?"+$versionText)
End for each 
For each ($versionText; New collection:C1472("*"))
	ASSERT:C1129($semver.range($versionText).isAny(); "not any?"+$versionText)
End for each 
ASSERT:C1129($semver.range(New object:C1471("min"; $semver.v0; "max"; $semver.vMax)).isAny(); "not any v0 - vMax?")