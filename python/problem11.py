with open('grid.txt', 'r') as f:
     lines = f.read().splitlines()
f.close()

# This takes the text grid and converts it to a 2d integer array
for i in range(0,len(lines)):
    lines[i] = lines[i].split(" ")
    for n in range(0,len(lines[i])):
        lines[i][n] = int(lines[i][n])

print lines

def vertical_max(lines):
    for i in range(0,len(lines)):
        for j in range(0,len(lines)):
            pass

def horizontal_max(lines):
    pass

def diagonal_max(lines):
    pass
