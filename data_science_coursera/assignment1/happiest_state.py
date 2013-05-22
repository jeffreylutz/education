import sys
import json

def hw(sent_file,tweet_file):
    s = ['AL','AK','AZ','CA','CO','CT','DE','DE','DC','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','PR','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY']
    sm = {}
    for state in s:
        sm[state] = 0.0
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
        place_country = ''
        place_name = ''
        user_log = ''
        if d.get('user') != None:
            user_loc = d.get('user','').get('location','')
        if d.get('place') != None:
            place_country = d.get('place').get('country_code','')
        if place_country == 'US':
            place_name = d.get('place').get('full_name','')
#        print score
#        print user_loc, place_country, place_name
        if len(place_name) > 1:
#            print place_name
            for state in s:
                if state in place_name:
                    sm[state] = sm[state] + score
    state = 'AA'
    stateval = -1000.0
    for k in sm:
        score = sm[k]
        if score > stateval:
            stateval = score
            state = k
    print state

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
