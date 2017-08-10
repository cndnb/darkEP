%Constructs time dependent fake signal vector
function ret = fakeSignal (t, Amp, omegaComp, A, B, C)
  v1 = Amp*(cos(omegaComp*t)+i*sin(omegaComp*t))*A;%exp(i*omegaComp*t)*A;
  v2 = Amp*(cos(omegaComp*t)+i*sin(omegaComp*t))*B;%exp(i*omegaComp*t)*B;
  v3 = Amp*(cos(omegaComp*t)+i*sin(omegaComp*t))*C;%exp(i*omegaComp*t)*C;
  ret = [t, v1, v2, v3];
endfunction