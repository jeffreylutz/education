import MapReduce
import sys

"""
Problem 4:  Find asymetric friends
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    # key: personA
    # value: personB - Friend of PersonA
    personA = record[0]
    friend = record[1]
    mr.emit_intermediate(friend, personA )
    mr.emit_intermediate(personA, friend )

def reducer(key, list_of_values):
    # key: personA
    # value: list of friends of personA
    person = key
    map = {}
    for friend in list_of_values:
      map[friend] = map.get(friend,0) + 1
    for friend in map:
      if map[friend] != 2:
        mr.emit( (person,friend) ) 

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
