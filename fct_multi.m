function [x1,diff,ordre_k] = fct_multi(x,a,N)  
% 
u_tild = zeros(1,N);
expo = zeros(1,N);
alpha = zeros(1,N);
u_ord = zeros(1,N);
uu = zeros(1,N+1);
p = zeros(1,N);
ordre_k = zeros(1,N);
x1 = zeros(size(x,1),N);
kk = 0;
diff = 0;
% 
a = a./sum(a);
p = cumsum(a);
u_tild = rand(1,N);
expo = N:-1:1;
expo = (ones(1,N)./expo);
alpha = u_tild.^expo;
u_ord = cumprod(alpha);
u_ord(N:-1:1) = u_ord;
uu = [u_ord,2];
i = 1;
for j=1:size(a,2)
  k = 0;
  while uu(i)<p(j)
    x1(:,i) = x(:,j);
    ordre_k(i) = j;
    i = i+1;
    k = 1;
  end 
  if k==1
    kk = 1+kk;
  end
end
diff = kk;
