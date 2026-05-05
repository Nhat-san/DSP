clc;
clear;
// frequency range
w = linspace(-%pi, %pi, 1000);
// a) x1(n) = 0.1^n u(n)
X1 = 1 ./ (1 - 0.1 * exp(-%i*w));
amp1 = abs(X1);
phase1 = atan(imag(X1), real(X1));

// b) x2(n) = δ(n)+...+δ(n-3)
X2 = 1 + exp(-%i*w) + exp(-2*%i*w) + exp(-3*%i*w);
amp2 = abs(X2);
phase2 = atan(imag(X2), real(X2));

// Plot
figure();
// x1
subplot(2,2,1);
plot(w, amp1);
title('Amplitude x1(n)');
xlabel('ω'); ylabel('|X1(ω)|'); xgrid();

subplot(2,2,2);
plot(w, phase1);
title('Phase x1(n)');
xlabel('ω'); ylabel('Phase'); xgrid();

// x2
subplot(2,2,3);
plot(w, amp2);
title('Amplitude x2(n)');
xlabel('ω'); ylabel('|X2(ω)|'); xgrid();

subplot(2,2,4);
plot(w, phase2);
title('Phase x2(n)');
xlabel('ω'); ylabel('Phase'); xgrid();
