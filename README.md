# SemVer

[![Build](https://github.com/mesopelagique/SemVer/actions/workflows/build.yml/badge.svg)](https://github.com/mesopelagique/SemVer/actions/workflows/build.yml)

[SemVer](https://semver.org/) for 4D

## Usage

Create an instance of SemVer to use it later.

```4d
$semver:=cs.SemVer.Instance.new()
```

### Version object

#### Create version object

##### from string

```4d
$version:=$semver.version("1.2.3")
$version:=$semver.version("1.2") // 1.2.0
```

##### from digits

```4d
$version:=$semver.version(1;2;3)
```

##### from collection

```4d
$version:=$semver.version(New collection(1;2;3))
```

#### Attribute of version object

```4d
$version.major
$version.minor
$version.patch
```

### Extract digits

You can extract specific digit without creating `Version` object

```4d
$semver.major("1.2.3") // 1
$semver.minor("1.2.3") // 2
$semver.patch("1.2.3") // 3
```

> But if you need to extract all the digits, prefer use `Version` object

### Check if version string is valid

```4d
$semver.valid("1.2.3") // True
$semver.valid("not.a.version") // False
```

### Compare version

#### comparator

```4d
$semver.compare(semver.v0; $semver.v1)
```

- return 0 if equals
- return 1 if first argument is greater
- return -1 if first argument is lower

#### equality

```4d
semver.eq($semver.v1;"1.0.0")
```

#### greater

```4d
$semver.gt($semver.v1; "0.9.0")
$semver.gt("0.9.2"; "0.9.0")
$semver.gt("1.0.0"; "0.9.0")
```

#### greater or equals than

```4d
$semver.gte("1.5.6"; "0.9.0")
```

#### lower than

```4d
$semver.lt("0.5.6"; "0.9.0")
```

#### lower or equals than

```4d
$semver.lte("0.5.6"; "0.9.0")
```

### Range object

A range object contains two versions, the `min` and the `max` and allow to check if a version satisfy this bounds.

#### Create range object

##### with two min/max version from collection or object

```4d
$range:=$semver.range(New collection("1.0.1"; "1.2.1"))
$range:=$semver.range(New object("min"; "1.0.1"; "max"; "1.2.1"))
```

##### from exact version

```4d
$version:=$semver.range("1.2.3")
$version:=$semver.range($semver.version("1.2.3"))
```

> `min` and `max` will be equals

##### from string

###### to specify a range of stable versions

Use >, <, =, >= or <= for comparisons, or - to specify an inclusive range

examples:

- `>2.1`
- `1.0.0 - 1.2.0`

###### to include everything greater than a particular version in the same minor range

Use the tilde symbol, ~

examples:

- `~2.2.0`

###### to include everything greater than a particular version in the same major range

Use the caret (aka hat) symbol, ^

examples:

- `^2.2.1`
- `^0.1.0`

#### Check if version satisfy a range

```4d
$valid:=semver.range(">1").satisfiedBy("1.5.1")
$valid:=semver.range("1.0.0 - 1.2.0").satisfiedBy("1.5.1")
$valid:=semver.range("^1.0.0").satisfiedBy("1.5.1")
```

## TODO

- [x] increment functions
- [x] is valid function
- [x] compare two versions
- [x] check if version satisfy simple range
- [x] compare version with special syntax like "<=2.5.0 || 5.0.0 - 7.2.3"
- [x] support suffix(-prerelease and +build)
- [ ] support wildcards *,x,X
- [ ] support just two number with space and operators like ">= 1.2 < 3.0.0"
- [ ] clean version string (coerce)
