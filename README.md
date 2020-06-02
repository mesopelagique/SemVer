# SemVer

[SemVer](https://semver.org/) for 4D

## Usage

### Version object

#### Create version object

##### from string

```4d
$version:=semver .version("1.2.3")
$version:=semver .version("1.2") // 1.2.0
```

##### from digits

```4d
$version:=semver .version(1;2;3)
```

##### from collection

```4d
$version:=semver .version(New collection(1;2;3))
```

#### Atribute of version object

```4d
$version.major
$version.minor
$version.patch
```

### Extract digits

You can extract specific digit without creating `Version` object

```4d
semver .major("1.2.3") // 1
semver .minor("1.2.3") // 2
semver .patch("1.2.3") // 3
```

> But if you need to extract all the digits, prefer use `Version` object

### Compare version

#### comparator

```4d
semver .compare(semver .v0;semver .v1)
```
- return 0 if equals
- return 1 if first argument is greater
- return -1 if first argument is lower

#### equality

```4d
semver .eq(semver .v1;"1.0.0')
```

#### greater

```4d
semver .gt(semver .v1;"0.9.0')
```

#### greater or equals than
```4d
semver .gte(semver .v1;"0.9.0')
```

#### lower than

```4d
semver .lt(semver .v1;"0.9.0')
```

#### lower or equals than

```4d
semver .lte(semver .v1;"0.9.0')
```

## TODO

- [x] compare two versions
- [ ] compare version with special syntax like >=2.5.0 || 5.0.0 - 7.2.3) 
- [ ] clean version string (coerce, remove v prefix, beta suffix)
- [ ] increment functions
- [ ] is valid function
