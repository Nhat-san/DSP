File = "D:/HCMUT/Digital Signal Processing/Lab/Lab4/drums.wav";
y = wavread(File);
playsnd(y);
clf
subplot(2,1,1)
plot2d(y(1,:)) // first channel
subplot(2,1,2)
plot2d(y(2,:)) // second channel
