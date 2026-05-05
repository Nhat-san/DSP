clc;
clear;
// frequency
w = linspace(-%pi, %pi, 1000);
// H(w)
H = 1 ./ (1 + 0.1*exp(-%i*w) + 0.2*exp(-2*%i*w));
// amplitude & phase
amp = abs(H);
phase = atan(imag(H), real(H));
// plot amplitude
subplot(2,1,1);
plot(w, amp);
xlabel('ω'); ylabel('|H(ω)|');
title('Amplitude Spectrum');
xgrid();
// plot phase
subplot(2,1,2);
plot(w, phase);
xlabel('ω'); ylabel('Phase');
title('Phase Spectrum');
xgrid();
