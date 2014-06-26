function clip = truncate_audio(song, T_START, T_END)


clipStart = max(0, floor((T_START)*song.SampleRate)) + 1;
clipEnd = min(song.TotalSamples, floor((T_END)*song.SampleRate) + 1);


clip = audioplayer(song.UserData(clipStart:clipEnd), ...
                   song.SampleRate, ...
                   song.BitsPerSample);
               
clip.UserData = song.UserData(clipStart:clipEnd);