classdef tFitExponentialDecay < matlab.unittest.TestCase
    % Tests for fitExponentialDecay.

    methods (Test)
        function recoversExactParameters(testCase)
            t = linspace(0, 5, 50)';
            y = 4 * exp(-0.7 * t);
            [amplitude, rate] = fitExponentialDecay(t, y);
            testCase.verifyEqual(amplitude, 4, "AbsTol", 1e-6);
            testCase.verifyEqual(rate, 0.7, "AbsTol", 1e-6);
        end

        function toleratesNoise(testCase)
            rng(0);
            t = linspace(0, 5, 200)';
            y = 2 * exp(-1.5 * t) + 0.01 * randn(size(t));
            [amplitude, rate] = fitExponentialDecay(t, y);
            testCase.verifyEqual(amplitude, 2, "AbsTol", 0.05);
            testCase.verifyEqual(rate, 1.5, "AbsTol", 0.05);
        end

        function sizeMismatchErrors(testCase)
            testCase.verifyError(@() fitExponentialDecay((1:3)', (1:4)'), ...
                "signalUtils:sizeMismatch");
        end
    end
end
