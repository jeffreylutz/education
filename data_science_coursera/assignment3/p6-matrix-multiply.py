import MapReduce
import sys

"""
Problem 6:  Matrix Multiplication:  A x B
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line
# A[ixj] * B[jxk]
size = 10
def mapper(record):
    # key: <something>
    # value: [matrix, i, j, value]
    em = record[0].encode('utf-8')
    ei = record[1]
    ej = record[2]
    ev = record[3]
    for i in range(0,size):
      for j in range(0,size):
        key = str(i) + "x" + str(j)
        # emit elements for C[i,j] --> A[i,*] & B[*,j]
        if em == 'a' and ei == i:
#          mr.emit_intermediate( key, (ei,ej,em, ev) )
          mr.emit_intermediate( (i,j), (ei,ej,em, ev) )
        if em == 'b' and ej == j:
#          mr.emit_intermediate( key, (ei,ej,em, ev) )
          mr.emit_intermediate( (i,j), (ei,ej,em, ev) )

def reducer(key, list_of_values):
    # key: row number:  aka i
    # value: record list: [matrix, i, j, value]
    sum = 0
    arow = {}
    for a in list_of_values:
      i = a[0]
      j = a[1]
      m = a[2]
      v = a[3]
      if m == 'a':
        arow[j] = v
        continue
      if m == 'b' and i in arow:
        sum = sum + arow[i] * v
    ci = key[0]
    cj = key[1]
    if sum > 0:
      mr.emit( (ci, cj, sum) )
    return

# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
