import MapReduce
import sys

"""
DB Join
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    # key: table-id - line_item, order
    # value: order-id
    tableid = record[0]
    orderid = record[1]
    words = orderid.split()
    mr.emit_intermediate(orderid, record)

def reducer(key, list_of_values):
    # key: orderid
    # value: list of order and line_item records
    orderrec = []
    for v in list_of_values:
      tableid = v[0].encode('utf-8')
      if tableid == 'order':
        orderrec = v
        break
    for v in list_of_values:
      tableid = v[0].encode('utf-8')
      if tableid != 'order':
        mr.emit( orderrec + v )

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
