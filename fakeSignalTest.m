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
omegaEarth = 2*pi*(1/86164.0916);

t=1:floor(86165/10);%31536000; 
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
out = [out; k,dot(dV(k,2:4),fS(k,2:4))+randn(1)*50];
endfor
%Creates design matrix for ols fit
X = ones(length(t),6);
X(:,1)= sin(omegaComp*t).*sin(omegaEarth*t);
X(:,2)= sin(omegaComp*t).*cos(omegaEarth*t);
X(:,3)= cos(omegaComp*t).*sin(omegaEarth*t);
X(:,4)= cos(omegaComp*t).*cos(omegaEarth*t);
X(:,5)= sin(omegaComp*t);
X(:,6)= cos(omegaComp*t);
%Ols output
[beta, sigma, r, err, cov] = ols2(out(:,2),X);
%Plot!
figure(1);

%Original data
plot(out(:,1),out(:,2));

figure(2);
%Linear fit
plot(t,X*beta);

