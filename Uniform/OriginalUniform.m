clear
clc

%% Initialization
M=1801; %Angle resolution
k=2*pi; %wavenumber
theta=linspace(0,pi,M);
N = 100; % element number
d = 0.5;
dtheta=pi/1800;

[AF] = compute(N, d, cos(theta));
U=(abs(AF)./max(abs(AF))).^2;
Prad=2*pi*sum(U.*sin(theta).*dtheta);
D=4*pi*U/Prad;
DdB=10.*log10(D+eps);
Do=max(D);
DodB=max(DdB);

%% Figures
% Array Factor dB Plot:
figure
AFdB=10.*log10(U);
plot(theta*180/pi, AFdB,'m','linewidth',2);
axis([0 180 max(min(AFdB)-1,-60) 1]);
xlabel(['\theta',' (degrees)']),ylabel('ARRAY FACTOR(dB)')
grid on;
t1=text(1,1,['Directivity = ',num2str(DodB),' dB']);
    set(t1,'units','normalized','position',[1 1.05],'horizontalalign','right');

% Radiation Pattern Plot:
figure
polar(theta, U);
hold on
polar(-theta, U);

%Directivity Display:
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

function[AF] = compute(N, d, X)
    u=2*pi*d*X;
    AF = 0;
    p = -(N/2-0.5);
    for i = 1:N
        AF = AF + complex(cos(p*u), sin(p*u));
        p = p+1;
    end
end
