function outClip = time_scale(clip, frac)

nfft = 2^nextpow2(clip.SampleRate/50);
y = pvoc(clip.UserData, frac, nfft);

outClip = audioplayer(y, ... 
                   clip.SampleRate, ...
                   clip.BitsPerSample);
               
outClip.UserData = y; 