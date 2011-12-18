--[[ Original Rihannsu language generator written by Diane Duane in BASIC
Ported to Lua and expanded by Laurence Toal (@anyaMairead)

Rihannsu word patterns, as derived from the language in "My Enemy, My Ally"
and "The Romulan Way" (where v=vowel and c=consonant):
v, vc, cv, vcv, cvc, vcvc, cvcv, vcvcv, cvcvc, vcvcvc, cvcvcv, vcvcvcv, cvcvcvc --]]

vowels = {"ae","A","i'","a","Eh","e","T'","I","u'","s",
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
          "a","i","t","e","e","ae","ai","ia","ia","ou"}
    	  
consonants = {"s","ll","R","m","k","t","h","r","rr",
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
              "m","t","r","q","s","f","v","h","z","y"}

rihannsu_text = {}

function c()
    print (consonants[math.random(#consonants)])
end

function v()
    print (vowels[math.random(#vowels)])
end


function word()
    --[[Returns a Rihannsu word.  Words are comprised of vowel-consonant patterns
    as identified by me in My Enemy, My Ally and The Romulan Way. Those patterns are
    listed in comments at the beginning of the program, this function assigns 
    probabilities to them based on existing words. You can change the probabilities of
    words of certain lengths by varying the 'i<number' statements. --]]
    i = math.random(0, 78)
    if i <= 2 then
        return "ie"
    elseif i <= 3 then
	return "au"
    elseif i < 10 then
	return v() .. c()
    elseif i < 17 then
	return c() .. v()
    elseif i < 25 then
 	return v() .. c() .. v()
    elseif i < 33 then
	return c() .. v() .. c()
    elseif i < 43 then
	return v() .. c() .. v() .. c()
    elseif i < 53 then
	return c() .. v() .. c() .. v()
    elseif i < 68 then
	return v() .. c() .. v() .. c() .. v()
    elseif i < 71 then
	return c() .. v() .. c() .. v() .. c()
    elseif i < 74 then
 	return v() .. c() .. v() .. c() .. v() .. c()
    elseif i < 76 then
	return c() .. v() .. c() .. v() .. c() .. v()
    elseif i < 77 then
	return v() .. c() .. v() .. c() .. v() .. c() .. v()
    elseif i <= 78 then
	return c() .. v() .. c() .. v() .. c() .. v() .. c()
    end
end

function generate_sentence()
    --Prints a paragraph of Rihannsu text that contains 30 sentences.
    --Paragraph length can be adjusted by changing the range.
    sentence_length_table = {4, 4, 4, 5, 5, 5, 5, 6, 6, 7, 7, 8}
    sentence_length=(sentence_length_table[math.random(#sentence_length_table)])
    for i = 1,sentence_length do
        w = word()
        if i==1 then --ensure proper capitalization
            w = str:gsub("^%l", string.upper)
        if i == sentence_length then --add ending punctuation
            w = w .. "."
        elseif math.random(0,10) < 1 then --add intra-sentence punctuation
            w = w .. ","
        end
        table.insert(rihannsu_text, w)
    end
end

function generate_text()
    --Prints a paragraph of Rihannsu text that contains 30 sentences.
    --Paragraph length can be adjusted by changing the range.
    for i = 0,30 do
        generate_sentence()
    end
    =table.concat(rihannsu_text, " ")
    --print l
end

math.randomseed() --initialize random number generator
generate_text()
