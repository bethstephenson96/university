# -*- coding: utf-8 -*-
"""
Created on Sat Apr 11 10:17:42 2020

@author: Beth
"""

def blackjack(a,b,c):
    total=(a+b+c)
    #ace counts as 1 or 11
    if a==11 or b==11 or c==11:
        if total>21:
            return total-10
        else:
            return total
    elif total <=21:
        return total
    else:
        return ('BUST')


print(blackjack(5,6,7))
print(blackjack(9,9,9))
print(blackjack(9,9,11))