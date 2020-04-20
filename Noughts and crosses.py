# -*- coding: utf-8 -*-
"""
Created on Mon Apr 20 10:41:28 2020

@author: Beth
"""


#function that can print out a 3 by 3 board
from IPython.display import clear_output
#This can clear the screen after each turn
def display_board(board):
    clear_output()
    pat1='    |    |    '
    pat2='--------------'
    print(pat1)
    print(' {}  |  {} |  {} '.format(board[7],board[8],board[9]))
    print(pat1)
    print(pat2)
    print(pat1)
    print(' {}  |  {} |  {} '.format(board[4],board[5],board[6]))
    print(pat1)
    print(pat2)
    print(pat1)
    print(' {}  |  {} |  {} '.format(board[1],board[2],board[3]))
    print(pat1)

#function that lets players decide if they are noughts or crosses
def player_input():
    marker=''
    while marker!='X' and marker!='O':
        marker=input('Player 1, pick X or O: ').upper()
    if marker=='X':
        marker2='O'
    else:
        marker2='X'
    print ('Player 1 is ',marker.upper(),', player 2 is ',marker2.upper())
    player1=marker
    player2=marker2
    return(player1,player2)
#returns a tuple
player1_marker,player2_marker=player_input() 

#function that puts each new marker on the board
def place_marker(board, marker, position):
    board[position]=marker
    return board

#function that checks for a win
def win_check(board, mark):
    if board[1]==board[2]==board[3]==mark:
        return True
    elif board[4]==board[5]==board[6]==mark:
        return True
    elif board[7]==board[8]==board[9]==mark:
        return True
    elif board[1]==board[4]==board[7]==mark:
        return True
    elif board[2]==board[5]==board[8]==mark:
        return True
    elif board[3]==board[6]==board[9]==mark:
        return True
    elif board[1]==board[5]==board[9]==mark:
        return True
    elif board[3]==board[5]==board[7]==mark:
        return True
    else:
        return False

#function that randomly chooses a player to go first    
import random
def choose_first():
    num=random.randint(1,2)
    if num==1:
        return'Player 1'
    else:
        return'Player 2'

#function that checks if a space on the board is free
def space_check(board, position):
    return board[position]==' '#this might have to be ' ' not''

#function that checks if the board is full
def full_board_check(board):
    return board[1]!=' 'and board[2]!=' 'and board[3]!=' 'and board[4]!=' 'and board[5]!=' 'and board[6]!=' 'and board[7]!=' 'and board[8]!=' 'and board[9]!=' '

#function that asks for a players next position and checks if the space can be used
def player_choice(board):
    position=0
    while position not in [1,2,3,4,5,6,7,8,9] or not space_check(board,position):
        try:
            position = int(input('Player... choose your next position (1-9): '))
        except:
            print('Please try again')
    return position

#asks player if they want to play again
def replay():
    answer=''
    while answer!='Y' and answer!='N':
        answer=input('Do you want to play again (Y/N): ')
    return answer=='Y'

while True:
    demo_board=[' ','1','2','3','4','5','6','7','8','9']
    the_board=[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ']
    print('Welcome to noughts and crosses!\n')
    print('HOW TO PLAY: \nPick your position according to the number pad shown below:\n')
    pat1='    |    |    '
    pat2='--------------'
    print(pat1)
    print(' 7  |  8 |  9 ')
    print(pat1)
    print(pat2)
    print(pat1)
    print(' 4  |  5 |  6 ')
    print(pat1)
    print(pat2)
    print(pat1)
    print(' 1  |  2 |  3 ')
    print(pat1)
    player1_marker,player2_marker=player_input()
    print('\nRandomly deciding player order...\n')
    turn=choose_first()
    print(turn+ ' will go first')
    game_on=True
    
    
    while game_on:
        if turn=='Player 1':
            display_board(the_board)
            position=(player_choice(the_board))
            place_marker(the_board,player1_marker,position)
            display_board(the_board)#remember this clears the output
            if win_check(the_board,player1_marker):
                display_board(the_board)
                print('Player 1 wins!')
                game_on=False
            elif full_board_check(the_board)==True:
                display_board(the_board)
                print ("It's a tie!")
                game_on=False
            else:
                turn='Player 2'
        elif turn=='Player 2':
            display_board(the_board)
            position=(player_choice(the_board))
            place_marker(the_board,player2_marker,position)
            display_board(the_board)#remember this clears the output
            if win_check(the_board,player2_marker):
                display_board(the_board)
                print('Player 2 wins!')
                game_on=False
            elif full_board_check(the_board)==True:
                display_board(the_board)
                print ("It's a tie!")
                game_on=False
            else:
                turn='Player 1'
    
    
    if not replay():
        break
