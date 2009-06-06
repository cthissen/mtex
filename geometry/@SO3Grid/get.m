function varargout = get(obj,vname,varargin)
% get object variable

switch lower(vname)
  case {'cs','ss'}
    varargout = {obj.(vname)};
  case {'quaternion','grid','orientation'}
    varargout = quaternion(obj);    
  case fields(obj)
    varargout = [obj.(vname)];
  otherwise
    error('Unknown field in class ODF!')
end
