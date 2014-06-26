audioFile = 'darkHorse.mp3';

%% load libs

execDir = pwd;
sourcePath = fileparts(execDir); 
addpath(fullfile(sourcePath,'audio'))
addpath(fullfile(sourcePath,'mp3readwrite'))

projectPath = fileparts(sourcePath);
mediaPath = fullfile(projectPath,'media');

%%

myClip = load_audio(fullfile(mediaPath,audioFile));


%%
