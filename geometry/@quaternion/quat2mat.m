function mat = quat2mat(q)
% quaternion to direction cosine matrix conversion
% converts direction cosine matrix to quaternion
%
%% Syntax
%  mat = matrix2quat(q)
%
%% Input
%
%  q - @quaternion
%
%% Output
%
%  mat - vector of matrixes
%
%% See also
%
% mat2quat, Euler2quat, axis2quat, hr2quat

q = q';
q = reshape(q,[1 1 numel(q)]);
p = [q.b;q.c;q.d];
z = repmat(0,[1 1 numel(q)]);

mat = 2 * [q.b .* q.b q.b .* q.c q.b .* q.d;...
  q.c .* q.b q.c .* q.c q.c .* q.d; ...
  q.d .* q.b q.d .* q.c q.d .* q.d] ...
  - 2 * repmat(q.a,3,3) ...
  .* [z -q.d q.c;q.d z -q.b;-q.c q.b z] ...
  + repmat(q.a .* q.a - sum(p.*p),3,3) ...
  .* repmat(eye(3),[1 1 numel(q)]);