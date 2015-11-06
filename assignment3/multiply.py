import MapReduce
import sys

"""
Word Count Example in the Simple Python MapReduce Framework
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    # key: document identifier
    # value: document contents
    matrix, row, col, value = record
    for n in range(5):
    	if matrix=='a':	
	    mr.emit_intermediate((row,n),(matrix,col, value ))
    	else:	
	    mr.emit_intermediate((n,col),(matrix,row, value ))

def reducer(key, list_of_values):
    # key: word
    # value: list of occurrence counts
    a_matrix = [(item[1],item[2]) for item in list_of_values if item[0] == 'a' ]
    b_matrix = [(item[1],item[2]) for item in list_of_values if item[0] == 'b' ]
 
    result = 0
 
    for item_a in a_matrix:
        for item_b in b_matrix:
            if item_a[0] == item_b[0]:
                result += item_a[1] * item_b[1]
    if result!=0:
        mr.emit((key[0],key[1], result)) 
# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
