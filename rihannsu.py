# Original Rihannsu language generator written by Diane Duane in BASIC
# Ported to Python and expanded by Laurence Toal (@anyaMairead)

# Rihannsu word patterns, as derived from the language in "My Enemy, My Ally"
# and "The Romulan way (where v=vowel and c=consonant):
# v, vc, cv, vcv, cvc, vcvc, cvcv, vcvcv, cvcvc, vcvcvc, cvcvcvc,

from random import choice, randint, seed
from string import capitalize

#morpheme lists
#punctuation has been removed from these lists and gets added
#in during the execution of the generate_sentence function.
initial_letters = ["H'", "Ae", "D'", "W","U", "N'", "R'", "O", "V", "Ll"]
    
vowels = ["ae","A","i'","a","Eh","e","T'","I","u'","s"
	  "ae","ea","ei","e","a","iu","o","ie","i"
    	  "eo","i","ae","ie","ai","au","a","ei","ah"
    	  "ao","a","aeu","u","ae","oa","i","s"
    	  "i","ea","ia","E","ei","ta'","ra-","ei",
    	  "'h","ae","oi","iy","u","ei","eh","s'h","i"
    	  "e'","ia","ie","iy","ih","ae","io","ai","ui"
    	  "ae","y","ei","ie","a'e","u","iu","ou","aa"
    	  "a","i","ih","i'h","e","ea","aa","ae","u","aeih"
    	  "ae","ei","iu","oa","ei","o","oi","ue"
    	  "e","ii","a","ee","eu","i","o","iu","uu"
    	  "uy","ae","e","i","'i","'u","'u","iae","eu","a"
    	  "ae","hl","iu","-a","ss","-t","r-","nn","'nh","ai"
    	  "iu","iu","hu","ha","la","se","mo","tha","kha","dha"
    	  "a","i","t","e","e","ae","ai","ia","ia","ou"]

consonants = ["s","ll","R","m","k","t","h","r","rr",
	      "v","mn","kh","d","hv","fv","r","t"
	      "th","k","lh","d","bh","d'","dr","ht"
	      "ll","lh","dt'","ht","th","kh","l'","nn","n"
	      "'rh","rh","jh","kj","lh","nv","tr","hw","fv"
	      "nn","hw","d","nv","mn","dh","rh","ll'","sw"
	      "lmn","l","mn","h'n","t","ss","hv","hs","hr"
	      "hj","hf","wh","rrh","bh","j","y"
	      "llu","dh","kh","rh","wh","mn"
	      "'ss","l'","k'h","hw","rr","r","rr'","mm","t'd","'hh"
	      "qh","vh","fv","nh","d","e","hh","k","a","t"
	      "dl","dl","rh","nnh","rai","th","dh-","yrh","aith","qh"
              "m","t","r","q","s","f","v","h","z","y"]

rihannsu_text = [] #create an empty array - will use to store text

def c():
    """Returns a random consonant"""
    return choice(consonants)

def v():
    """"Returns a random vowel"""
    return choice(vowels)
    
def word():
    """Returns a Rihannsu word.  Words are comprised of vowel-consonant patterns
    as identified by me in My Enemy, My Ally and The Romulan Way. Those patterns are
    listed in comments at the beginning of the program, this function assigns 
    probabilities to them based on existing words. You can change the probabilities of
    words of certain lengths by varying the 'i<number' statements."""
    i = randint(0, 78)
    if i <= 2:
        return "ie"
    elif i <= 3:
	return "au"
    elif i < 10:
	return v() + c()
    elif i < 17:
	return c() + v()
    elif i < 25:
 	return v() + c() + v()
    elif i < 33:
	return c() + v() + c()
    elif i < 43:
	return v() + c() + v() + c()
    elif i < 53:
	return c() + v() + c() + v()
    elif i < 68:
	return v() + c() + v() + c() + v()
    elif i < 71:
	return c() + v() + c() + v() + c()
    elif i < 74:
 	return v() + c() + v() + c() + v() + c()
    elif i < 76:
	return c() + v() + c() + v() + c() + v()
    elif i < 77:
	return v() + c() + v() + c() + v() + c() + v()
    elif i <= 78:
	return c() + v() + c() + v() + c() + v() + c()

def generate_sentence():
    """Generates a sentence in Rihannsu that contains between 4 and 8 words.
    Sentence length can be changed by changing the numbers in the array
    sentence_length"""
    sentence_length = choice([4, 4, 4, 5, 5, 5, 5, 6, 6, 7, 7, 8])
    for i in range(1, sentence_length):
        w = word()
        if i == 1: #ensure proper capitalization
            w = capitalize(w) 
        if i == sentence_length - 1: #add ending punctuation
            w += choice([".", ".", ".", "....", ".", "?", "?", "!", "."])
        elif randint(0, 10) < 1: #add intra-sentence punctuation
            w += choice([",", ",", ",", ";"])
        rihannsu_text.append(w)
    
def generate_text():
    """Prints a paragrpah of Rihannsu text that contains 30 sentences.
    Paragraph length can be adjusted by changing the range."""
    for i in range (0,30):
        generate_sentence()
    print " ".join(rihannsu_text) #print the entire paragraph
            
seed() #random number generator
generate_text()
