# =============================
# Student Names: Nolan Ling 20299056 & Darwin Chen 20267164
# Group ID: 27
# Date: feb 02 2024
# =============================
# CISC 352 - W23
# cagey_csp.py
# desc:
#

#Look for #IMPLEMENT tags in this file.
'''
All models need to return a CSP object, and a list of lists of Variable objects
representing the board. The returned list of lists is used to access the
solution.

For example, after these three lines of code

    csp, var_array = binary_ne_grid(board)
    solver = BT(csp)
    solver.bt_search(prop_FC, var_ord)

var_array is a list of all variables in the given csp. If you are returning an entire grid's worth of variables
they should be arranged in a linearly, where index 0 represents the top left grid cell, index n-1 represents
the top right grid cell, and index (n^2)-1 represents the bottom right grid cell. Any additional variables you use
should fall after that (i.e., the cage operand variables, if required).

1. binary_ne_grid (worth 10/100 marks)
    - A model of a Cagey grid (without cage constraints) built using only
      binary not-equal constraints for both the row and column constraints.

2. nary_ad_grid (worth 10/100 marks)
    - A model of a Cagey grid (without cage constraints) built using only n-ary
      all-different constraints for both the row and column constraints.

3. cagey_csp_model (worth 20/100 marks)
    - a model of a Cagey grid built using your choice of (1) binary not-equal, or
      (2) n-ary all-different constraints for the grid, together with Cagey cage
      constraints.


Cagey Grids are addressed as follows (top number represents how the grid cells are adressed in grid definition tuple);
(bottom number represents where the cell would fall in the var_array):
+-------+-------+-------+-------+
|  1,1  |  1,2  |  ...  |  1,n  |
|       |       |       |       |
|   0   |   1   |       |  n-1  |
+-------+-------+-------+-------+
|  2,1  |  2,2  |  ...  |  2,n  |
|       |       |       |       |
|   n   |  n+1  |       | 2n-1  |
+-------+-------+-------+-------+
|  ...  |  ...  |  ...  |  ...  |
|       |       |       |       |
|       |       |       |       |
+-------+-------+-------+-------+
|  n,1  |  n,2  |  ...  |  n,n  |
|       |       |       |       |
|n^2-n-1| n^2-n |       | n^2-1 |
+-------+-------+-------+-------+

Boards are given in the following format:
(n, [cages])

n - is the size of the grid,
cages - is a list of tuples defining all cage constraints on a given grid.


each cage has the following structure
(v, [c1, c2, ..., cm], op)

v - the value of the cage.
[c1, c2, ..., cm] - is a list containing the address of each grid-cell which goes into the cage (e.g [(1,2), (1,1)])
op - a flag containing the operation used in the cage (None if unknown)
      - '+' for addition
      - '-' for subtraction
      - '*' for multiplication
      - '/' for division
      - '?' for unknown/no operation given

An example of a 3x3 puzzle would be defined as:
(3, [(3,[(1,1), (2,1)],"+"),(1, [(1,2)], '?'), (8, [(1,3), (2,3), (2,2)], "+"), (3, [(3,1)], '?'), (3, [(3,2), (3,3)], "+")])

'''

from cspbase import *

def binary_ne_grid(cagey_grid):
    n, _ = cagey_grid  # Extract grid size, ignore cages for now
    csp = CSP("Cagey_" + str(n))  # Initialize CSP object with a unique name

    # Create variables
    var_array = []
    for i in range(n):
        row = []
        for j in range(n):
            var = Variable('V{}{}'.format(i+1, j+1), list(range(1, n+1)))
            row.append(var)
            csp.add_var(var)
        var_array.append(row)

    # Apply binary not-equal constraints for rows and columns
    for i in range(n):
        for j in range(n):
            # Row constraints
            for k in range(j+1, n):
                c = Constraint("C(V{}{},V{}{})".format(i+1, j+1, i+1, k+1), [var_array[i][j], var_array[i][k]])
                c.add_satisfying_tuples(binary_ne_tuples(var_array[i][j], var_array[i][k]))
                csp.add_constraint(c)

            # Column constraints
            for k in range(i+1, n):
                c = Constraint("C(V{}{},V{}{})".format(i+1, j+1, k+1, j+1), [var_array[i][j], var_array[k][j]])
                c.add_satisfying_tuples(binary_ne_tuples(var_array[i][j], var_array[k][j]))
                csp.add_constraint(c)

    # Convert var_array to a single list as specified in the instructions
    linear_var_array = [var for row in var_array for var in row]
    return csp, linear_var_array

