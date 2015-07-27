-- Assignment 2: ADA Programming
-- 	Solving the 8-Queen's Puzzle
--  Created by:    Wolfgang Huettinger
--  Email:         
--  Date created:  February 11th 2013
--  Date modified: March 13th 2013
-- Assignment 2 - Main program

with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
--Declaring math library to use math functions i.e. sqrt(x)
-- with Ada.Numerics.Elementary_Functions use Ada.Numerics.Elementary_Functions;
with assignment2stack; use assignment2stack;
procedure assignment2 is
    numberofQueens, recursion, selection, currentPosition : integer;
    quit : boolean;
begin
    numberofQueens := 8;
    recursion := 1;
    currentPosition := 1;
    quit := false;

    put_line("What version do you want to execute?");
    put_line("   0: brute force algorithm");
    put_line("   1: recursive algorithm");
    put("Your selection: ");
    get(selection);
    for currentPosition in 1 .. numberofQueens loop
       assignment2stack.setuptheQueen(numberofQueens,currentPosition,selection);
       if (selection=0) then
          assignment2stack.brutealgorithm(numberofQueens, recursion);
          assignment2stack.drawroutine(numberofQueens);
       elsif (selection=1) then
          assignment2stack.recursivealgorithm(numberofQueens, recursion, quit);
          assignment2stack.drawroutineBrute(numberofQueens);
       else
          put_line("Invalid selection");
    end if;
end loop;

end assignment2;
