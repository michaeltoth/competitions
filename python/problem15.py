from math import factorial

def count_paths(size):
	'''
	Lattice paths turns out to be a simple combinatorial problem.  
	To see this, we recognize that to traverse an n-by-n grid we must make exactly n moves right and n moves down
	Counting the ways to traverse the grid is equivalent to choosing n "down" moves from the 2*n total moves
	as this requires by default that the remaining moves will all be "right" moves. Therefore:
	'''

	# n choose r = factorial(n) / (factorial(r) * factorial(n-r))
	paths = factorial(size * 2) / (factorial(size) * factorial(size))
	print paths 
