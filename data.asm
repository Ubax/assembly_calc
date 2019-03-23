	input			db	255 	;Maximum number of charactes entered by user
					db 	?	;Number of charactes entered
	inputstr		db	256 dup('$')
	newLine 		db 	10, 13, '$'
		
	;************* ERROR MESSAGES *************
	bad_input		db	"Bad input$"
	in_num			db	"in number: $"
	in_opera		db	"in operation: $"
	wrg_ord			db	"wrong numbers order in subtract operation$"
		
	m_welcome		db	"Wirte your operation: $"
	m_result		db 	"This is result: $"
		
	number1			db	20 dup('$')
	number2			db	20 dup('$')
	operation		db	20 dup('$')
		
	wh_min			db	'a'
	wh_max			db	'z'
		
	;************* OPERATIONS *************
	plus			db "plus$"
	minus			db "minus$"
	multiply		db "times$"
		
	neg_str			db "minus $"
		
	;************* DIGITS *************
	zero			db	"zero$"
	one				db	"one$"
	two				db	"two$"
	three			db	"three$"
	four			db	"four$"
	five			db	"five$"
	six				db	"six$"
	seven			db 	"seven$"
	eight			db	"eight$"
	nine			db	"nine$"
		
	;************* TEN TO NINETEEN *************
	ten				db	"ten$"
	eleven			db	"eleven$"
	twelve			db	"twelve$"
	thirteen		db	"thirteen$"
	fourteen		db	"fourteen$"
	fifteen			db	"fifteen$"
	sixteen			db	"sixteen$"
	seventeen		db 	"seventeen$"
	eighteen		db	"eighteen$"
	nineteen		db	"nineteen$"
		
	;************* TENS *************
	twenty			db 	"twenty $"
	thirty			db	"thirty $"
	fourty			db	"fourty $"
	fifty			db	"fifty $"
	sixty			db	"sixty $"
	seventy			db 	"seventy $"
	eighty			db	"eighty $"
	ninety			db	"ninety $"
		
	;************* NUMBERS ARRAY *************
	tens_array		dw	offset twenty, offset thirty, offset fourty, offset fifty, offset sixty, offset seventy, offset eighty, offset ninety
	digit_array		dw	offset zero, offset one, offset two, offset three, offset four, offset five, offset six, offset seven, offset eight, offset nine
	teen_array		dw	offset ten, offset eleven, offset twelve, offset thirteen, offset fourteen, offset fifteen, offset sixteen, offset seventeen, offset eighteen, offset nineteen