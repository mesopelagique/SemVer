//%attributes = {}

ASSERT:C1129(cs:C1710.Version.new(New collection:C1472(1; 0; 0)).eq(cs:C1710.Instance.new().v1))
ASSERT:C1129(cs:C1710.Version.new(New collection:C1472(1; 0)).eq(cs:C1710.Instance.new().v1))
ASSERT:C1129(cs:C1710.Version.new(New collection:C1472(1)).eq(cs:C1710.Instance.new().v1))
ASSERT:C1129(cs:C1710.Version.new(New collection:C1472("1"; 0; 0)).eq(cs:C1710.Instance.new().v1))

ASSERT:C1129(cs:C1710.Version.new(1; 0; 0).eq(cs:C1710.Instance.new().v1))
ASSERT:C1129(cs:C1710.Version.new(1; 0).eq(cs:C1710.Instance.new().v1))
ASSERT:C1129(cs:C1710.Version.new(1).eq(cs:C1710.Instance.new().v1))

ASSERT:C1129(cs:C1710.Version.new("1.0.0").eq(cs:C1710.Instance.new().v1))
ASSERT:C1129(cs:C1710.Version.new("1.0").eq(cs:C1710.Instance.new().v1))
ASSERT:C1129(cs:C1710.Version.new("1").eq(cs:C1710.Instance.new().v1))
ASSERT:C1129(cs:C1710.Version.new("v1").eq(cs:C1710.Instance.new().v1))
ASSERT:C1129(cs:C1710.Version.new("v1.0").eq(cs:C1710.Instance.new().v1))

ASSERT:C1129(cs:C1710.Version.new("1.0.1").decrement("patch").eq(cs:C1710.Instance.new().v1))


ASSERT:C1129(cs:C1710.Version.new("1.0.0").increment("patch").gt(cs:C1710.Instance.new().v1))
ASSERT:C1129(cs:C1710.Version.new("1.0.1").gt(cs:C1710.Instance.new().v1))
ASSERT:C1129(cs:C1710.Instance.new().v1.lt(cs:C1710.Version.new("1.0.1")))

ASSERT:C1129(cs:C1710.Version.new("1.0.0").preRelease=Null:C1517)
ASSERT:C1129(cs:C1710.Version.new("1.0.0").build=Null:C1517)
ASSERT:C1129(String:C10(cs:C1710.Version.new("1.0.0-pre").preRelease)="pre")
ASSERT:C1129(String:C10(cs:C1710.Version.new("1.0.0+2800").build)="2800")
ASSERT:C1129(String:C10(cs:C1710.Version.new("1.0.0-pre+2800").preRelease)="pre")
ASSERT:C1129(String:C10(cs:C1710.Version.new("1.0.0-pre+2800").build)="2800")

