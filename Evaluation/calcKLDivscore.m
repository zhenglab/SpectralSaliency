function score =calcKLDivscore(P,Q)

% http://www.tcts.fpms.ac.be/attention/data/documents/data/calcKLDivscore.m
% For saliency detection: P => fixation map and Q => saliency map

% dist = KLDiv(P,Q) Kullback-Leibler divergence of two discrete probability distributions
% The measure Q typically represents a theory, model, description, or approximation of P.
% P and Q  are automatically normalised to have the sum of one on rows have the length of one at each 
% P =  n x nbins
% Q =  1 x nbins or n x nbins(one to one)
% dist = n x 1

Q = double(imresize(Q,size(P),'nearest'));                 


if size(P,2)~=size(Q,2)
    error('the number of columns in P and Q should be the same');
end

if sum(~isfinite(P(:))) + sum(~isfinite(Q(:)))
   error('the inputs contain non-finite values!') 
end


 Q = Q ./ (sum(sum(Q)) + 0.0001);
 P = P ./ (sum(sum(P)) + 0.0001);
 temp =  P.*log(P./(Q + 0.0001) + 0.0000001);
 temp(isnan(temp))=0; % resolving the case when P(i)==0
 temp(isinf(temp))=0;
 score = sum(sum(temp));





