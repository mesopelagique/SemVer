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

## TODO

- [ ] compare two versions
- [ ] compare version with special syntax like >=2.5.0 || 5.0.0 - 7.2.3) 
- [ ] clean version string (coerce, remove v prefix, beta suffix)
- [ ] increment functions
- [ ] is valid function
