function [h] = fct_h(r,X1MIN,X2MIN,X1MAX,X2MAX,N1,N2,map)
i1 = ceil(N1*(r(1)-X1MIN)/(X1MAX- X1MIN));
i2 = ceil(N2*(r(2)-X2MIN)/(X2MAX- X2MIN));
h = map(i1,i2);