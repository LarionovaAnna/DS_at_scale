import sys
import json
import re

def hw():
    print 'Hello, world!'

def lines(fp):
    print str(len(fp.readlines()))

def main():
    sentiment_file = open(sys.argv[1])
    tweet_file = open(sys.argv[2])
    #hw()
    #lines(sent_file)
    #lines(tweet_file)
    scores = {} # initialize an empty dictionary
    for line in sentiment_file:
        term, score  = line.split("\t")  # The file is tab-delimited. "\t" means "tab character"
        scores[term] = int(score)  # Convert the score to an integer.
    
    for line in tweet_file:
        tweet_score=0      
        tweet =json.loads(line) 
        if tweet.get("text"):
            for word in tweet["text"].lower().split(" "):
                word=re.sub("([^a-z])","",word)
                if word!="" and word in scores:
                    tweet_score=tweet_score+int(scores[word])
        print tweet_score
    

if __name__ == '__main__':
    main()
