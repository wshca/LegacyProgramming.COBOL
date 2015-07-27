-- Assignment 2: ADA Programming
-- 	Solving the 8-Queen's Puzzle
--  Created by:    Wolfgang Huettinger
--  Email:         
--  Date created:  February 11th 2013
--  Date modified: March 13th 2013
-- Assignment 2 - Procedure header for the stack

package assignment2stack is
   procedure setuptheQueen(numberofQueens : in integer; currentPosition : in integer; selection : in integer);
   procedure recursivepresetting(numberofQueens : in integer);
   procedure brutealgorithm(numberofQueens : in integer; recursion : in out integer);
   procedure recursivealgorithm(numberofQueens : in integer; recursion : in integer; quit: in out boolean);
   procedure drawroutine(numberofQueens : in integer);
   procedure drawroutineBrute(numberofQueens : in integer);
end assignment2stack;
