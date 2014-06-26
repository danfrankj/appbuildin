function [period, phaze] = findBeatsFast(x, dT)
% function [period, phaze] = findBeatsFast(x, dT)

maxlags = ceil(3/dT);
[acf,lags] = autocorr(x, maxlags);

weights = exp(-0.5*(log10(1:maxlags).' - log10(0.6/dT)).^2 / 0.2);

weighted_acf = acf.*[0; weights];
[~, max_ind] = max(weighted_acf);
period = lags(max_ind);

N = length(x);
numPeriods = floor(N/period);
phaseCorrs = zeros(period,1);
for delay = 1:(period-1)
    idx1 =  delay:period:((numPeriods-2)*period+delay);
    idx2 = idx1 + period;
    phaseCorrs(delay) = sum( x(idx1) .* x(idx2) );
end
[~, phaze] = max(phaseCorrs);