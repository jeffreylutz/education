import MapReduce
import sys

"""
Inverted index:  A single word and a list of docids
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    # key: document identifier
    # value: document contents
    key = record[0]
    value = record[1]
    words = value.split()
    docid = key
    for w in words:
      mr.emit_intermediate(w, docid)

def reducer(key, list_of_values):
    # key: word
    # value: list of doc-ids
    word = key.encode('utf-8')
    s = set()
    for docid in list_of_values:
      s.add(docid.encode('utf-8') )
    mr.emit( (word, list(s)) )

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
