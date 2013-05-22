import sys
import json

def hw(sent_file,tweet_file):
    scores = {} # initialize an empty dictionary
    for line in sent_file:
        # The file is tab-delimited. "\t" means "tab character"
        term, score  = line.split("\t")
        # Convert the score to an integer.
        scores[term] = int(score) 
    for line in tweet_file:
        d = json.loads(line)
        tweet = d.get('text','').encode('utf-8')
        score = 0.0
        for word in tweet.split():
            score = score + scores.get(word,0.0)
        print score

def lines(fp):
    print str(len(fp.readlines()))

def main():
    sent_file = open(sys.argv[1])
    tweet_file = open(sys.argv[2])
    hw(sent_file,tweet_file)
#    lines(sent_file)
#    lines(tweet_file)

if __name__ == '__main__':
    main()
