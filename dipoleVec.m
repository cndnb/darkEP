%Constructs a time dependent Seattle dipole vector
function ret = dipoleVec(t, seattleLat, seattleLong, compassDir, dM)
  oE = 2*pi*(1/86164.0916);
  A = ones(length(t),1).*dM*cos(compassDir)*cos(seattleLong);
  B = dM*sin(compassDir)*sin(seattleLat + oE.*t);
  C = dM*sin(compassDir)*cos(seattleLong+ oE.*t);
  ret = [t, A, B, C];
endfunction