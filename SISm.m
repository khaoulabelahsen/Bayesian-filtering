function [X,K] = SISm(sr0,sv0,sINS,N,T,delta,Y,r_INS,sBAR,sALT)
global X1MIN
global X2MIN
global X1MAX
global X2MAX
global N1
global N2
global map
X=zeros(4,T+1); % La matrice qui va accuellir tous les Xk corrigÃ©s
 % le bruit blanc, pas surs de l'utiliser 

% k=0
pk=zeros(1,N); %les poids correspondant aux Ã©chantillons Ã  l'instant k=0
ksi_ks=[normrnd(0,sr0,[2,N]);normrnd(0,sv0,[2,N])]; % GÃ©nÃ©ration des Ã©chantillons ksi_0_i
ksi_k_pond = zeros(4,N); % Matrices des p0_i*ksi_0

K = zeros(4*(T+1),N);
m = 1;
n = 2;
K(m:n,:) = ksi_ks(1:2,:) + r_INS(:,1)*ones(1,N);
for i=1:N
    pk(i) = fct_vrais(ksi_ks(1:2,i),Y(:,1),1,r_INS,sBAR,sALT);
end
pk = pk/sum(pk);
for i=1:N
    ksi_k_pond(:,i)=pk(i)*ksi_ks(:,i);
end
X(:,1)=sum(ksi_k_pond,2); %X0 estimÃ©
X(1:2,1) = X(1:2,1) + r_INS(:,1); 


for k=2:T+1
    fk =[[1,0,delta,0];[0,1,0,delta];[0,0,1,0];[0,0,0,1]];
    wINS = normrnd(0,sINS,[2,N]);


% Etape 3 : Prédiction 
    ksi_ks = fk*ksi_ks-delta*[zeros(2,N);wINS];
    m = m+4;
    n = n+4;
    K(m:n,:) = ksi_ks(1:2,:) + r_INS(:,k)*ones(1,N) ;
   
% Etape 4 : correction 
    for i=1:N
       pk(i) = fct_vrais(ksi_ks(1:2,i),Y(:,k),k,r_INS,sBAR,sALT);
    end
    pk = pk/sum(pk);
    for i=1:N
        ksi_k_pond(:,i)=pk(i)*ksi_ks(:,i); 
    end
    X(:,k)=sum(ksi_k_pond,2);
    X(1:2,k) = X(1:2,k)+r_INS(:,k);
   
end