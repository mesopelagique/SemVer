//%attributes = {}
exported:=New object:C1471(\
"version";Formula:C1597(cs:C1710.Version.new($1;$2;$3));\
"major";Formula:C1597(cs:C1710.Version.new($1).major);\
"minor";Formula:C1597(cs:C1710.Version.new($1).minor);\
"patch";Formula:C1597(cs:C1710.Version.new($1).patch);\
"valid";Formula:C1597(cs:C1710.Version.new($1).valid);\
"v0";cs:C1710.Version.new(0;0;0);\
"v1";cs:C1710.Version.new(1;0;0);\
"compare";Formula:C1597(cs:C1710.Version.new($1).compareTo($2));\
"gt";Formula:C1597(cs:C1710.Version.new($1).gt($2));\
"gte";Formula:C1597(cs:C1710.Version.new($1).gte($2));\
"lt";Formula:C1597(cs:C1710.Version.new($1).lt($2));\
"lte";Formula:C1597(cs:C1710.Version.new($1).lte($2));\
"eq";Formula:C1597(cs:C1710.Version.new($1).eq($2))\
)

