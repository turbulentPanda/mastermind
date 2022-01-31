# Mastermind

## Live Preview (replit)

https://replit.com/@turbulentPanda/Mastermind#main.rb

## Brief Description of the Project

This is a Ruby command line implementation of the code-breaking game Mastermind. It is meant to be played by one player against the computer.

To play, visit the replit using the link given above in the Live Preview (replit) section. Click on "Run" to start the replit.

Game instructions are given in the program. For a more complete description, view the rules at https://en.wikipedia.org/wiki/Mastermind_(board_game) 

In short, there are two players in Mastermind: a code-breaker and a code-setter. The code-setter chooses a 4-digit code from numbers 1-6 (repeated numbers are allowed). The code-breaker then tries to guess the code within 12 moves. After every guess, the code-setter gives the code-breaker a set of clues (e.g., whether a number was in the correct spot, in an incorrect spot, or not in the code at all). The game ends when the code-breaker has cracked the code or run out of attempts.

## Goals of Project

The goal of this project was to practice using object oriented programming principles with Ruby.

## What I Learned

This project presented excellent practice with OOP! It was much larager than other Ruby projects that I have ccompleted and was a good synthesis of Ruby topics. Before making this program, I implemented a Tic-Tac-Toe game in Ruby (also with the goal of practicing OOP). However, I didn't really "get it" with that game. Here, I felt like everything clicked. While the code could still use some refactoring, I feel like I really understood the benefits and mechanics of implementing classes and class inheritance. I am much more confident in using OOP for future projects; indeed, I am very excited about it! 

## Next Steps

Right now, when the user chooses to be the code-setter, and the computer is the code-breaker, the computer attempts to guess the code completely randomly. The ComputerCodeBreaker does not make use of the clues given by the code-setter. Thus, it is exceedingly unlikely that a ComputerCodeBreaker object will guess the code, which makes it a bit boring to be the code-setter. So, the main goal moving forward will be to implement a more strategic guessing mechanism for the ComputerCodeBreaker class (most likely using Knuth's adaptation of the minimax algorithm for solving Mastermind).

In addition, as I continue to learn about OOP best practices (and code smells), I will likely refactor the code.