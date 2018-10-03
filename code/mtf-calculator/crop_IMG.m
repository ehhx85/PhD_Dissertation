function [ A ] = crop_IMG( A )

A.Z.crop = double(A.Z.raw(A.y.index, A.x.index)); 

end