import MapReduce
import sys

"""
social network dataset
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    # key: personA
    # value: personB - Friend of PersonA
    personA = record[0]
    friend = record[1]
    mr.emit_intermediate(personA, friend)

def reducer(key, list_of_values):
    # key: personA
    # value: list of friends of personA
    mr.emit( (key, len(list_of_values) ) )

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
