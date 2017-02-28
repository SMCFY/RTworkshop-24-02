classdef CasperTimeShifting < audioPlugin
    %INCLASS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Shift = 1.2;
    end
    
    properties (Constant)
      PluginInterface = audioPluginInterface( ...
            audioPluginParameter('Shift', 'Mapping',{'lin',0,200}))
    end
    
    methods
        function out = process(obj,in)
            [m,n] = size(in);
            s=getSampleRate(obj);
            X = fft(in,m);
            for f = 1:m
                %trying to apply an immaginary exponential to each frequency
                %component
                freq=(f-1)*s/m;
                X(f,:)=X(f,:)*exp(-2i*pi*freq*obj.Shift);
            end;
                out = real(ifft(X)); 
        end
    end
    
end