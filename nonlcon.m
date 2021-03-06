function [c, ceq ] = nonlcon(input)
%IEQULCON Summary of this function goes here
%   Detailed explanation goes here

global a h1 l1 l2 dp dl lf1 lf2;
global v1 v2 v3 p1 p2 p3;

% % global theta1 theta2 theta3 theta4 theta5 theta6 theta7 d;
    theta1 = input(1);
    theta2 = input(2);
    theta3 = input(3);
    theta4 = input(4);
    theta5 = input(5);
    theta6 = input(6);
    theta7 = input(7);
    d      = input(8);
    t1     = input(9);
    t2     = input(10);
    t3     = input(11);

T01=[cos(theta1)  -sin(theta1)   0     0 ;
     sin(theta1)  cos(theta1)    0     0; 
     0            0              1     h1; 
     0            0              0     1]; 
 
 
T12=[cos(theta2)  -sin(theta2)   0     l1 ;
     sin(theta2)  cos(theta2)    0     0; 
     0            0              1     0; 
     0            0              0     1];
 
T23=[1  0   0     l2;
     0  1   0     0; 
     0  0   1     0; 
     0  0   0     1];
 

T34=[cos(theta3)  -sin(theta3)   0     0 ;
     sin(theta3)  cos(theta3)    0     0; 
     0            0              1     d; 
     0            0              0     1]; 
 

%finger 1
T451=[sin(theta4)  -cos(theta4)   0     dp ;
      cos(theta4)  sin(theta4)    0     0; 
      0            0              1     0; 
      0            0              0     1]; 

T561=[cos(theta5)   sin(theta5)   0     dl ;
      0             0             -1    0; 
      -sin(theta5)  cos(theta5)   0     0; 
      0             0             0     1]; 

T671=[cos(a*theta5-pi/4)  -sin(a*theta5-pi/4)   0     lf1 ;
      sin(a*theta5-pi/4)  cos(a*theta5-pi/4)    0     0; 
      0              0                1     0; 
      0              0                0     1];

%finger 2
T452=[-sin(theta4)  -cos(theta4)   0     -dp ;
      cos(theta4)  -sin(theta4)    0     0; 
      0            0               1     0; 
      0            0               0     1]; 

T562=[cos(theta6)   sin(theta6)   0     dl ;
      0             0             -1    0; 
      -sin(theta6)  cos(theta6)   0     0; 
      0             0             0     1];  
  
T672=[cos(a*theta6-pi/4)  -sin(a*theta6-pi/4)   0     lf1 ;
      sin(a*theta6-pi/4)  cos(a*theta6-pi/4)    0     0; 
      0              0                1     0; 
      0              0                0     1];
  
%finger 3  
T453=[0    1   0     0;
      -1   0   0     0; 
      0    0   1     0; 
      0    0   0     1];  

T563=[cos(theta7)   sin(theta7)   0     dl;
      0             0             -1    0; 
      -sin(theta7)  cos(theta7)   0     0; 
      0             0             0     1];  
  
T673=[cos(a*theta7-pi/4)  -sin(a*theta7-pi/4)   0     lf1 ;
      sin(a*theta7-pi/4)  cos(a*theta7-pi/4)    0     0; 
      0              0                1     0; 
      0              0                0     1];
  
P0=[0; 0; 0;1];
P=[lf2;0;0;1];  

P71=T01*T12*T23*T34*T451*T561*T671*P0;
P712=T01*T12*T23*T34*T451*T561*T671*P;
P72=T01*T12*T23*T34*T452*T562*T672*P0;
P722=T01*T12*T23*T34*T452*T562*T672*P;
P73=T01*T12*T23*T34*T453*T563*T673*P0;
P732=T01*T12*T23*T34*T453*T563*T673*P;



T=[0 -1 0 0 ; 1 0 0 0 ; 0 0 1 0; 0 0 0 1];
Pp3=T01*T12*T23*T34*T453*T563*T673*T*[0.05; 0;0;0];
Pp2=T01*T12*T23*T34*T452*T562*T672*T*[0.05; 0;0;0];
Pp1=T01*T12*T23*T34*T451*T561*T671*T*[0.05; 0;0;0];


c(1)=-(Pp1(1)*v1(1)+Pp1(2)*v1(2)+Pp1(3)*v1(3)); 
c(2)=-(Pp2(1)*v2(1)+Pp2(2)*v2(2)+Pp2(3)*v2(3)); 
c(3)=-(Pp3(1)*v3(1)+Pp3(2)*v3(2)+Pp3(3)*v3(3)); 

ceq(1)=Pp1(2)*v1(3)-Pp1(3)*v1(2);
ceq(2)=Pp1(1)*v1(3)-Pp1(3)*v1(1);
ceq(3)=Pp1(1)*v1(2)-Pp1(2)*v1(1);

ceq(4)=Pp2(2)*v2(3)-Pp2(3)*v2(2);
ceq(5)=Pp2(1)*v2(3)-Pp2(3)*v2(1);
ceq(6)=Pp2(1)*v2(2)-Pp2(2)*v2(1);

ceq(7)=Pp3(2)*v3(3)-Pp3(3)*v3(2);
ceq(8)=Pp3(1)*v3(3)-Pp3(3)*v3(1);
ceq(9)=Pp3(1)*v3(2)-Pp3(2)*v3(1);

ceq(10)=norm(t1 * P71 + (1-t1) * P712 - p1');
ceq(11)=norm(t2 * P72 + (1-t2) * P722 - p2');
ceq(12)=norm(t3 * P73 + (1-t3) * P732 - p3');
end

