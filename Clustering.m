function [centroid, result] = Clustering(data, method, k,it,label)
% Currently, following clustering algorithms are supported:
%   1. Kmeans
%   2. Kmeans++
%   3. ISODATA (Iterative Self-Organizing Data Analysis)
%   4. Mean Shift
%   5. DBSCAN (Density-Based Spatial Clustering of Application with Noise)
%   6. Gaussian Mixture Model /* Numerical instability problem not completely solved*/
%   7. LVQ (Learning Vector Quantization)

addpath('.\lib');
addpath('.\tool');

% Kmeans
if(strcmp(method,'kmeans'))
    k
    iteration = it;
    [centroid, result] = Kmeans(data, k, iteration);
% Kmeans++
elseif(strcmp(method,'kmeans++') || strcmp(method,'kmeanspp')) 
    k
    iteration = it;
    [centroid, result] = Kmeanspp(data, k, iteration);
% ISODATA
elseif(strcmp(method,'ISODATA') || strcmp(method,'isodata'))
    desired_k=k;  % desired number of classes
    iteration=it;  % maximum iteration time
    minimum_n = varargin{1,3};  % minimum number of samples in one class
    maximum_variance = varargin{1,4};  % maximum allowed variance of samples in one class
    minimum_d = varargin{1,5};  %  minimum distance between two classes
    [centroid, result] = ISODATA(data, iteration, desired_k, minimum_n, maximum_variance, minimum_d);
    PlotData(data, result, centroid);
% Mean Shift
elseif(strcmp(method,'mean_shift') || strcmp(method,'Mean_Shift'))
    thr = varargin{1,1};  % distance threshold
    [centroid, result] = Mean_Shift(data, thr);
    PlotData(data, result, centroid);
% DBSCAN
elseif(strcmp(method,'dbscan') || strcmp(method,'DBSCAN'))
    epsilon = varargin{1,1};  % distance threshold for finding neighbors
    minPts = varargin{1,2}; % minimum required number of neighbor points for adding one core object
    centroid = nan;  % DBSCAN will not calculate centroid
    result = DBSCAN(data, epsilon, minPts);
    PlotData(data, result);
% Gaussian Mixture Model
elseif(strcmp(method,'GMM') || strcmp(method,'gmm'))
    k = varargin{1,1};  % the number of Guassian components
    iter = varargin{1,2};  % maximum number of iterations
    [result, ~, centroid, ~] = Gaussian_Mixture(data, k, iter);
    PlotData(data, result, centroid);
% Learning Vector Quantization
elseif(strcmp(method,'LVQ') || strcmp(method,'lvq'))
    q = varargin{1,1};  % the number of prototypes
    neta = varargin{1,2};  % learning rate
    x = varargin{1,3};  % training data
    y = varargin{1,4};  % label of x
    iter = varargin{1,5};  % maximum number of iterations
    [centroid, result] = LVQ(data, q, neta, x, y, iter);
    PlotData(data, result, centroid);
else
    error('NotImplementedError!');
end
end
