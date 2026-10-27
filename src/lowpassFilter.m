function y = lowpassFilter(x, cutoffHz, sampleRateHz, order)
%LOWPASSFILTER Zero-phase Butterworth lowpass filter.
%   Y = LOWPASSFILTER(X, CUTOFFHZ, SAMPLERATEHZ) filters X with a 4th-order
%   Butterworth lowpass filter applied forward and backward, so the output
%   has no phase delay.
%
%   Y = LOWPASSFILTER(X, CUTOFFHZ, SAMPLERATEHZ, ORDER) uses the given order.

arguments
    x (:,1) double
    cutoffHz (1,1) double {mustBePositive}
    sampleRateHz (1,1) double {mustBePositive}
    order (1,1) double {mustBeInteger, mustBePositive} = 4
end

nyquistHz = sampleRateHz / 2;
if cutoffHz >= nyquistHz
    error("signalUtils:cutoffAboveNyquist", ...
        "Cutoff (%g Hz) must be below the Nyquist frequency (%g Hz).", ...
        cutoffHz, nyquistHz);
end

[b, a] = butter(order, cutoffHz / nyquistHz);
y = filtfilt(b, a, x);
end
