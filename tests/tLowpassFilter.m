classdef tLowpassFilter < matlab.unittest.TestCase
    % Tests for lowpassFilter.

    methods (Test)
        function removesHighFrequency(testCase)
            fs = 1000;
            t = (0:1/fs:1)';
            low = sin(2*pi*5*t);
            noisy = low + 0.5*sin(2*pi*200*t);
            y = lowpassFilter(noisy, 20, fs);
            interior = 50:numel(t)-50;
            testCase.verifyLessThan(max(abs(y(interior) - low(interior))), 0.05);
        end

        function preservesConstant(testCase)
            y = lowpassFilter(3*ones(200,1), 10, 100);
            testCase.verifyEqual(y, 3*ones(200,1), "AbsTol", 1e-10);
        end

        function cutoffAboveNyquistErrors(testCase)
            testCase.verifyError(@() lowpassFilter(ones(50,1), 60, 100), ...
                "signalUtils:cutoffAboveNyquist");
        end
    end
end
