function [amplitude, rate] = fitExponentialDecay(t, y)
%FITEXPONENTIALDECAY Fit y = amplitude * exp(-rate * t) by nonlinear least squares.
%   [AMPLITUDE, RATE] = FITEXPONENTIALDECAY(T, Y) returns the amplitude and
%   decay rate that best fit the samples Y taken at times T.

arguments
    t (:,1) double
    y (:,1) double {mustBeEqualSize(t, y)}
end

model = @(p, tt) p(1) * exp(-p(2) * tt);
initialGuess = [max(abs(y)), 1];
lowerBounds = [-Inf, 0];
opts = optimoptions("lsqcurvefit", "Display", "off");
p = lsqcurvefit(model, initialGuess, t, y, lowerBounds, [], opts);
amplitude = p(1);
rate = p(2);
end

function mustBeEqualSize(a, b)
if ~isequal(size(a), size(b))
    error("signalUtils:sizeMismatch", "T and Y must have the same size.");
end
end
