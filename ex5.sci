clc;
clear;
// frequency
w = linspace(-%pi, %pi, 1000);
// Y(w)
Y = (1 + exp(-%i*w)) ./ (1 - 0.5*exp(-%i*w));
// amplitude & phase
amp = abs(Y);
phase = atan(imag(Y), real(Y));
// plot amplitude
subplot(2,1,1);
plot(w, amp);
xlabel('ω'); ylabel('|Y(ω)|');
title('Amplitude Spectrum');
xgrid();
// plot phase
subplot(2,1,2);
plot(w, phase);
xlabel('ω'); ylabel('Phase');
title('Phase Spectrum');
xgrid();
