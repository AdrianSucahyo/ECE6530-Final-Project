%% 2.1 

% Include DSP-First 'toolbox' to path
addpath(genpath('filterdesign'));

% ** The DSP System Toolbox was installed for the filterdesign GUI.

M = 30;
wc = 0.4*pi; % 2 * pi * (2000 / 10000)

% Part a

filterdesign 

% Part b

% Part c

h_n_hamming = h .*(0.54 - 0.46 * (cos(2*pi.*(0:M-1)./(M-1)))); % From table 10.1

% Part d

