classdef SMC_AAL_inClass < audioPlugin
    %INCLASS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Width = 0.5;
        gain = 10;
        fs = 44100;
    end
    
    properties (Constant)
        PluginInterface = audioPluginInterface( ...
            audioPluginParameter('gain', 'Mapping',{'lin',0,1000}))
    end
    methods
        function out = process(obj,in)
            [m,n] = size(in);
            L = length(in);
            X = fft(in,m);
            f = obj.fs*(0:(L/2))/L;
            f_150 = find(round(f)==150);
            X(f_150,:) = X(f_150,:)*obj.gain;
            out = real(ifft(X));
        end
    end
    
end

