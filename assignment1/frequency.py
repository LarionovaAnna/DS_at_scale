import sys
import json
import re
import operator

def hw():
    print 'Hello, world!'

def lines(fp):
    print str(len(fp.readlines()))

def main():
    tweet_file = open(sys.argv[1])
    #hw()
    #lines(sent_file)
    #lines(tweet_file)
    terms = {} # initialize an empty dictionary
    term_total=0.0
    for line in tweet_file:
        tweet =json.loads(line) 
        if tweet.get("text"):           
            for word in tweet["text"].lower().split(" "):
		term_total=term_total+1.0
                word=re.sub("([^a-z])","",word)
                if word!="" and word not in terms:
                    terms[word]=1.0
                elif word!="" and word in terms:
		    terms[word]=terms[word]+1.0
    terms = sorted(terms.items(), key=operator.itemgetter(0))
    for key,value in (terms):	
	print key,value/term_total          

if __name__ == '__main__':
    main()
