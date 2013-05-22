import sys
import json

def hw(sent_file, tweet_file):
    newterms = {}
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
        tweetnewterms = []
        for word in tweet.encode('utf-8').split():
            score = score + scores.get(word,0.0)
            if word not in scores:
                tweetnewterms.append(word)
        for newterm in tweetnewterms:
            newterms[newterm] = newterms.get(newterm,0.0) + score
    for nterm in newterms:
        print nterm, newterms[nterm]
#    print newterms

def lines(fp):
    print str(len(fp.readlines()))

def main():
    sent_file = open(sys.argv[1])
    tweet_file = open(sys.argv[2])
    hw(sent_file, tweet_file)
#    lines(sent_file)
#    lines(tweet_file)

if __name__ == '__main__':
    main()
