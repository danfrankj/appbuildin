function [period, phaze] = findBeatsFast(x, dT)
% function [period, phaze] = findBeatsFast(x, dT)

maxlags = ceil(3/dT);
[acf,lags] = autocorr(x, maxlags);

mu = 0.5; %expect 120 bpm
sigma = 0.1;
weights = exp(-0.5*(log10(1:maxlags).' - log10(mu/dT)).^2 / sigma);

weighted_acf = acf.*[0; weights];
[max_corr, max_ind] = max(weighted_acf);
period = lags(max_ind);

%% plot
figure;
semilogx(60./(dT*lags), weighted_acf, ...
         60./(dT*(1:maxlags)), weights, 'k--')
hold on; 
semilogx(60/(period*dT), max_corr, 'ro'); hold off
xlim( [60/maxlags/dT, 300] )
xlabel('Frequency (BPM)')
ylabel('weighted ACF')
set(gca, 'xtick', 5:15:300)
%%

N = length(x);
numPeriods = floor(N/period);
phaseCorrs = zeros(period,1);
for delay = 1:(period-1)
    idx1 =  delay:period:((numPeriods-2)*period+delay);
    idx2 = idx1 + period;
    phaseCorrs(delay) = sum( x(idx1) .* x(idx2) );
end
[~, phaze] = max(phaseCorrs);

period = period*dT;
phaze = phaze*dT;