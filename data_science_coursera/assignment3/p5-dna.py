import MapReduce
import sys

"""
Problem 5: Remove last 10 chars from each string of nucleotides and remove any duplicates generated
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    # key: seqid: sequence id
    # value: nucleotides: Sequence of nucleotides formatted as a string
    seqid = record[0]
    nucs = record[1].encode('utf-8')
    mr.emit_intermediate( nucs, 1 )

def reducer(key, list_of_values):
    # key: nucleotides
    # value: <junk>
    trimmed = key.encode('utf-8')[:-10]
    mr.emit( trimmed )

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
