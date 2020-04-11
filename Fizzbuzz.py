# -*- coding: utf-8 -*-
"""
Created on Sat Apr 11 10:09:45 2020

@author: Beth
"""

mylist=list(range(1,101))
for x in mylist:
    #if number is a multiple of 3 and 5, print fizzbuzz
    if x%3==0 and x%5==0:
        print('FizzBuzz')
    #if number is a multiple of 3 print fizz
    elif x%3==0:
        print('Fizz')
    #if number is a multiple of 5 print buzz
    elif x%5==0:
        print('Buzz')
    else:
        print(x)