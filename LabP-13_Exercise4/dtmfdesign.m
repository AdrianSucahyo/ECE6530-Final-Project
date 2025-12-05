% DTMFDESIGN returns a matrix (L by length(fb)) where each column contains
% the impulse response of a BPF, one for each frequency in fb
% 
% fb = vector of center frequencies
% L = length of FIR bandpass filters
% fs = sampling freq
%
% Each BPF must be scaled so that its frequency response has a maximum
% magnitude equal to one

function hh = dtmfdesign(fb, L, fs)
    % Define integers for the length of the FIR bandpass Filter
    n = 0: L-1;
    
    % Initialize output response vector
    hh = [];
    
    % Compute the filters for all frequencies in fb
    for freq = fb
        
        % Create unscaled Bandpass Filter
        h = cos(2*pi*freq/fs .*n);
        
        % Generate the frequency response for the filter
        % Note: h is the coefficeints in numerator and 1 is the denominator coefficient
        [H, ~] = freqz(h,1);
        
        % Scale the magnitude by beta so that we get a maximum value of 1
        % Using the Numerical Method
        beta = 1/max(abs(H));
        
        % Scale BPF by beta to get a maximum magnitude of 1.
        h_scaled = beta*h;
        
        % Make sure each filter is added as a column
        hh = [hh, h_scaled(:)];
    end

end