function write_clip(clip, DUR_SKIP, filename)

start = 1 + floor(DUR_SKIP*clip.SampleRate);

wavwrite(clip.UserData(start:end), ...
         clip.SampleRate, ...
         clip.BitsPerSample, ...
         filename);

disp(['wrote to ' filename])