import sys
import json

def hw(tweet_file):
    terms = {}
    total = 0.0
    scores = {} # initialize an empty dictionary
    for line in tweet_file:
        d = json.loads(line)
        tweet = d.get('text','').encode('utf-8')
        for word in tweet.split():
            total = total + 1.0
            terms[word] = terms.get(word,0.0) + 1.0
    for term in terms:
        freq = terms[term] / total
        print term, freq

def lines(fp):
    print str(len(fp.readlines()))

def main():
    tweet_file = open(sys.argv[1])
    hw(tweet_file)
#    lines(sent_file)
#    lines(tweet_file)

if __name__ == '__main__':
    main()
