function [ ca_code_binary, ca_code_math, G2, G1 ] = CA_Code( PRN )
% Navigation Exercise 2 University of Stuttgart
%Worked By Karam MAWAS MTN(2946939)

% This function generates the G1 & G2 of the Satellites from 1-37 the PRN
% should be integer number.
% The G1 polynomyal:1+x^3+x^10 
% The G2 polynomyal:G2= 1+x^2+x^3+x^6+x^8+x^9+x^10
% To generate a C/A code for Satellite number 17 just type CA_Code(17) 

array_G1 = -ones(10,1);
array_new_G1 = array_G1;
G1=-ones(1023,1);

% Generating the code G1
% G1 = 1+x^3+x^10
for i=1:1022
    t = array_G1(3,1)*array_G1(10,1);
    array_new_G1(2:10,1)=array_G1(1:9,1);
    
    array_new_G1(1,1)=t;
    array_G1 = array_new_G1;
    G1(i+1)=array_G1(10,1);
end


% Generating the code G2
% G2= 1+x^2+x^3+x^6+x^8+x^9+x^10

% the sequence code of the satellites in the same order of the satellite'S
% num.
G2_sequence=[2 6;
             3 7;
             4 8;
             5 9;
             1 9;
             2 10;
             1 8;
             2 9;
             3 10;
             2 3;
             3 4;
             5 6;
             6 7;
             7 8;
             8 9;
             9 10;
             1 4;
             2 5;
             3 6
             4 7;
             5 8;
             6 9;
             1 3;
             4 6;
             5 7;
             6 8;
             7 9;
             8 10;
             1 6;
             2 7;
             3 8;
             4 9;
             5 10;
             4 10;
             1 7;
             2 8;
             4 10];

P = G2_sequence(PRN,:);
array_G2 = -ones(10,1);
array_new_G2 = array_G1;
G2=-ones(1023,1);
for i=1:1022
    u = array_G2(2,1)*array_G2(3,1)*array_G2(6,1)*array_G2(8,1)*array_G2(9,1)*array_G2(10,1);
    array_new_G2(2:10,1)=array_G2(1:9,1);
    array_new_G2(1,1)=u;
    array_G2 = array_new_G2;
    G2(i+1)=array_G2(P(1,1),1)*array_G2(P(1,2),1);
    
end
ca_code_math = G1.*G2;

% convert ca_code_math to Binary expression
ca_code_binary = ca_code_math;
for i=1:length(ca_code_binary);
    if ca_code_binary(i) == -1
       ca_code_binary(i)= 1;
    else
        ca_code_binary(i)= 0;
    end
end



end
