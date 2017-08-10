%Constructs a time dependent Seattle dipole vector
function ret = dipoleVec(t, seattleLat, seattleLong, compassDir, dM)
  omegaEarth = 2*pi*(1/86164.0916);
  A = tones(length(t),1).*dM*cos(compassDir)*cos(seattleLong);
  B = dM*sin(compassDir)*sin(seattleLat + omegaEarth.*t);
  C = dM*sin(compassDir)*cos(seattleLong+ omegaEarth.*t);
  ret = [t, A, B, C];
endfunction