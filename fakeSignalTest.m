clear;
%Initializing vectors
seattleLat = 0;
seattleLong = 0;
compassDir = pi/2;
dipoleMag = 1;
                         
A=0;
B=1;
C=1;
Amp=10;
omegaComp = 2*pi*.01;

t=1:86165/5;%31536000; 
t= t';
dV = [];
for i=1:length(t)
  dV = [dV; dipoleVec(i,seattleLat,seattleLong,compassDir,dipoleMag)];
endfor
fS = [];
for j=1:length(t)
  fS = [fS; fakeSignal(j,Amp, omegaComp, A, B, C)];
endfor
%Constructs matrix for plotting
out = [];
for k=1:length(t)
out = [out; k,dot(dV(k,2:4),fS(k,2:4))];
endfor
%Plot!
plot(out(:,1),out(:,2));

