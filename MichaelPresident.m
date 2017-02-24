classdef MichaelPresident
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
      modfreq
      phase = 0;
    end
    
    methods
      % This is an LFO for the hamming bandpass filter
      function y = LFO(freq)
        y = sin(obj.phase);
        delta = obj.modfreq*2*pi;
        obj.phase = obj.phase + delta;
        if obj.phase > 2 * pi
  	      obj.phase = obj.phase - 2*pi;
        end
      end
    end
    
end

