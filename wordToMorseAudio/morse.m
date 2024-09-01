clear all;
close all;
clc;

% Set frequency 

freq = 2000;

sampling = 32000;

dotTimePeriod = 0.1; 
dotSamples = sampling * dotTimePeriod;
dotTime = (1:dotSamples)/sampling;
dotWave = cos(2*pi*freq*dotTime);

dashTimePeriod = 0.2;
dashSamples = sampling * dashTimePeriod;
dashTime = (1:dashSamples)/sampling;
dashWave = cos(2*pi*freq*dashTime);

spaceTimePeriod = 0.3;
spaceSamples = sampling * spaceTimePeriod;
spaceTime = (1:spaceSamples)/sampling;
spaceWave = cos(2*pi*1*spaceTime);

intervalTimePeriod = 0.1;
intervalSamples = sampling * intervalTimePeriod;
intervalTime = (1:intervalSamples)/sampling;
intervalWave = cos(2*pi*1e-6*intervalTime);

%% Word to Morsecode

% Morse code lookup table
morseCodeMap = containers.Map(...
    {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', ...
     'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', ...
     '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', ' '}, ...
    {'.-', '-...', '-.-.', '-..', '.', '..-.', '--.', '....', '..', '.---', ...
     '-.-', '.-..', '--', '-.', '---', '.--.', '--.-', '.-.', '...', '-', ...
     '..-', '...-', '.--', '-..-', '-.--', '--..', '.----', '..---', '...--', ...
     '....-', '.....', '-....', '--...', '---..', '----.', '-----', '/'});

% Get input sentence from the user
inputSentence = upper(input('Enter a sentence: ', 's'));

% Convert the input sentence to Morse code
word = '';  % Initialize the Morse code string
for i = 1:length(inputSentence)
    char = inputSentence(i);
    if isKey(morseCodeMap, char)
        word = [word, morseCodeMap(char), ' '];  % Append Morse code and a space
    end
end

disp(['Morse Code: ', word]);

%% Encoder
wave = [];

for x = 1:length(word)
    char = word(x);
    
    if char == "."
        wave = [wave, dotWave,intervalWave];
    elseif char == "-"
        wave = [wave, dashWave,intervalWave];
    elseif char == " "
        wave = [wave, intervalWave,intervalWave];
    elseif char == "/"
        wave = [wave, spaceWave];
    end
end

%sound(wave,sampling);
filename = 'sound.wav';
audiowrite(filename,wave,sampling);
