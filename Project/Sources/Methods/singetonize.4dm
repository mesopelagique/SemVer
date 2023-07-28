//%attributes = {}
#DECLARE($instance : Object)

var $class : 4D:C1709.Class
$class:=OB Class:C1730($instance)

If ($class.instance=Null:C1517)
	
	Use ($class)
		
		$class.instance:=OB Copy:C1225($instance; ck shared:K85:29; $class)
		
		Use ($class)
			$class._new:=This:C1470.new
			$class.new:=Formula:C1597(This:C1470.instance)
		End use 
		
	End use 
	
End if 