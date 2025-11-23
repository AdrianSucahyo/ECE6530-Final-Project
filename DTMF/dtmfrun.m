% DTMFRUN 
% 
% keys = dtmfrun(xx,L,fs)
% returns the list of key names found in xx.
% keys = array of characters, i.e., the decoded key names
% xx = DTMF waveform
% L = filter length
% fs = sampling freq

function keys = dtmfrun(xx, L, fs)
    
    % Predefine the keypad and DTMF tones
    dtmf.keys = ...
    ['1','2','3','A';
    '4','5','6','B';
    '7','8','9','C';
    '*','0','#','D'];
    
    dtmf.colTones = ones(4,1)*[1209,1336,1477,1633];
    dtmf.rowTones = [697;770;852;941]*ones(1,4);

    % Define Center Frequencies
    center_freqs = [697, 770, 852, 941, 1209, 1336, 1477, 1633];

    % Generate the Bandpass Filters for the target frequencies
    hh = dtmfdesign(center_freqs, L, fs);
    % hh = L by 8 MATRIX of all the filters. Each column contains the
    % impulse response of one BPF (bandpass filter)
    
    % Find the beginning and end of tone bursts
    [nstart,nstop] = dtmfcut(xx, fs);
    
    % Process all DTMF tones found in the signal
    keys = [];
    for kk=1:length(nstart)
        % Extract one DTMF tone
        x_seg = xx(nstart(kk):nstop(kk));

        % Filter the extracted tone segment with the corresponding bandpass filters
        detected_tones = [];
        for current_filter_index = 1:length(center_freqs)
            tone_score = dtmfscore(x_seg, hh(:,current_filter_index));
            
            if (tone_score == 1)
                detected_tones = [detected_tones, center_freqs(current_filter_index)];
            end
        end

        % == Decode Frequencies to an Input Button ==
        
        % Decode the detected tones into a key row and column
        found_rows = ismember(dtmf.rowTones(:,1), detected_tones);
        found_cols = ismember(dtmf.colTones(1,:), detected_tones);
        
        % Check if there is exactly 1 row and column
        if (sum(found_rows) == 1 && sum(found_cols) == 1)
            found_position = found_rows .* found_cols;
            [key_row, key_col] = find(found_position == 1);

            keys = [keys, dtmf.keys(key_row, key_col)];
        else
            % Error in decoding
            keys = [keys, -1];
        end
    end
end