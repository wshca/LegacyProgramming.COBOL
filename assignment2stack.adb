-- Assignment 2: ADA Programming
-- 	Solving the 8-Queen's Puzzle
--  Created by:    Wolfgang Huettinger
--  Email:         
--  Date created:  February 11th 2013
--  Date modified: March 13th 2013
-- Assignment 2 - Stack ADT

with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
package body assignment2stack is
   type queens is array(1..8) of integer;
   queensLocation : queens;

   -- We use those arrays later in the stack
   type xdef is array (1..8) of integer;
   type adef is array (1..8) of boolean;
   type bdef is array (1..16) of boolean;
   type cdef is array (0..16) of boolean;

   -- Similar to the one stack found in the lecture notes
   type recqueensdef is
      record
         x : xdef;
         a : adef;
         b : bdef;
         c : cdef;
         i : integer;
         q : boolean;
      end record;
   recqueens : recqueensdef; -- declare a variable with the stack type

   -- set the first queen in the first line (numberofQueens possibilities)
   procedure setuptheQueen(numberofQueens : in integer; currentPosition : in integer; selection : in integer) is
      i : integer;
   begin
      i := 0;
      if (selection = 0) then
         queensLocation(1) := currentposition;
      elsif (selection = 1) then
         assignment2stack.recursivepresetting(numberofQueens);
         recqueens.x(1) := currentposition;
         for j in 1..numberofQueens loop
            recqueens.a(j) := false;
            recqueens.b(1+j) := false;
            recqueens.c((1+7)-j) := false;
         end loop;
      end if;
   end setuptheQueen;

   -- Preset the record containing the global variables for the recursive algorithm
   procedure recursivepresetting(numberofQueens : in integer) is
      i : integer;
      begin
         i := 1;
         for i in 1 .. numberofQueens loop
            recqueens.a(i) := true;
            queensLocation(i) := 0;
         end loop;
         for i in 1 .. 16 loop
            recqueens.b(i) := true;
         end loop;
         for i in 1..14 loop
            recqueens.c(i) := true;
         end loop;
         recqueens.i := 2;
   end recursivepresetting;

   -- Build recursive algorithm
   procedure brutealgorithm(numberofQueens : in integer; recursion : in out integer) is
          i,j : integer;
          legal : boolean;
       begin
          -- Default values setup
          i := 1;
          j := 1;
          -- Loop to go through the availabe positions and check if the current position is
          --  already covered by another queen if so, set the legal variable to false. Otherwise
          --  set it to true
          for j in 1 .. numberofQueens loop
             if (recursion > numberofQueens) then
                legal := false;
             else
                legal := true;
             end if;
             for i in 1 .. numberofQueens loop
                -- This position is void as its occupied by other queens
                if (queensLocation(i) = j) then
                   legal := false;
                end if;
                if (queensLocation(j) = recursion + (-i) + j) then
                   legal := false;
                end if;
                if (queensLocation(i) = recursion + i + (-j)) then
                   legal := false;
                end if;
                if (recursion > numberofQueens) then
                   legal := false;
                end if;

                if (legal=true) then
                  queensLocation(recursion) := j;
                  recursion := recursion+1;
                  brutealgorithm(numberofQueens, recursion);
                end if;
             end loop;
          end loop;
    end brutealgorithm;

    -- Taken from F92 interpretation of Wirth, Niklaus, Algorithms + Data Structures = Programs, Prentice-Hall (1976)
    procedure recursivealgorithm(numberofQueens : in integer; recursion : in integer; quit: in out boolean) is
          j : integer;
       begin
          j := 1;
          recqueens.i := recursion;
          for j in 1 .. numberofQueens loop -- make a for loop instead of the original do loop
          quit := false;
          if (recqueens.a(j) = true) then
             if (recqueens.b((recqueens.i)+j) = true) then
                 if (recqueens.c((recqueens.i+7)-j) = true) then
                      recqueens.x(recqueens.i) := j;
                      recqueens.a(j) := false;
                      recqueens.b((recqueens.i)+j) := false;
                      recqueens.c((recqueens.i+7)-j) := false;
                      if (recqueens.i < numberofQueens) then
                         -- call this function again
                         recursivealgorithm(numberofQueens, recqueens.i+1, quit);
                         if (quit = false) then
                            recqueens.a(j) := true;
                            recqueens.b((recqueens.i)+j) := true;
                            recqueens.c((recqueens.i+7)-j) := true;
                          end if;
                      else
                          quit := true;
                      end if;
                   end if; --end of .c loop
                end if; --end of .b loop
             end if; --end of .a loop
             -- Exit of loop condition have to hold, ie we found a solution or not
             if (quit = true) then
                assignment2stack.drawroutineBrute(numberofQueens);
                exit;
             end if;
             if (j = numberofQueens) then
                exit;
             end if;
          end loop; --end of the main loop which was the end of the do loop in the original
    end recursivealgorithm;

    -- Drawing the results after we are done
    procedure drawroutine(numberofQueens : in integer) is
          i,j : integer;
       begin
          i := 0;
          j := 0;
          for i in 1 .. numberofQueens loop
             -- write out the line
             for j in 1 .. numberofQueens loop
               if (j = queensLocation(i)) then
                  put("Q ");
               else
                  put(". ");
               end if;

             end loop; -- for j
             put_line("");
          end loop; -- for i
          put_line(""); -- write an empty line in the end
    end drawroutine;

    procedure drawroutineBrute(numberofQueens : in integer) is
         i,j : integer;
       begin
         i := 0;
         j := 0;
         for i in 1 .. numberofQueens loop
          for j in 1 .. numberofQueens loop
            if (recqueens.x(i) = j) then
               put("Q ");
               else
                  put(". ");
               end if;
            end loop; -- for j
            put_line("");
         end loop;
         put_line(""); -- write an empty line in the end
    end drawroutineBrute;

end assignment2stack;
