# =============================
# Student Names: Nolan Ling 20299056 & Darwin Chen 20267164
# Group ID: 27
# Date: feb 02 2024
# =============================
# CISC 352 - W23
# heuristics.py
# desc:
#


#Look for #IMPLEMENT tags in this file. These tags indicate what has
#to be implemented to complete problem solution.

'''This file will contain different constraint propagators to be used within
   the propagators

var_ordering == a function with the following template
    var_ordering(csp)
        ==> returns Variable

    csp is a CSP object---the heuristic can use this to get access to the
    variables and constraints of the problem. The assigned variables can be
    accessed via methods, the values assigned can also be accessed.

    var_ordering returns the next Variable to be assigned, as per the definition
    of the heuristic it implements.
   '''

def ord_dh(csp):
    ''' return variables according to the Degree Heuristic '''
    max_degree = -1
    selected_var = None
    for var in csp.get_all_unasgn_vars():
        degree = sum(1 for cons in csp.get_cons_with_var(var) if any(not v.is_assigned() for v in cons.get_scope() if v != var))
        if degree > max_degree:
            max_degree = degree
            selected_var = var
    return selected_var


def ord_mrv(csp):
    ''' return variable according to the Minimum Remaining Values heuristic '''
    min_domain_size = float('inf')
    selected_var = None
    for var in csp.get_all_unasgn_vars():
        domain_size = var.cur_domain_size()
        if domain_size < min_domain_size:
            min_domain_size = domain_size
            selected_var = var
    return selected_var
