# -*- coding: utf-8 -*-
"""
Created on Sat Apr 11 10:23:55 2020

@author: Beth
"""
## Calculates number of upper case and lower case letters in a string ##
def up_low(s):
    upper=[]
    lower=[]
    for letter in s:
        if letter.islower()==True:
            lower.append(letter)
        if letter.isupper()==True:
            upper.append(letter)
    uplen= len(''.join(upper))
    lowlen= len(''.join(lower))
    print('No. of Upper case characters: ',uplen,'\nNo. of Lower case characters: ',lowlen)

s = 'Sometimes on Tuesdays i listen to Britney Spears'
up_low(s)