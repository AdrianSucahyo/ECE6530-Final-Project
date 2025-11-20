function xx = dtmfdial(keyNames,fs)
%DTMFDIAL Create a signal vector of tones which will dial
% a DTMF (Touch Tone) telephone system.
%
% usage: xx = dtmfdial(keyNames,fs)
% keyNames = vector of characters containing valid key names
% fs = sampling frequency
% xx = signal vector that is the concatenation of DTMF tones.
%
dtmf.keys = ...
['1','2','3','A';
'4','5','6','B';
'7','8','9','C';
'*','0','#','D'];

dtmf.colTones = ones(4,1)*[1209,1336,1477,1633];
dtmf.rowTones = [697;770;852;941]*ones(1,4);

% Define parameters
t = 0:1/fs:0.2 - 1/fs; % Sampling values for sinusoids 0.20s long.
delay = zeros(1, 0.05*fs); % Delay that will be added between each dial tone 0.05s long.


xx = []; % Create an arrray to hold our final output dialtones.
for key = keyNames

    if ~(key == dtmf.keys)
        error('Invalid DTMF key: %s', key);
    end

    [rowFreq, colFreq] = find(key==dtmf.keys); % Find the row and col location for the frequency values.

    % Allowed for them to show, just for testing purposes
    fRow = dtmf.rowTones(rowFreq, colFreq) % Find the row and col frequencies
    fCol = dtmf.colTones(rowFreq, colFreq)

    dualtones = sin(2*pi* fRow .* t) + sin(2*pi* fCol .* t); % Sampled sinusoids summed together to create the dual tone signal.
    xx = [xx, dualtones, delay]; % Concatenate the dualt ones with a delay between tones.
end

end