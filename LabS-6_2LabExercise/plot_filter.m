function plot_filter(coeff_file,plot_title,F_samp,samples)
% This function takes the coefficient output from filterdesign and plots the magnitude and phase response using user-defined resolution.
%   Inputs:
%       coeff_file: A .mat file created by the filterdesign GUI that contains the numerator and denominator coefficients.
%       plot_title: A string used to title the generated plot
%       F_samp: The F_samp value used in the GUI to generate the GUI coefficients.
%       samples: The sample count the user defines for the new plot.
%
%   Output:
%       A single figure with magnitude and phase (degrees) plots plotted across frequency (Hz)

    % Import file
    coeffs = load(coeff_file);

    % Extract variables
    num_coeffs = coeffs.a;
    den_coeffs = coeffs.b;

    [h,w] = freqz(den_coeffs,num_coeffs,'whole',samples);
    f = w * F_samp / (2 * pi); % Convert rad/s to Hz by multiplying by F_samp from GUI and dividing by 2π

    % Rotate h and shift f to show lowpass behavior.
    h = circshift(h,(samples / 2));
    f = f - (F_samp / 2);

    figure
    subplot(2,1,1)
    plot(f,abs(h))
    xlabel('Frequency (Hz)')
    ylabel('Magnitude')
    subplot(2,1,2)
    plot(f,rad2deg(angle(h)))
    xlabel('Frequency (Hz)')
    ylabel('Phase (degrees)')
    sgtitle(plot_title)
end