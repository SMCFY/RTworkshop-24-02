classdef Casper < audioPlugin
    %INCLASS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Width = 0.5;
        Shift = 0;
    end
    
    properties (Constant)
      PluginInterface = audioPluginInterface( ...
            audioPluginParameter('Shift', 'Mapping',{'lin',0,2}))
    end
    
    methods
        function out = process(obj,in)
          [m,n] = size(in);
           X = fft(in,m);
           for w = 1:m
        %trying to apply an immaginary exponential to each frequency
        %component
                X(w,:)=X(w,:)*(1/(i*w*44100/m))*exp(-1*i*obj.Shift*(w*44100/m));
           end;
           out = real(ifft(X)); 
        end
    end
    
end