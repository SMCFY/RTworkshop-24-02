classdef bandPass < audioPlugin
    %INCLASS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Width = 0.5;
    end
    
    properties (Constant)
      PluginInterface = audioPluginInterface( ...
            audioPluginParameter('Width', 'Mapping',{'lin',0,1}))
    end
    methods
        function out = process(obj,in)
          [m,n] = size(in);
           X = fft(in,m);
           
           w = blackman(128);
           
           bp = [ones(1,m/2/4) w' ones(1,m/2-length(w)-m/2/4)];
           bp = [bp flip(bp)]';
           X = X .* bp;
           
           %X(1:round(m*obj.Width),:) = 0;
           
           out = real(ifft(X)); 
        end
    end
    
end

