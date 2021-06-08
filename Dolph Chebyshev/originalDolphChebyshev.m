close all;
clc;

%% Initialization

M=1800;

k=2*pi;
theta=linspace(0,pi,M+1);
dtheta=pi/M;

Nelem=100;

d=0.5;
beta=0;
RdB=25;
Ro=10^(RdB/20);
P=Nelem-1;
Zo=0.5*((Ro+sqrt(Ro^2-1))^(1/P)+(Ro-sqrt(Ro^2-1))^(1/P));
[AF,Ncoef,Coef,Zo]=cheby(cos(theta),Nelem,d,RdB,beta);

R=10^(RdB/20);
f=1+0.636*(2/R*cosh(sqrt((acosh(R))^2-pi^2)))^2;
Dir=2*R^2/(1+(R^2-1)*f/(d*Nelem));

Coef=Coef(1:Ncoef);
Ncoef=Coef(1:Ncoef)/Coef(Ncoef);

U=(abs(AF)./max(abs(AF))).^2;
Prad=2*pi*sum(U.*sin(theta).*dtheta);

D=4*pi*U/Prad;
DdB=10.*log10(D+eps);
Do=max(D);
DodB=max(DdB);

AFdB=10.*log10(U);

%%%%%%%%%%%%%%%%%%%%%%%%%%GRAPHS%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Figures

% Array Factor dB Plot:
figure
U=(abs(AF)./max(abs(AF))).^2;
AFdB=10.*log10(U);
plot(theta*180/pi, AFdB,'m','linewidth',2);
axis([0 180 max(min(AFdB)-1,-60) 1]);
xlabel(['\theta',' (degrees)']),ylabel('ARRAY FACTOR(dB)')
grid on;

% Radiation Pattern Plot:
figure
polar(theta, U);
hold on
polar(-theta, U);

%Overall Directivity
disp(['DIRECTIVITY = ',num2str(DodB),' dB']);
disp(['DIRECTIVITY = ',num2str(Do),' dimensionless']);

%Directivity
figure;
diffdB=DodB-min(DdB);
plot(theta*180/pi,DdB,'b','linewidth',2);
xlabel(['\theta',' (degrees)']),ylabel('DIRECTIVITY(dB)')
grid on;
axis([0 180 max(-50,10*floor(min(DdB)/10)) 10*ceil(DodB/10)]);

%% Functions

% TSCHEBY(THETA,NELEM,D,RDB)
function[AF,Ncoef,Coef,Zo]=cheby(X,Nelem,d,RdB,beta)
    Ro=10^(RdB/20);
    P=Nelem-1;
    Zo=0.5*((Ro+sqrt(Ro^2-1))^(1/P)+(Ro-sqrt(Ro^2-1))^(1/P));
    if 2*floor(Nelem/2)==Nelem,
        Ncoef=Nelem/2;
        M=Ncoef;
        Coef=zeros(1,M);
        for i=1:M;
            Coef(i)=0;
            for j=i:M;
                Coef(i)=Coef(i)+(-1)^(M-j)*Zo^(2*j-1)*fact(j+M-2)*(2*M-1)/(fact(j-i)*fact(j+i-1)*fact(M-j));
            end
        end
    elseif 2*floor((Nelem+1)/2)==Nelem+1,
        Ncoef=(Nelem+1)/2;
        M=Ncoef-1;
        Coef=zeros(1,M);
        for i=1:M+1;
            Coef(i)=0;
            for j=i:M+1;
                if i==1,EN=2;
                else EN=1;
                end
                Coef(i)=Coef(i)+(-1)^(M-j+1)*Zo^(2*(j-1))*fact(j+M-2)*2*M/(EN*fact(j-i)*fact(j+i-2)*fact(M-j+1));
            end
        end
        
    end
    u=2*pi*d*X+beta;
    if 2*floor(Nelem/2)==Nelem,
        AF=0;
        for i=1:Ncoef;
            AF=AF+Coef(i)*cos((2*i-1)/2*u);
        end
    elseif 2*floor((Nelem+1)/2)==Nelem+1,
        AF=0;
        for i=1:Ncoef;
            AF=AF+Coef(i)*cos((i-1)*u);
        end
    end
    if 2*round(Nelem/2)~=Nelem
        Coef(1)=2*Coef(1);
    end
end

% FACT(IARG)
function[f7]=fact(iarg)
f7=1;
for j=1:iarg;
    f7=j*f7;
end
end
