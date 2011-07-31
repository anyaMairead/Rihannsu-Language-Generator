# Original Rihannsu language generator written by Diane Duane in BASIC
# Ported to Ruby and expanded by Laurence Toal (@anyaMairead)

# Rihannsu word patterns, as derived from the language in "My Enemy, My Ally"
# and "The Romulan way (where v=vowel and c=consonant):
# v, vc, cv, vcv, cvc, vcvc, cvcv, vcvcv, cvcvc, vcvcvc, cvcvcv, vcvcvcv, cvcvcvc

#morpheme lists
#punctuation has been removed from these lists and gets added
#in during the execution of the generate_sentence function.
$initial_letters = ["H'", "Ae", "D'", "W","U", "N'", "R'", "O", "V", "Ll"]

$vowels = ["ae","A","i'","a","Eh","e","T'","I","u'","s",
	  "ae","ea","ei","e","a","iu","o","ie","i",
    	  "eo","i","ae","ie","ai","au","a","ei","ah",
    	  "ao","a","aeu","u","ae","oa","i","s",
    	  "i","ea","ia","E","ei","ta'","ra-","ei",
    	  "'h","ae","oi","iy","u","ei","eh","s'h","i",
    	  "e'","ia","ie","iy","ih","ae","io","ai","ui",
    	  "ae","y","ei","ie","a'e","u","iu","ou","aa",
    	  "a","i","ih","i'h","e","ea","aa","ae","u","aeih",
    	  "ae","ei","iu","oa","ei","o","oi","ue",
    	  "e","ii","a","ee","eu","i","o","iu","uu",
    	  "uy","ae","e","i","'i","'u","'u","iae","eu","a",
    	  "ae","hl","iu","-a","ss","-t","r-","nn","'nh","ai",
    	  "iu","iu","hu","ha","la","se","mo","tha","kha","dha",
    	  "a","i","t","e","e","ae","ai","ia","ia","ou"]

$consonants = ["s","ll","R","m","k","t","h","r","rr",
	      "v","mn","kh","d","hv","fv","r","t",
	      "th","k","lh","d","bh","d'","dr","ht",
	      "ll","lh","dt'","ht","th","kh","l'","nn","n",
	      "'rh","rh","jh","kj","lh","nv","tr","hw","fv",
	      "nn","hw","d","nv","mn","dh","rh","ll'","sw",
	      "lmn","l","mn","h'n","t","ss","hv","hs","hr",
	      "hj","hf","wh","rrh","bh","j","y",
	      "llu","dh","kh","rh","wh","mn",
	      "'ss","l'","k'h","hw","rr","r","rr'","mm","t'd","'hh",
	      "qh","vh","fv","nh","d","e","hh","k","a","t",
	      "dl","dl","rh","nnh","rai","th","dh-","yrh","aith","qh",
              "m","t","r","q","s","f","v","h","z","y"]
              
$rihannsu_text = [] #create an empty array - will use to store text
              
def c
  return $consonants.choice
end

def v
  return $vowels.choice
end
              
#Returns a Rihannsu word.  Words are comprised of vowel-consonant patterns
#as identified by me in My Enemy, My Ally and The Romulan Way. Those patterns are
#listed in comments at the beginning of the program, this function assigns 
#probabilities to them based on existing words. You can change the probabilities of
#words of certain lengths by varying the 'i<number' statements.
def word
  i = rand(78)
  if i <= 2
    "ie"
  elsif i <= 3
    "au"
  elsif i < 10
    v + c
  elsif i < 17
    c + v
  elsif i < 25
    v + c + v
  elsif i < 33
    c + v + c
  elsif i < 43
    v + c + v + c
  elsif i < 53
    c + v + c + v
  elsif i < 68
    v + c + v + c + v
  elsif i < 71
    c + v + c + v + c
  elsif i < 74
    v + c + v + c + v + c
  elsif i < 76
    c + v + c + v + c + v
  elsif i < 77
    v + c + v + c + v + c + v
  elsif i <= 78
    c + v + c + v + c + v + c
  end
end
              
def first_word
  """Special case when the word is the first one in the sentence: start word
  with one of 10 specific morphemes"""
  w = word
  #The following tests prevent the occurence of vowel-vowel and consonant-consonant
  #combinations, which, from what I can tell, don't occur in the Rihannsu language.
  if ["a", "e", "i", "o", "u"].include? w[0]
      ["H'", "D'", "W", "N'", "R'", "V", "Ll"].choice + w
  else
      ["H'", "Ae", "D'", "U", "N'", "R'", "O"].choice + w
  end
  #In the event that the initial letters list was only necessary because of the
  #difficulty of capitalizing words in BASIC, this function and the initial_letters
  #array can be deleted, and a capitalization clause added to the generate_sentence function              
end

def generate_sentence
  """Generates a sentence in Rihannsu that contains between 4 and 8 words.
  Sentence length can be changed by changing the numbers in the array
  sentence_length"""
  sentence_length = [4, 4, 4, 5, 5, 5, 5, 6, 6, 7, 7, 8].choice
  for i in 0...sentence_length:
    w = i == 0 ? first_word : word 	
    #If a sentence can start with any word, delete the preceeding line and add:
    #if i==1:
    #    w = capitalize(w)
    if i == sentence_length - 1 #add ending punctuation
      w += [".", ".", ".", "....", ".", "?", "?", "!", "."].choice
    elsif rand(10) < 1 #add intra-sentence punctuation
      w += [",", ",", ",", ";"].choice
    end
    $rihannsu_text << w
    end
end
    
def generate_text
  """Prints a paragrpah of Rihannsu text that contains 30 sentences.
  Paragraph length can be adjusted by changing the range."""
  30.times{generate_sentence}
  print $rihannsu_text.join(" ") #print the entire paragraph
end

srand #random number generator
generate_text 
