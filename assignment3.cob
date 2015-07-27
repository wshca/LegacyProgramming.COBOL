*> Assignment 3 : Cobol
*>     RE-ENGINEERING A TEXT ANALYZER
*> 
*> Student Name:   Wolfgang Huettinger
*> Student ID:     
*> Student Email:  
*>
*> Date created:   13 March 2013
*> Date modified:  31 March 2013
*>
identification division.
program-id. text-stats.

environment division.
input-output section.
file-control.
select input-file assign to filevariable
organization is line sequential.
select output-file assign to "OUT.TXT"
organization is line sequential.

data division.
file section.
fd input-file.
01 sample-input      pic x(480).
fd output-file. 
01 output-line       pic x(480).

working-storage section.
77  eof-switch       pic 9 value 1.
77  exit-switch      pic 9.
01  no-of-sentences  pic s9(7)    comp.
01  no-of-words      pic s9(7)    comp.
01  no-of-characters pic s9(7)    comp.
01  no-of-numbers    pic s9(7)    comp.
01  isnumber	     pic s9(7)    comp.
01  charindex        pic s9(4)    comp.  
77  filevariable     pic x(20) value 'testdatvar'.
01  input-area.
    02 line1         pic x occurs 480 times.
01  output-title-line.
    02  filler       pic x(31)    value spaces.
    02  filler       pic x(19)    value "Input text analyzed".
01 output-underline.
    02  filler       pic x(41)    
      value " ----------------------------------------".
    02  filler       pic x(40)    
      value "----------------------------------------".
01 output-area.
    02  filler pic x value space.
    02  out-line     pic x(80).
01 output-statistics-line-1.
    02  filler pic x(20)    value spaces.
    02  filler pic x(34)    value "Number of Sentences =".
    02  out-no-senten pic -(7)9.
01 output-statistics-line-2.
    02  filler pic x(20)    value spaces.
    02  filler pic x(34)    value "Number of Words =".
    02  out-no-word  pic -(7)9.
01 output-statistics-line-3.
    02  filler pic x(20)    value spaces.
    02  filler pic x(34)    value "Number of Chars =".
    02  out-no-char  pic -(7)9.
01 output-statistics-line-4.
    02  filler pic x(20)    value spaces.
    02  filler pic x(34)    value "Number of Numbers =".
    02  out-no-numbers  pic -(7)9.
01 output-statistics-line-5.
    02  filler pic x(20)    value spaces.
    02  filler pic x(34)    
      value "Average number of Words/Sentence =".
    02  aver-words-se pic -(4)9.9(2).
01 output-statistics-line-6.
    02  filler pic x(20)    value spaces.
    02  filler pic x(34)    
      value "Average number of Symbols/Word =".
    02  aver-char-wor pic -(4)9.9(2).


procedure division.
open output output-file.
move 2 to exit-switch.
perform proc-body until exit-switch is equal to 2.

proc-body.
*> Request user input to dynamically load the file
display "Please enter file name to be analyzed: ".
accept filevariable from console.
open input input-file.
move 0 to isnumber

move zeroes to no-of-sentences, no-of-words, no-of-characters, no-of-numbers.
move 481 to charindex.
write output-line from output-title-line after advancing 0 lines.
write output-line from output-underline after advancing 1 line.
move 2 to exit-switch.
perform outer-loop until exit-switch is equal to zero.

outer-loop.
read input-file into input-area at end perform end-of-job.
move input-area to out-line.
write output-line from output-area after advancing 1 line.
subtract 480 from charindex.
perform new-sentence-proc until exit-switch is equal to zero 
 or charindex is greater than 480.

new-sentence-proc.
move 2 to exit-switch.
if line1(charindex) is not equal to "/" 
    perform process-loop
    until charindex is greater than 480 or exit-switch is less than 2
else perform output-statistics-proc.

output-statistics-proc.
move no-of-sentences to out-no-senten.
move no-of-words to out-no-word.
move no-of-characters to out-no-char.
move no-of-numbers to out-no-numbers.
move isnumber to out-no-numbers.

divide no-of-sentences into no-of-words
    giving aver-words-se rounded.
divide no-of-words into no-of-characters
    giving aver-char-wor rounded.
write output-line from output-underline after advancing 1 line.
write output-line from output-statistics-line-1 after advancing 1 line.
write output-line from output-statistics-line-2 after advancing 1 line.
write output-line from output-statistics-line-3 after advancing 1 line.
write output-line from output-statistics-line-4 after advancing 1 line.
write output-line from output-statistics-line-5 after advancing 1 line.
write output-line from output-statistics-line-6 after advancing 1 line.
write output-line from output-underline after advancing 1 line.
move zero to exit-switch.

process-loop.
if line1(charindex) is equal to space
   add 1 to no-of-words
   add 1 to charindex
else if line1(charindex) is not equal to "."
   add 1 to charindex
      if line1(charindex) is not equal to "," 
         if line1(charindex) is not equal to ";" 
            if line1(charindex) is not equal to "-"
*> Case statements to reduce clutter 
               evaluate true
               when line1(charindex) = "0" 
                  add 1 to isnumber   
               when line1(charindex) = "1"
                  add 1 to isnumber
               when line1(charindex) = "2" 
                  add 1 to isnumber   
               when line1(charindex) = "3"
                  add 1 to isnumber   
               when line1(charindex) = "4"
                  add 1 to isnumber  
               when line1(charindex) = "5"
                  add 1 to isnumber   
               when line1(charindex) = "6"
                  add 1 to isnumber
               when line1(charindex) = "7"
                  add 1 to isnumber  
               when line1(charindex) = "8"
                  add 1 to isnumber
               when line1(charindex) = "9"
                  add 1 to isnumber                 
               when other add 1 to no-of-characters
               end-evaluate	
            else
               next sentence
         else
            next sentence
      else next sentence
else add 1 to no-of-sentences
   add 1 to no-of-words
   add 3 to charindex
   move 1 to exit-switch.

end-of-job.  
close input-file, output-file.

stop run.
