# -*- coding: utf-8 -*-
"""
Created on Sat Apr 11 10:14:05 2020

@author: Beth
"""

def animal_crackers(text):
    wordlist=text.split()
    print(wordlist)
    first=wordlist[0]
    second=wordlist[1]
    #returns true if both words begin with same letter
    if first[0].lower()==second[0].lower():
        return True
    else:
        return False

print(animal_crackers('Cool cat'))
print(animal_crackers('Lazy tiger'))