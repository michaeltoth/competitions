def letters(digit):
	if digit in (1, 2, 6):
		return 3
	elif digit in (4, 5, 9):
		return 4
	elif digit in (3, 7, 8):
		return 5
	elif digit == 0:
		return 0

def tens_letters(digit):
	if digit in (4,5,6):
		return 5
	elif digit in (2,3,8,9):
		return 6
	elif digit == 7:
		return 7
	elif digit == 0:
		return 0

# Function is passed the ones digit
def teens_letters(digit):
	if digit == 0:
		return 3
	elif digit in (1,2):
		return 6
	elif digit in (5,6):
		return 7
	elif digit in (3,4,8,9):
		return 8
	elif digit == 7:
		return 9

def to_int(numList):
	s = ''.join(map(str, numList))
	return int(s)

def num_letters(num):
	# Finds the number of letters in the written form of the number num 
	# Only works for numbers < 10000 per problem specification, but could be expanded

	digits = [int(char) for char in str(num)]
	not_zero = [i != 0 for i in digits]

	if len(digits) == 4:				#Thousands 
		return letters(digits[0]) + 8 + num_letters(to_int(digits[1:]))
	elif len(digits) == 3: 				# Hundreds
		return letters(digits[0]) + 7 + num_letters(to_int(digits[1:]))
	elif len(digits) == 2 and digits[0] == 1: 	# Teens
		return teens_letters(digits[1])
	elif len(digits) == 2: 				# Tens
		return tens_letters(digits[0]) + tens_letters(digits[1])
	elif len(digits) == 1: 				# Ones
		return letters(digits[0])
	else:
		new_num = input("Please Enter a number between 1 and 9999: ")
		num_letters(new_num)

	# Possible Options

	# Nine Thousand One Hundred and Twenty Four 	TTTT
	# Nine Thousand One Hundred and Twenty      	TTTF
	# Nine Thousand One Hundred and Four		TTFT
	# Nine Thousand One Hundred		    	TTFF 
	# Nine Thousand and Twenty Four			TFTT
	# Nine Thousand and Twenty			TFTF
	# Nine Thousand and Four			TFFT
	# Nine Thousand					TFFF
	# One Hundred and Twenty Four			FTTT
	# One Hundred and Twenty			FTTF
	# One Hundred and Four				FTFT
	# One Hundred					FTFF
	# Twenty Four					FFTT
	# Twenty					FFTF
	# Four						FFFT



def testing():
	assert num_letters(7) == 5
	assert num_letters(10) == 3
	assert num_letters(17) == 9
	assert num_letters(30) == 6
	assert num_letters(99) == 10
	assert num_letters(100) == 10
	assert num_letters(110) == 16
	assert num_letters(427) == 25
