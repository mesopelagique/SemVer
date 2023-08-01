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

