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

## TODO

- [ ] compare two versions
- [ ] compare version with special syntax like >=2.5.0 || 5.0.0 - 7.2.3) 
- [ ] clean version string (coerce, remove v prefix, beta suffix)
- [ ] increment functions
- [ ] is valid function
