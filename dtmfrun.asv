function keys = dtmfrun(xx,L,fs)
%DTMFRUN keys = dtmfrun(xx,L,fs)
% returns the list of key names found in xx.
% keys = array of characters, i.e., the decoded key names
% xx = DTMF waveform
% L = filter length
% fs = sampling freq
%
center_freqs = [697, 770, 852, 941, 1209, 1336, 1477, 1633]; % Define Center Frequencies
hh = dtmfdesign( center_freqs,L,fs );
% hh = L by 8 MATRIX of all the filters. Each column contains the
% impulse response of one BPF (bandpass filter)
%
[nstart,nstop] = dtmfcut(xx,fs); %<--Find the beginning and end of tone bursts
keys = [];
for kk=1:length(nstart)
x_seg = xx(nstart(kk):nstop(kk)); %<--Extract one DTMF tone

% Next, I'll pass the x_seg through the 

end