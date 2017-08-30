clear;
%Initializing vectors
%Latitude, longitude, and compass direction to be input as decimal degrees
seattleLat = 47.6593743;
seattleLong = -122.30262920000001;
compassDir = 90;
dipoleMag = 1;

%Sidereal day frequency
global omegaEarth = 2*pi*(1/86164.0916);

%Defining the X vector at January 1st 2000 00:00 UTC
%Using the website https://www.timeanddate.com/worldclock/sunearth.html
%At the time Mar 20 2000 07:35 UT
%80*24*3600 + 7*3600 + 35*60 = 6939300 seconds since January 1, 2000 00:00:00 UTC
%At the vernal equinox, longitude is equal to zero, so z=0;
global vernalEqLat = 68.1166667;

%Prepares seattleLat in terms of equatorial cordinates at January 1, 2000 00:00:00 UTC
%This is the angle of seattleLat from the X vector
seattleLat = rad2deg(deg2rad(seattleLat + vernalEqLat)-omegaEarth*6939300);

%Establish vernal equinox vector as basis
%Z direction of vernal equinox vector                       
Xz=0
%Parallel to vernal equinox vector
Xpar=-cos(deg2rad(vernalEqLat) - omegaEarth*6939300)
%Perpendicular to vernal equinox vector
Xperp=-sin(deg2rad(vernalEqLat) - omegaEarth*6939300)
%Vector is negative so that X has correct direction from sun to earth

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Signal creation

%Signal amplitude
Amp=10;

%Signal frequency
omegaComp = 2*pi*.01;

%Signal direction (decimal degrees)
rightAscension = 0;
declination = 0;

%Using above values makes the signal vector (unit vector)
Sz= cos(declination);
%Since there is a negative on Xpar, it must be taken inside the argument of cos, I use the identity -cos(x)=cos(pi-x)
Spar= sin(declination)*cos(pi-(deg2rad(vernalEqLat)-omegaEarth*6939300)+deg2rad(rightAscension));
%Again the negative had to be taken inside the arguement, using -sin(x)=sin(-x)
Sperp= sin(declination)*sin(-(deg2rad(vernalEqLat)-omegaEarth*6939300)+deg2rad(rightAscension));


%t=0 starts at January 1 2000, 00:00:00 UTC

%timeStart in seconds from January 1 2000, 00:00:00 UTC
timeStart = 0;

%timeEnd format same as timeStart
timeEnd = floor(86164.0916/10);

%Graphing
t=timeStart:timeEnd;
t= t';

%Creates array of dipole directions with the form [time, z component, perpendicular to X, parallel to X]
dV = [];
for i=1:length(t)
  dV = [dV; dipoleVec(i,seattleLat,seattleLong,compassDir,dipoleMag)];
endfor
%
%Creates array of signal directions with the same form
fS = [];
for j=1:length(t)
  fS = [fS; fakeSignal(j,Amp, omegaComp, Sz, Spar, Sperp)];
endfor
%
%Constructs matrix of [time, magnitude of impulse on dipole]
out = [];
for k=1:length(t)
out = [out; k,dot(dV(k,2:4),fS(k,2:4))+randn(1)*50];
endfor
%
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

%Original data with random noise
plot(out(:,1),out(:,2));

figure(2);
%Linear fit
plot(t,X*beta);

