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
    happy_states={
	'AK': 'Alaska',
        'AL': 0,
        'AR': 0,
        'AS': 0,
        'AZ': 0,
        'CA': 0,
        'CO': 0,
        'CT': 0,
        'DC': 0,
        'DE': 0,
        'FL': 0,
        'GA': 0,
        'GU': 0,
        'HI': 0,
        'IA': 0,
        'ID': 0,
        'IL': 0,
        'IN': 0,
        'KS': 0,
        'KY': 0,
        'LA': 0,
        'MA': 0,
        'MD': 0,
        'ME': 0,
        'MI': 0,
        'MN': 0,
        'MO': 0,
        'MP': 0,
        'MS': 0,
        'MT': 0,
        'NA': 0,
        'NC': 0,
        'ND': 0,
        'NE': 0,
        'NH': 0,
        'NJ': 0,
        'NM': 0,
        'NV': 0,
        'NY': 0,
        'OH': 0,
        'OK': 0,
        'OR': 0,
        'PA': 0,
        'PR': 0,
        'RI': 0,
        'SC': 0,
        'SD': 0,
        'TN': 0,
        'TX': 0,
        'UT': 0,
        'VA': 0,
        'VI': 0,
        'VT': 0,
        'WA': 0,
        'WI': 0,
        'WV': 0,
        'WY': 0
}
    states = {
        'AK': 'Alaska',
        'AL': 'Alabama',
        'AR': 'Arkansas',
        'AS': 'American Samoa',
        'AZ': 'Arizona',
        'CA': 'California',
        'CO': 'Colorado',
        'CT': 'Connecticut',
        'DC': 'District of Columbia',
        'DE': 'Delaware',
        'FL': 'Florida',
        'GA': 'Georgia',
        'GU': 'Guam',
        'HI': 'Hawaii',
        'IA': 'Iowa',
        'ID': 'Idaho',
        'IL': 'Illinois',
        'IN': 'Indiana',
        'KS': 'Kansas',
        'KY': 'Kentucky',
        'LA': 'Louisiana',
        'MA': 'Massachusetts',
        'MD': 'Maryland',
        'ME': 'Maine',
        'MI': 'Michigan',
        'MN': 'Minnesota',
        'MO': 'Missouri',
        'MP': 'Northern Mariana Islands',
        'MS': 'Mississippi',
        'MT': 'Montana',
        'NA': 'National',
        'NC': 'North Carolina',
        'ND': 'North Dakota',
        'NE': 'Nebraska',
        'NH': 'New Hampshire',
        'NJ': 'New Jersey',
        'NM': 'New Mexico',
        'NV': 'Nevada',
        'NY': 'New York',
        'OH': 'Ohio',
        'OK': 'Oklahoma',
        'OR': 'Oregon',
        'PA': 'Pennsylvania',
        'PR': 'Puerto Rico',
        'RI': 'Rhode Island',
        'SC': 'South Carolina',
        'SD': 'South Dakota',
        'TN': 'Tennessee',
        'TX': 'Texas',
        'UT': 'Utah',
        'VA': 'Virginia',
        'VI': 'Virgin Islands',
        'VT': 'Vermont',
        'WA': 'Washington',
        'WI': 'Wisconsin',
        'WV': 'West Virginia',
        'WY': 'Wyoming'
}
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
	state="" 
        if tweet.get("text") and tweet.get("place"):
	    for word in tweet["text"].lower().split(" "):
                word=re.sub("([^a-z])","",word)
                if word!="" and word in scores:
                    tweet_score=tweet_score+int(scores[word])	
		for key in states:
		    if key.lower()==word or states[key].lower()==word:
			happy_states[key]=happy_states[key]+tweet_score    
	    if tweet["place"]["country_code"].upper() in ("US","USA") and tweet["place"]["place_type"]=="city":
		state=tweet["place"]["full_name"].split(", ")[1]	
		if state in happy_states:
		    happy_states[state]=happy_states[state]+tweet_score
	    elif tweet["place"]["country_code"].upper() in ("US","USA") and tweet["place"]["place_type"]=="admin":
		state=tweet["place"]["full_name"].split(", ")[0]	
		if state in happy_states:
		    happy_states[state]=happy_states[state]+tweet_score
    happy_states = sorted(happy_states.items(), key=lambda x:x[1],reverse=True)		
    for key,value in happy_states[:1]:          
	print key
    

if __name__ == '__main__':
    
    main()
    
