function hh = dtmfdesign(fb, L, fs)
%DTMFDESIGN
% hh = dtmfdesign(fb, L, fs)
% returns a matrix (L by length(fb)) where each column contains
% the impulse response of a BPF, one for each frequency in fb
% fb = vector of center frequencies
% L = length of FIR bandpass filters
% fs = sampling freq
%
% Each BPF must be scaled so that its frequency response has a
% maximum magnitude equal to one

% So to start, I'll define the filter 'h'
n = 0:L-1; % Define inters for hte length of the FIR bandpass Filter

hh = []; % Initialize
for freq = fb

    h = cos(2*pi*freq/fs .*n); % Create unscaled BPF

    [H, ~] = freqz(h, 1); % Take the frequency response of the BPF

    beta = 1/max(abs(H)); % Scale the magnitude by beta so that we get a maximum value of 1

    h_scaled = beta*h; % Scale BPF by beta to get a maximum magnitude of 1.

    hh = [hh, h_scaled(:)]; % Make sure each filter is added as a column
end

end
