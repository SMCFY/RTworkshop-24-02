classdef SpectralPanning < audioPlugin
    %INCLASS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Left = 0.5;
        Right = 0.5;
        Width = 0.5;
    end
    
    properties (Constant)
        PluginInterface = audioPluginInterface( ...
            audioPluginParameter('Left', 'Mapping',{'lin',0,1}),...
            audioPluginParameter('Right', 'Mapping',{'lin',0,1}),...
            audioPluginParameter('Width', 'Mapping',{'lin',0,1}))
    end
    methods
        function out = process(obj,in)
            [m,n] = size(in);
            X = fft(in,m);

            y = zeros(m,n);
            width = obj.Width;
            width = round(m*width);
            for i = 1:width
                r = rand(1);
                if r > 0.5 % mod(i,2)
                    y(i,1) = X(i,1) * obj.Left;
                    y(i,2) = X(i,2) * obj.Right;
                else
                    y(i,1) = X(i,2) * obj.Left;
                    y(i,2) = X(i,1) * obj.Right;
                end
            end
            y(width:end,:) = X(width:end,:);
%             mid = 0.5*X(:,1) + 0.5*X(:,2);
%             sid = 0.5*X(:,1) - X(:,2);
%             sid = sid*obj.Width;
%             y = [mid+sid mid-sid];
            out = real(ifft(y));
        end
    end
    
end