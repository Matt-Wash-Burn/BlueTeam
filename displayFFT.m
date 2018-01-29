function outputArg1 = displayFFT(F)
%displayFFT Move the Fourier transform of the img to the center to display
%   

S1=fftshift(log(1+abs(F)));

outputArg1 = imshow(S1,[]);

end

