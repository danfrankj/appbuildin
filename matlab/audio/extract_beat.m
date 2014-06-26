function [period, phaze] = extract_beat2(clip, PLOT_FLAG)
% function [period, phase] = extract_beat2(song, PLOT_FLAG)

if nargin<2
    PLOT_FLAG = true;
end

[hfc, T] = get_hfc(clip, 0.01, 0.005);
dT = T(2)-T(1);

deriv = get_deriv(hfc, 4);
env = get_rms(deriv, round(0.05/dT));

DET_FUN = hfc;

[period, phaze] = findBeatsFast(DET_FUN, dT);

FACTOR = 1;
if PLOT_FLAG
    figure;
    tempo = cos(2*pi*((1:length(DET_FUN)) - phaze/FACTOR)/(period/FACTOR));
    plot(T,0.5*tempo,T,DET_FUN/max(DET_FUN))
end

period = period*dT;
phaze = phaze*dT;

