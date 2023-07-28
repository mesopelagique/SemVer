
#DECLARE($event : Integer)

Case of 
	: ($event=On before host database startup:K74:3)
		singetonize(cs:C1710.Instance.new())
End case 