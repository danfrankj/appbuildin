function myClip = load_audio(file)
% function myClip = load_audio(file)

[Y, FS, NBITS] = mp3read(file);

myClip = audioplayer(Y, FS, NBITS);

myClip.UserData = mean(Y,2); %average channels

disp(['Loaded ' file])