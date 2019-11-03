function [G] = fct_vrais(x,y,k,r_INS,sBAR,sALT)
global X1MIN
global X2MIN
global X1MAX
global X2MAX
global N1
global N2
global map
hk = fct_h(r_INS(:,k)+x,X1MIN,X2MIN,X1MAX,X2MAX,N1,N2,map);
G = (1/sqrt(2*pi*(sBAR^2+sALT^2)))*exp(-norm(y-hk)^2/(2*(sBAR^2+sALT^2)));