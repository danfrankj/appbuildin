%% params

audioFile = 'darkHorse.mp3';

outFile_orig = 'darkHorse.wav';
outFile_mod = 'darkHorse_modified.wav';

T_START = 0;
T_END = 120;

target_BPM = 150;

%% load libs

execDir = pwd;
sourcePath = fileparts(execDir); 
addpath(fullfile(sourcePath,'audio'))
addpath(fullfile(sourcePath,'mp3readwrite'))
addpath(fullfile(sourcePath,'vocoder'))

projectPath = fileparts(sourcePath);
mediaPath = fullfile(projectPath,'media');

%%

song = load_audio(fullfile(mediaPath,audioFile));
clip = truncate_audio(song, T_START, T_END);

[period, ~] = extract_beat(song, false);
BPM = 60/period;
fprintf('%s moves at %3.2f beats per minute \n', outFile_orig, BPM)
write_clip(clip, 0, fullfile(mediaPath,outFile_orig));

scaled_version = time_scale(clip, target_BPM/BPM);
[newPeriod, ~] = extract_beat(scaled_version, false);
fprintf('%s moves at %3.2f beats per minute \n', outFile_mod, 60/newPeriod)

write_clip(scaled_version, 0, fullfile(mediaPath,outFile_mod));