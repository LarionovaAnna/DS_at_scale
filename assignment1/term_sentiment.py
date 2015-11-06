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
    new_score={}
    for line in tweet_file:
        tweet_score=0      
        tweet =json.loads(line) 
        if tweet.get("text"):
            text=tweet["text"].lower().split(" ")
            for word in text:
                word=re.sub("([^a-z])","",word)
                if word!="" and word in scores:
                    tweet_score=tweet_score+int(scores[word])
            for word in text:
    		word=re.sub("([^a-z])","",word)
                new_wordscore=0.0
		if word!="" and word not in scores and tweet_score<>0:
		    new_wordscore=float(tweet_score)/float(len(text))   
		    if word in new_score:
                        new_score[word]=new_wordscore + new_score[word]
                    else:                    
			new_score[word]=new_wordscore                 
    for item in new_score:
	print item,new_score[item]
if __name__ == '__main__':
    main()
