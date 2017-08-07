%Constructs time dependent vector
function [v1, v2, v3] = fakeSignal (t, Amp, omegaComp, A, B, C)
  v1 = Amp*exp(i*omegaComp*t)*A;
  v2 = Amp*exp(i*omegaComp*t)*B;
  v3 = Amp*exp(i*omegaComp*t)*C;
endfunction