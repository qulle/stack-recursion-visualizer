-- Author: Qulle 2017-10-01
-- Github: github.com/qulle/stack-recursion-visualizer
-- Editor: vscode (initially emacs)
-- Compile: gnatmake ./stack_recursion.adb
-- Run: ./stack_recursion

with Ada.Text_IO, Ada.Integer_Text_IO;
use  Ada.Text_IO, Ada.Integer_Text_IO;

procedure Stack_Recursion is
    function Factorial(N : in Natural) return Positive is
    begin
        if N <= 1 then
            return 1;
        end if;
      
        return N * Factorial(N - 1);      
   end Factorial;
   
   procedure Spinner(Num : in Natural) is
        S : String := "\|/-";
   begin
        Put(Ascii.Esc & "[s"); 
        for N in 1 .. 2 loop
            for I in 1 .. 4 loop
                Put(Ascii.Esc & "[2K" & Ascii.Esc & "[u");
                Put(Num, Width => 0);
                Put("! = [" & S(I) & ']');
                delay 0.1;
            end loop;
        end loop;
    end Spinner;
   
    procedure Print_Space(Len : in Natural) is
    begin
        for I in 0 .. Len loop
            Put(' ');
        end loop;
    end Print_Space;
   
    procedure Print_Row(S1 : in String; N1 : in Natural; S2 : in String; N2 : in Natural; S3 : in String) is
        Stack_Frame_Width : constant Positive := 36;
    begin
        Put("| |");
        Put(S1);
        Put(N1, Width => 0);
        Put(S2);
      
        if N2 < Integer'Last then
            Put(N2, Width => 0);
        end if;
      
        Put(S3);
      
        if S2'Length = 1 then
            Print_Space(((Stack_Frame_Width - S1'Length) - S2'Length) - Integer'Image(N1)'Length);
        else
            Print_Space((((((Stack_Frame_Width - S1'Length) - S2'Length) - S3'Length) - (Integer'Image(N1)'Length - 1)) - (Integer'Image(N2)'Length - 1)) - 1);
        end if;
      
        Put_Line("| |");
    end Print_Row;

    procedure Build_Stack(Size : in Natural) is
        N : Integer := 0;
    begin
        for A in 1 .. Size loop
     
            Put_Line("+-----------------STACK------------------+");
     
            for B in 1 .. A loop
                N := (Size - A) + B;        
                Put_Line("| +------------------------------------+ |");
                Print_Row("    factorial(", N, ")", Integer'Last, "");
                Print_Row("    n = ", N, " ", Integer'Last, "");
        
                if(N > 1) then
                    Print_Row(" return ", N, " * factorial(", N - 1, ");");      
                else
                    Put_Line("| | return 1;                          | |");
                end if;

                Put_Line("| +------------------------------------+ |");
            end loop;
     
            Put_Line("+----------------------------------------+");
     
            Spinner(N);
            New_Line(100); 
        end loop;
    end Build_Stack;
   
    procedure Remove_Stack(Size : in Natural) is
        N, Fac : Integer := 0;
    begin
        for A in reverse 1 .. Size - 1 loop
     
            Put_Line("+-----------------STACK------------------+");
     
            for B in 1 .. A loop
                N := (Size - A) + B;
                Fac := Factorial(N - 1);
        
                Put_Line("| +------------------------------------+ |");
                Print_Row("    factorial(", N, ")", Integer'Last, "");
        
                Print_Row("    n = ", N, " ", Integer'Last, "");
        
                if(B = 1) then
                    Print_Row(" return ", N, " * ", Fac, ";");
                else
                    Print_Row(" return ", N, " * factorial(", N - 1, ");");
                end if;
        
                Put_Line("| +------------------------------------+ |");
            end loop;
     
            Put_Line("+----------------------------------------+");
     
            Spinner(N);
            New_Line(100);
        end loop;
    end Remove_Stack;
   
    Num : Natural := 0;
begin
    Put("Enter factorial to solve: ");
    Get(Num);

    New_Line(100);
    Build_Stack(Num);
   
    New_Line(100);
    Remove_Stack(Num);
   
    Put(Num, Width => 0);
    Put("! = ");
    Put(Factorial(Num), Width => 0);
end Stack_Recursion;