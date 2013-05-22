import sys
import json
import re

def hw(tweet_file):
    h = {}
    for line in tweet_file:
        d = json.loads(line)
        hashList = None
        if 'entities' in d:
            hashList = d.get('entities','').get('hashtags',[])
        if hashList is not None:
            
            for hash in hashList:
                if 'text' in hash:
                    v = 0.0
                    hashtag = hash.get('text','')
                    v = h.get(hashtag, 0.0) + 1.0
                    h[hashtag] = v
    for i in [1,2,3,4,5,6,7,8,9,10]:
        highHash = 'NotApplicable'
        highVal = -1.0
        for hash in h.keys():
            if h[hash] > highVal:
                highHash = hash
                highVal = h[hash]
        h.pop(highHash, 0)
        if highVal != -1.0:
            print highHash, highVal

#    print h

def lines(fp):
    print str(len(fp.readlines()))

def main():
    tweet_file = open(sys.argv[1])
    hw(tweet_file)
#    lines(sent_file)
#    lines(tweet_file)

if __name__ == '__main__':
    main()
