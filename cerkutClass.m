classdef cerkutClass < audioPlugin
    %INCLASS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Width = 1;
    end
    
    properties (Constant)
      PluginInterface = audioPluginInterface( ...
            audioPluginParameter('Width', 'Mapping',{'lin',0,10}))
    end
    methods
        function out = process(obj,in)
          [m,n] = size(in);
          X = fft(in,m*2);
          XHalf       = X(1:m+1,:);
          out = zeros(m,n);
          
          for i = 1:n % Channels
             YmagHalf     = abs(XHalf(:,i));
             YmagHalf(6)  = YmagHalf(6)*obj.Width;
             YHalf        = YmagHalf.*exp(1i*angle(XHalf(:,i)));
             reverseYHalf = flipud( conj(YHalf(2:end-1)) );
             Y            = [YHalf;reverseYHalf];
             y            = real(ifft(Y));
             out(:,i)     = y(1:m);
          end
           
        end
    end
    
end

