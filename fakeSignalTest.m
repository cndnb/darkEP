clear;
%Initializing vectors
seattleLat = 0;
seattleLong = 0;
compassDir = 0;
dipoleMag = 1;
                         
A=1;
B=1;
C=1;
Amp=10;
omegaComp = 2*pi*100;

t=1:31536000; t= t';
[d1, d2, d3] = dipoleVec(1,seattleLat,seattleLong,compassDir,dipoleMag)
[fS1, fS2, fS3] = fakeSignal(1,Amp,omegaComp,A,B,C)

plot(t,dot(d(t),fS(t)));

