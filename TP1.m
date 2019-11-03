% Question 1
global X1MIN
global X2MIN
global X1MAX
global X2MAX
global N1
global N2
global map
map =load('mnt.data');
[N1 N2]=size(map);
X1MIN=-10000;
X1MAX= 10000;
X2MIN=-10000;
X2MAX= 10000;
delta= 1;

imagesc([X1MIN X1MAX],[X2MIN X2MAX],transpose(map));
hold on;
colormap('jet');
axis square;
axis off;

load('traj.mat','rtrue','vtrue');
nmax = size(rtrue,2);

plot(rtrue(1,:),rtrue(2,:),'r-');
hold on;
% Question 2 

r_0= [-6000;-2000];
v_0= [120;0];
load('ins.mat','a_INS')
r_INS(:,1)=r_0;
v_INS(:,1)= v_0; %init
for n=2:nmax
    r_INS(:,n)=r_INS(:,n-1)+delta*v_INS(:,n-1);
    v_INS(:,n)=v_INS(:,n-1)+delta*a_INS(:,n-1);
end
%plot(r_INS(1,:),r_INS(2,:),'m-');
%hold off;
% Question 3 

% A Montrer calculatoirement 

% Question 4 

%map_r=zeros(1,nmax);
%i1=ceil(N1*(rtrue(1,:)-X1MIN)/(X1MAX- X1MIN));
%i2=ceil(N2*(rtrue(2,:)-X2MIN)/(X2MAX- X2MIN));
%for i=1:nmax
   % map_r(i)=map(i1(i),i2(i));
%end


% Question 5 

load('alt.mat','h_ALT');
hold on;
plot(h_ALT,'r+');

% Question 7 

sr0 = 100;
sv0 = 10;
sINS = 7;
sALT = 10;
sBAR = 20;
N=5000;
T=100;
Y=h_ALT;
%x = SIR_corr(sr0,sv0,sINS,N,T,delta,Y,r_INS,sBAR,sALT);

clf;
imagesc([X1MIN X1MAX],[X2MIN X2MAX],transpose(map));
hold on;
axis square;
axis off;
hold on;

[y,K] = SIRm(sr0,sv0,sINS,N,T,delta,Y,r_INS,sBAR,sALT);
for k = 1:T+1 
   plot(K(4*(k-1)+1,:),K(4*(k-1)+2,:),'g-');
   hold on;
end
plot(r_INS(1,:),r_INS(2,:),'r-');
hold on;
plot(rtrue(1,:),rtrue(2,:),'r-');
hold on;
plot(y(1,:),y(2,:),'w');


%drawnow;
%set(gcf,'DoubleBuffer','on')