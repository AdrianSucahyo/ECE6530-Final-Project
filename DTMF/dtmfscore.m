% DTMFSCORE
% 
% usage: sc = dtmfscore(xx, hh)
% returns a score based on the max amplitude of the filtered output
% xx = input DTMF tone
% hh = impulse response of ONE bandpass filter
% 
% The signal detection is done by filtering xx with a length-L
% BPF, hh, and then finding the maximum amplitude of the output.
% The score is either 1 or 0.
% sc = 1 if max(|y[n]|) is greater than, or equal to, 0.59
% sc = 0 if max(|y[n]|) is less than 0.59

function sc = dtmfscore(xx, hh)

    % Scale the input x[n] to the range [-2, +2]
    xx = xx * (2/max(abs(xx)));
    
    % Apply the filter to the DTMF tone through convolution
    y = conv(xx, hh);
    
    % y = filter(hh, 1, xx) % Should we use the filter function instead
    
    % Check if the result surpassed the threshold
    if max(abs(y)) >= 0.59
        sc = 1;
    else
        sc = 0;
    end

    % plot(y(1:300)) % For debugging
end



