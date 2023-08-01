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