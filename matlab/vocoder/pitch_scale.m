function outClip = pitch_scale(clip, P, Q)
% function outClip = pitch_scale(clip, P, Q)

y = pvoc(clip.UserData, P / Q);
z = resample(y, P, Q);

outClip = audioplayer(z, ... 
                   clip.SampleRate, ...
                   clip.BitsPerSample);
               
outClip.UserData = z; 