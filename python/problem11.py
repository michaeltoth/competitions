from operator import mul

# Loads the grid from file and formats as a 2d list
def get_grid(input_file):
	with open('problem11_grid.txt', 'r') as f:
		 lines = f.read().splitlines()
	f.close()

	# This takes the text grid and converts it to a 2d integer array
	my_grid = []
	for i in range(0,len(lines)):
		my_grid.append(lines[i].split(" "))
		for n in range(0,len(my_grid[i])):
			my_grid[i][n] = int(my_grid[i][n])
	
	return my_grid

# Returns column i of a 2d grid
def column(matrix, i):
    return [row[i] for row in matrix]

# Returns the max of all 4 digit products in columns of the grid
def col_max(grid,num_cols):
    my_col_max = max([compute_max_product(column(grid,i)) for i in range(0,num_cols)])
    return my_col_max

# Returns the max of all 4 digit products in rows of the grid
def row_max(grid,num_rows):
    my_row_max = max([compute_max_product(grid[i]) for i in range(0,num_rows)])
    return my_row_max

# Returns the max of all 4 digit products in diagonals of the grid
def diagonal_max(grid):
    pass
	
# Computes and returns the maximum 4 digit product of the passed vector
def compute_max_product(vector):
    start = 0
    end = 4
    max = 0
    while end < len(vector):
        product = reduce(mul, vector[start:end], 1)
        if product > max:
            max = product
            print str(max) + " " + str(vector[start:end])
        start += 1
        end += 1
    return max

def main(input_file):
    my_grid = get_grid(input_file)
    n = len(my_grid)     # number of rows
    m = len(my_grid[0])  # number of columns
	
    #col_max(my_grid,m)
    #row_max(my_grid,n)
	