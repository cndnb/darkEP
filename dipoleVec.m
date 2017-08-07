1;
function [A,B,C] = dipoleVec(t, seattleLat, seattleLong, compassDir, dM)
  omegaEarth = 2*pi*86164.0916;
  A = dM*cos(compassDir)*cos(seattleLong);
  B = dM*sin(compassDir)*sin(seattleLat + omegaEarth*t);
  C = dM*sin(compassDir)*cos(seattleLong+ omegaEarth*t);
endfunction