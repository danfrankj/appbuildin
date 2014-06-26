function R = get_rms(x, winLength)

ysquared = x.^2;
win = rectwin(winLength);
R = conv(ysquared, win, 'same');
R = sqrt(R)/sqrt(winLength);