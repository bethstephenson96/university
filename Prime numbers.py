# -*- coding: utf-8 -*-
"""
Created on Sat Apr 11 10:20:55 2020

@author: Beth
"""

##Counts the number of prime numbers up to a given number and lists them ##

def count_primes(num):
#check for 0 or 1 input
    if num<2:
        return 0
#input is 2 or greater
    primes=[2] #start off primes list with 2
    x=3 #counter from 3 until input number
    while x<=num:
        #could use for y in primes:
        for y in range(3,x,2):  #check every number from 3 to the count number, in steps of 2 because even numbers can't be prime as they can be divided by 2
            if x%y==0:
                x=x+2
                break
        else:
            primes.append(x)
            x=x+2
    print(primes)
    return len(primes)


print(count_primes(100))