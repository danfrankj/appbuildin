audioFile = 'darkHorse.mp3';

% time region to examine
T_START = -inf; 
T_END = inf;

%% load libs

execDir = pwd;
sourcePath = fileparts(execDir); 
addpath(fullfile(sourcePath,'audio'))
addpath(fullfile(sourcePath,'mp3readwrite'))

projectPath = fileparts(sourcePath);
mediaPath = fullfile(projectPath,'media');

%% analyze audio

song = load_audio(fullfile(mediaPath,audioFile));
clip = truncate_audio(song, T_START, T_END);

[period, phaze] = extract_beat(clip);
BPM = 2*60/period;

fprintf('%s moves at %3.2f beats per minute \n', audioFile, BPM)
