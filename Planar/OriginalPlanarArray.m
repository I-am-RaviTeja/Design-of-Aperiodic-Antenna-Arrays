clear
clc

%% Initialization

j=sqrt(-1);
M=1801; %Angle resolution
k=2*pi; %wavenumber
theta=linspace(0,pi,M);
phi=linspace(-pi/2,pi/2,M);
[THETA,PHI]=meshgrid(theta,phi);
dtheta=pi/M;
dphi=pi/M;

%Planar Array variables
My=100; 
Nz=100;
dy=0.5; %Interelement spacing in y
dz=0.5; %Interelement spacing in z
deltay=0; %Steering angle in phi
deltaz=0; %Steering angle in theta

%Array factor
psiy=(-k*dy*sin(theta).*sin(phi))+deltay;
psiz=(-k*dz*cos(theta))+ deltaz;
AFy=0;
AFz=0;
for m=1:My
    AFy= AFy+ exp(j*(m-1)*psiy);
end
for n=1:Nz
    AFz=AFz+ exp(j*(n-1)*psiz);
end
AF=AFy.*AFz;
U=(abs(AF)./max(abs(AF))).^2;
AFdB=10.*log10(U);
Prad=sum(sum(U.*sin(THETA).*dtheta.*dphi));
D=4*pi*U/Prad;
DdB=10.*log10(D);
Do=max(D);
DodB=max(DdB);
%% Figures

% Array Factor Graph
plot(theta*180/pi,AFdB,'m','linewidth',2);
axis([75 105 max(min(AFdB)-1,-60) 1]);
xlabel(['\theta',' (degrees)']),ylabel('ARRAY FACTOR(dB)')
grid on;
AFmag=abs(AF);

% Directivity
figure;
diffdB=DodB-min(DdB);
plot(theta*180/pi,DdB,'b','linewidth',2);
xlabel(['\theta',' (degrees)']),ylabel('DIRECTIVITY(dB)')
grid on;
axis([75 105 max(-50,10*floor(min(DdB)/10)) 10*ceil(DodB/10)]);

% Radiation Pattern
figure;
polar(theta, U);
hold on;
polar(-theta, U);
