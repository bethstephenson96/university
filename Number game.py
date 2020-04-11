from random import randint
for i in range(1):
    #generates random number between 1 and 1000
    value=randint(1,1000)
    print(value)
for i in range(10):
    #10 guesses
    num1=int(input("Enter guess: "))
    if int((num1-20))>value:
        print("Way too high!")
    elif num1>value:
        print("Too high!")
    elif int((num1+20))<value:
        print("Way too low!")
    elif num1<value:
        print("Too low!")
    elif num1==value:
        print("Correct!")
        break
print("The number was...")
print(value,"!")
print("Thanks for playing")

