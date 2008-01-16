function w = K(kk,g1,g2,CS,SS,varargin)
% evaluate kernel modulo symmetries
%% Syntax
% w = K(kk,g1,g2,CS,SS,<options>)
%
%% Input
%  kk     - @kernel
%  g1, g2 - @quaternion(s)
%  CS, SS - crystal , specimen @symmetry
%
%% Options
%  EXACT - 
%  EPSILON - 
%
%% general formula:
% K(g1,g2) = Sum(g S) Sum(l) A_l Tr T_l(g1^-1 g g2)
% where Tr T_l(x) = [sin(x/2)+sin(x*l)]/sin(x/2)


if check_option(varargin,'EXACT')
  epsilon = pi;
else 
  epsilon = get_option(varargin,'EPSILON',gethw(kk)*3);
end

% how to use sparse matrix representation 
if isa(g1,'SO3Grid') && check_option(g1,'indexed'),
  lg1 = GridLength(g1);
else
  lg1 = -numel(g1);
end
if isa(g2,'SO3Grid') && check_option(g2,'indexed')
  lg2 = GridLength(g2);
else
  lg2 = -numel(g2);
end


if epsilon*(length(CS)*length(SS))^(1/3)>pi % full matrixes
 
  g1 = quaternion(g1);
  g2 = quaternion(g2);  
  w = zeros(numel(g1),numel(g2));
     
	for iks = 1:length(CS)
		for ips = 1:length(SS) % for all symmetries
      
			sg    = quaternion(SS,ips) * g1 * quaternion(CS,iks);  % rotate g1
      omega = dot_outer(sg,g2);      % calculate full distance matrix            
      w = w + kk.K(omega);          
      
		end
  end  
  
elseif (lg1>0 || lg2>0) && ~check_option(varargin,'old')

  w = sparse(abs(lg1),abs(lg2));
  
  % exeptional case of cubic symmetry
  % extract trifold symmetry
  if any(strcmp(Laue(CS),{'m-3','m-3m'}))
    q = axis2quat(vector3d(1,1,1),2*pi/3*(0:2));
  else
    q = idquaternion;
  end
  
  for iq = 1:length(q)  
    if (lg1 >= lg2)              % first argument is SO3Grid
      d = dot_outer(g1,quaternion(g2)*q(iq),'epsilon',epsilon,'nocubictrifoldaxis');
      w = w + spfun(kk.K,d);
    else                         % second argument is SO3Grid
      d = dot_outer(g2,quaternion(g1)*q(iq),'epsilon',epsilon,'nocubictrifoldaxis');
      w = w + spfun(kk.K,d.');
    end
  end

else
  
	g1 = quaternion(g1);
	g2 = quaternion(g2);
  
	w = sparse(numel(g1),numel(g2));
     
	for iks = 1:length(CS)
		for ips = 1:length(SS) % for all symmetries
      
      if abs(lg1) > abs(lg2)
        sg    = quaternion(SS,ips) * g2 * quaternion(CS,iks);  % rotate g1
        omega = dot_outer(g1,sg);      % calculate full distance matrix
      else
        sg    = quaternion(SS,ips) * g1 * quaternion(CS,iks);  % rotate g1
        omega = dot_outer(sg,g2);      % calculate full distance matrix
      end
      

%  z = find(omega>cos(epsilon));
%  if length(z) > numel(omega)/length(CS)/10, w = full(w); end
%  w(z) = w(z) +  kk.K(omega(z));
      
%  if length(z) > numel(omega)/length(CS)/10, w = full(w); end
      
      [y,x] = find(omega>cos(epsilon));
      dummy = sparse(y,x,kk.K(omega(sub2ind(size(w),y,x))),numel(g1),numel(g2));
      
      w = w + dummy;          
      
		end
  end  

end
%nnz(w)
w = w / length(CS) / length(SS);
