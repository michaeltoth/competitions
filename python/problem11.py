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
def get_column(matrix, i):
    return [row[i] for row in matrix]

def col_max(grid,num_cols):
    my_col_max = max([compute_max_product(get_column(grid,i)) for i in range(0,num_cols)])
    return my_col_max

def row_max(grid,num_rows):
    my_row_max = max([compute_max_product(grid[i]) for i in range(0,num_rows)])
    return my_row_max

def diag_max(grid,num_rows,num_cols):
    # Loops through variables p and q where p is the number of the diagonal and q is the index along the diagonal.
	# Converts p and q into (x,y) space for indexing from the grid in the pos_diags and neg_diags variables.
	
	# Up and right
    pos_diags = [[grid[q][p-q]
        for q in range(min(p, num_rows-1), max(0, p-num_cols+1)-1, -1)]
        for p in range(num_rows+num_cols-1)]	
    # Down and left
    neg_diags = [[grid[num_rows-1-q][p-q]
        for q in range(min(p, num_rows-1), max(0, p-num_cols+1)-1, -1)]
        for p in range(num_rows+num_cols-1)]

    # Compute and return the max of both positive and negative diagonal traversals:
    pos_traversal_max = max([compute_max_product(pos_diags[i]) for i in range(0,num_rows+num_cols-1)])
    neg_traversal_max = max([compute_max_product(neg_diags[i]) for i in range(0,num_rows+num_cols-1)])
    return max(pos_traversal_max,neg_traversal_max)
	
# Computes and returns the maximum 4 digit product of the passed vector
def compute_max_product(vector):
    start = 0
    end = 4
    max = 0
    while end < len(vector) + 1:
        product = reduce(mul, vector[start:end], 1)
        if product > max:
            max = product
        start += 1
        end += 1
    return max

def main(input_file):
    my_grid = get_grid(input_file)
    n = len(my_grid)     # number of rows
    m = len(my_grid[0])  # number of columns
	
    print max(col_max(my_grid,m),row_max(my_grid,n),diag_max(my_grid,n,m))
	