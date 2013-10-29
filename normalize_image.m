function normalized = normalize_image(I, R)
%NORMALIZE_IMAGE transforms 1 or 2D data to match linear dynamic range R.
%   NORMALIZE_IMAGE(I,R) applies a linear transformation to the dynamic
%   range of I, mapping pixel intensities to new values over the range R.
%  
%   Examples
%       load clown
%       clims = [10 60];
%       imagesc(X,clims)
%       X = normalize_image(X,[0 1]);
%       figure,imagesc(X,[0 1])
%
%     See also norm, imagesc, colormap.


if (nargin < 1 || isempty(I)),     %exit if no data is specified
    normalized = []; return; end  

if (nargin < 2 || isempty(R)),     %default range is [0 1]
    R = [0 1]; end 

if (numel(R)==1), R = [0 R]; end   %if specified range is scalar use [0 R]

rangeMin = min(R(:));              %desired minimum
rangeMax = max(R(:));              %desired maximum
newRange = rangeMax - rangeMin;    %desired range
 
maxVal = max(max(I));              %original maximum value
minVal = min(min(I));              %original minimum value
oldRange = maxVal - minVal;        %original range

if (oldRange==0),                  %check if original range is zero
    normalized = ones(size(I)).* rangeMax;
    return;                        %return uniform image
end

if (newRange==0),                  %check if new range is zero
    normalized = ones(size(I)).* rangeMax;
    return;                        %return uniform image
end

I = I - minVal;                    %shift image to zero-based range

zeroMax = maxVal - minVal;         %zero-based maximum

% if (range(1) < 0)
%     %transform with (+)adjusted max, shift to final range
%     I = (I.* ((rangeMax+(0-rangeMin))/zeroMax)) + rangeMin;
% elseif (range(1) > 0)
%     %transform with (-)adjusted max, shift to final range
%     I = (I.* ((rangeMax+(0-rangeMin))/zeroMax)) + rangeMin;
% else
%     %transform with desired max, no shift
%     I = (I.* ((rangeMax+(0-rangeMin))/zeroMax)) + rangeMin;
% end
I = (I.* ((rangeMax+(0-rangeMin))/zeroMax)) + rangeMin;

normalized = I;

%==========================================================================
%normalize_image.m
%Function that transforms 1 or 2D data to match linear dynamic range R.
%--------------------------------------------------------------------------
%author:  David Sedarsky
%date:    March, 2012