def binary_ne_tuples(var1, var2):
    """Generate all satisfying tuples for a binary not-equal constraint between two variables."""
    sat_tuples = []
    for val1 in var1.domain():
        for val2 in var2.domain():
            if val1 != val2:
                sat_tuples.append((val1, val2))
    return sat_tuples

def nary_ad_grid(cagey_grid):
    n, _ = cagey_grid  # Extract grid size, ignore cages for now
    csp = CSP("CageyAD_" + str(n))  # Initialize CSP object with a unique name

    # Create variables
    var_array = []
    for i in range(n):
        row = []
        for j in range(n):
            var = Variable('V{}{}'.format(i+1, j+1), list(range(1, n+1)))
            row.append(var)
            csp.add_var(var)
        var_array.append(row)

    # Apply n-ary all-different constraints for rows
    for i in range(n):
        vars_in_row = var_array[i]
        c = Constraint("Row_{}".format(i+1), vars_in_row)
        c.add_satisfying_tuples(nary_ad_tuples(vars_in_row))
        csp.add_constraint(c)

    # Apply n-ary all-different constraints for columns
    for j in range(n):
        vars_in_column = [var_array[i][j] for i in range(n)]
        c = Constraint("Column_{}".format(j+1), vars_in_column)
        c.add_satisfying_tuples(nary_ad_tuples(vars_in_column))
        csp.add_constraint(c)

    # Convert var_array to a single list as specified in the instructions
    linear_var_array = [var for row in var_array for var in row]
    return csp, linear_var_array

def nary_ad_tuples(vars):
    """Generate all satisfying tuples for an n-ary all-different constraint among a set of variables."""
    from itertools import permutations
    domain = vars[0].domain()  # Assuming all variables have the same domain
    all_tuples = [tuple(p) for p in permutations(domain, len(vars))]
    return all_tuples


def cagey_csp_model(cagey_grid):
    from itertools import product
    from math import prod

    n, cages = cagey_grid
    csp, var_array = binary_ne_grid(cagey_grid)

    for cage in cages:
        target, cells, operator = cage
        # Convert grid cells to variables in the CSP
        cage_variables = [var_array[(cell[0] - 1) * n + (cell[1] - 1)] for cell in cells]

        # Create a variable for the cage operation
        cage_operation = Variable(f"Cage({target}:{operator}:{cage_variables})", ["+", "-", "*", "/", "?"])
        csp.add_var(cage_operation)

        # Prepare variables for the constraint, including the operation
        constraint_vars = cage_variables + [cage_operation]
        constraint = Constraint(f'Cage({target}:{operator}:{cage_variables})', constraint_vars)

        # Assign the operation to the cage operation variable if it's not a wildcard
        if operator != "?":
            cage_operation.assign(operator)

        # Generate satisfying tuples for the constraint
        satisfying_tuples = []
        domains = [var.cur_domain() for var in constraint_vars]

        if operator != "?" or len(constraint_vars) == 1:
            for t in product(*domains):
                if cagey_check(target, t):
                    satisfying_tuples.append(t)
        else:  # Handle the wildcard operator case
            for trial_operator in ["+", "-", "*", "/"]:
                domains[-1] = trial_operator  # Set the last domain to the trial operator
                for t in product(*domains):
                    if cagey_check(target, t):
                        satisfying_tuples.append(t)

        constraint.add_satisfying_tuples(satisfying_tuples)

        # Add the operation variable and the constraint to the CSP
        var_array.append(cage_operation)
        csp.add_constraint(constraint)

    return csp, var_array

def cagey_check(target, operands):
    """
    Takes a list of valuations and attempts to determine if this is a valid assignment.
    :param target (natural num), operands (a list of integers with an operator in the last index)
    Return True/False
    """
    # Dictionary mapping operators to lambda functions for evaluation
    operations = {
        "+": lambda op1, op2: op1 + op2,
        "-": lambda op1, op2: op1 - op2,
        "*": lambda op1, op2: op1 * op2,
        "/": lambda op1, op2: op1 / op2
    }

    value = 0
    operator = operands[-1]
    operands = operands[:-1]

    if len(operands) == 1:
        return target == operands[0]
    elif len(operands) == 2:
        # Use lambda function from the dictionary
        return target == abs(operations[operator](operands[0], operands[1]))
    else:
        value = operands[0]
        for i in range(1, len(operands)):
            # Use lambda function from the dictionary for each pair of operands
            value = operations[operator](value, operands[i])
        return target == abs(value)
