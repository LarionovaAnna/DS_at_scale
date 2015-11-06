import sys
import json
import re

def hw():
    print 'Hello, world!'

def lines(fp):
    print str(len(fp.readlines()))

def main():
    tweet_file = open(sys.argv[1])
    hashtags={}
    for line in tweet_file:     
        tweet =json.loads(line)
	hashtag="" 
        if tweet.get("entities"):
	    for item in tweet["entities"]["hashtags"]:
	        hashtag=re.sub("([^a-z])","", item["text"].lower())
		if hashtag!="" and hashtag not in hashtags:
		    hashtags[hashtag]=1
		elif hashtag!="" and hashtag in hashtags:
		    hashtags[hashtag]=hashtags[hashtag]+1 
    hashtags = sorted(hashtags.items(), key=lambda x:x[1],reverse=True)
    
    for key,value in hashtags[:10]:
	        
	print key,value	
    

if __name__ == '__main__':
    
    main()
    
