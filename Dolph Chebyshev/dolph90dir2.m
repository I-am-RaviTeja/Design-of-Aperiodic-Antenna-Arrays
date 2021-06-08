clear
clc

%% Initialization
iterations = 1000;
inertia = 1.0;
correction_factor = 2.0;
Nelem = 90;
d = 1;
theta=linspace(0,pi,1800+1);
dtheta=pi/1800;

% ---- initial swarm position -----
swarm=zeros(Nelem,7);
% Description of swarm matrix
% 1st col - amplitude
% 2nd col - distance
% 3rd col - best amplitude
% 4th col - best position
% 5rd col - amplitude velocity
% 6th col - distance velocity
% 7th col - local best values

%Initial Values
swarm(:, 7) = 1000;       % Greater than maximum possible value
swarm(:, 5) = 0.5;          % initial velocity CHANGE THIS
swarm(:, 6) = 0.5;          % initial velocity CHANGE THIS

%Initial Co-efficients 
swarm(1,1) = 1.06649268262613;
swarm(2,1) = 0.137222532190265;
swarm(3,1) = 0.145783030012353;
swarm(4,1) = 0.154510161344660;
swarm(5,1) = 0.172417148947716;
swarm(6,1) = 0.181572437286377;
swarm(7,1) = 0.190841674804688;
swarm(8,1) = 0.200988769531250;
swarm(9,1) = 0.211914062500000;
swarm(10,1) = 0.115234375000000;
swarm(11,1) = -1.15625000000000;
swarm(12,1) = -147;
swarm(13,1) = 203;
swarm(14,1) = -13304;
swarm(15,1) = 1622784;
swarm(16,1) = -3400704;
swarm(17,1) = 47976448;
swarm(18,1) = 223510528;
swarm(19,1) = -1849032704.00000;
swarm(20,1) = -743702528;
swarm(21,1) = 87773151232.0000;
swarm(22,1) = 166715195392.000;
swarm(23,1) = 1922425683968.00;
swarm(24,1) = 549688705024.000;
swarm(25,1) = -123551176720384;
swarm(26,1) = 600556150194176;
swarm(27,1) = 2.49351413065318e+15;
swarm(28,1) = -3.02918459929395e+15;
swarm(29,1) = 1.87445687196058e+16;
swarm(30,1) = -8.62357277586227e+15;
swarm(31,1) = 9.27270382505820e+16;
swarm(32,1) = 2.90195890625315e+17;
swarm(33,1) = 7.44493754257244e+17;
swarm(34,1) = 9.39089307870691e+17;
swarm(35,1) = 2.72517035576839e+18;
swarm(36,1) = 4.48572266781449e+18;
swarm(37,1) = 1.54844684334578e+19;
swarm(38,1) = 3.53210347870948e+19;
swarm(39,1) = 1.00587954851925e+20;
swarm(40,1) = 1.46394154622840e+20;
swarm(41,1) = 2.35341078494198e+20;
swarm(42,1) = 2.06788819806623e+20;
swarm(43,1) = 3.17115901211713e+20;
swarm(44,1) = 2.14150270056908e+20;
swarm(45,1) = 3.16611322131587e+20;
swarm(46,1) = 3.16611322131587e+20;
swarm(47,1) = 2.35856485564834e+20;
swarm(48,1) = 2.14150270056908e+20;
swarm(49,1) = 3.17115901211713e+20;
swarm(50,1) = 2.06788819806623e+20;
swarm(51,1) = 2.35341078494198e+20;
swarm(52,1) = 1.46394154622840e+20;
swarm(53,1) = 1.00587954851925e+20;
swarm(54,1) = 3.53210347870948e+19;
swarm(55,1) = 4.48572266781449e+18;
swarm(56,1) = 2.72517035576839e+18;
swarm(57,1) = 1.20153531171734e+18;
swarm(58,1) = 9.39089307870691e+17;
swarm(59,1) = 7.44493754257244e+17;
swarm(60,1) = 2.90195890625315e+17;
swarm(61,1) = 9.27270382505820e+16;
swarm(62,1) = -8.62357277586227e+15;
swarm(63,1) = 1.87445687196058e+16;
swarm(64,1) = -3.02918459929395e+15;
swarm(65,1) = 600556150194176;
swarm(66,1) = -123551176720384;
swarm(67,1) = -13868113854464.0;
swarm(68,1) = 549688705024.000;
swarm(69,1) = 1922425683968.00;
swarm(70,1) = 166715195392.000;
swarm(71,1) = 87773151232.0000;
swarm(72,1) = -743702528;
swarm(73,1) = -1849032704.00000;
swarm(74,1) = 223510528;
swarm(75,1) = -3400704;
swarm(76,1) = 1622784;
swarm(77,1) = -46272;
swarm(78,1) = -13304;
swarm(79,1) = 203;
swarm(80,1) = -147;
swarm(81,1) = -1.15625000000000;
swarm(82,1) = 0.115234375000000;
swarm(83,1) = 0.211914062500000;
swarm(84,1) = 0.200988769531250;
swarm(85,1) = 0.181572437286377;
swarm(86,1) = 0.172417148947716;
swarm(87,1) = 0.163392235059291;
swarm(88,1) = 0.154510161344660;
swarm(89,1) = 0.145783030012353;
swarm(90,1) = 0.137222532190265;

%Initial Positions
swarm(1,2) = -49.5/2;
swarm(2,2) = -48.5/2;
swarm(3,2) = -47.5/2;
swarm(4,2) = -46.5/2;
swarm(5,2) = -44.5/2;
swarm(6,2) = -43.5/2;
swarm(7,2) = -42.5/2;
swarm(8,2) = -41.5/2;
swarm(9,2) = -40.5/2;
swarm(10,2) = -39.5/2;
swarm(11,2) = -38.5/2;
swarm(12,2) = -37.5/2;
swarm(13,2) = -36.5/2;
swarm(14,2) = -34.5/2;
swarm(15,2) = -33.5/2;
swarm(16,2) = -32.5/2;
swarm(17,2) = -31.5/2;
swarm(18,2) = -30.5/2;
swarm(19,2) = -29.5/2;
swarm(20,2) = -28.5/2;
swarm(21,2) = -27.5/2;
swarm(22,2) = -26.5/2;
swarm(23,2) = -24.5/2;
swarm(24,2) = -23.5/2;
swarm(25,2) = -22.5/2;
swarm(26,2) = -21.5/2;
swarm(27,2) = -20.5/2;
swarm(28,2) = -19.5/2;
swarm(29,2) = -18.5/2;
swarm(30,2) = -17.5/2;
swarm(31,2) = -16.5/2;
swarm(32,2) = -14.5/2;
swarm(33,2) = -13.5/2;
swarm(34,2) = -12.5/2;
swarm(35,2) = -11.5/2;
swarm(36,2) = -10.5/2;
swarm(37,2) = -9.5/2;
swarm(38,2) = -8.5/2;
swarm(39,2) = -7.5/2;
swarm(40,2) = -6.5/2;
swarm(41,2) = -4.5/2;
swarm(42,2) = -3.5/2;
swarm(43,2) = -2.5/2;
swarm(44,2) = -1.5/2;
swarm(45,2) = -0.5/2;
swarm(46,2) = 0.5/2;
swarm(47,2) = 1.5/2;
swarm(48,2) = 2.5/2;
swarm(49,2) = 3.5/2;
swarm(50,2) = 5.5/2;
swarm(51,2) = 6.5/2;
swarm(52,2) = 7.5/2;
swarm(53,2) = 8.5/2;
swarm(54,2) = 9.5/2;
swarm(55,2) = 10.5/2;
swarm(56,2) = 11.5/2;
swarm(57,2) = 12.5/2;
swarm(58,2) = 13.5/2;
swarm(59,2) = 15.5/2;
swarm(60,2) = 16.5/2;
swarm(61,2) = 17.5/2;
swarm(62,2) = 18.5/2;
swarm(63,2) = 19.5/2;
swarm(64,2) = 20.5/2;
swarm(65,2) = 21.5/2;
swarm(66,2) = 22.5/2;
swarm(67,2) = 23.5/2;
swarm(68,2) = 25.5/2;
swarm(69,2) = 26.5/2;
swarm(70,2) = 27.5/2;
swarm(71,2) = 28.5/2;
swarm(72,2) = 29.5/2;
swarm(73,2) = 30.5/2;
swarm(74,2) = 31.5/2;
swarm(75,2) = 32.5/2;
swarm(76,2) = 33.5/2;
swarm(77,2) = 35.5/2;
swarm(78,2) = 36.5/2;
swarm(79,2) = 37.5/2;
swarm(80,2) = 38.5/2;
swarm(81,2) = 39.5/2;
swarm(82,2) = 40.5/2;
swarm(83,2) = 41.5/2;
swarm(84,2) = 42.5/2;
swarm(85,2) = 43.5/2;
swarm(86,2) = 45.5/2;
swarm(87,2) = 46.5/2;
swarm(88,2) = 47.5/2;
swarm(89,2) = 48.5/2;
swarm(90,2) = 49.5/2;



%% Iterations
for iter = 1 : iterations
    
    %-- position of Swarms ---
    for i = 1 : Nelem
        swarm(i, 1) = swarm(i, 1) + swarm(i, 5)/1.2 ;  %update amplitude
        swarm(i, 2) = swarm(i, 2) + swarm(i, 6)/1.2 ;    %update distance
        
        %clip distance if necessary
        if (swarm(i,2)>40)
            swarm(i,2) = 40;
        end
        if (swarm(i,2)<-40)
            swarm(i,2) = -40;
        end

        [AF] = compute(swarm, Nelem, d, cos(theta));
        U=(abs(AF)./max(abs(AF))).^2;
        Prad=2*pi*sum(U.*sin(theta).*dtheta);
        D=4*pi*U/Prad;
        DdB=10.*log10(D+eps);
        Do=max(D);
        DodB=max(DdB);

        value = (DodB - 13)^2; % objective function, here 13 is used for better performance
        
        if abs(value) < swarm(i, 7)  %if cost is less than global minimum then update best parameters         
            swarm(i, 3) = swarm(i, 1);    % update best position of amplitude,
            swarm(i, 4) = swarm(i, 2);    % update best postions of distance,
            swarm(i, 7) = value;          % best updated minimum value
        end
        
        if value<=5 %if cost is less than threshold then exit
            break;
        end
    end
    [temp, gbest] = min(swarm(:, 7));        % gbest position
    
    %--- updating velocity vectors
    for i = 1 : Nelem
        swarm(i, 5) = rand*inertia*swarm(i, 5) + correction_factor*rand*(swarm(i, 3)...
            - swarm(i, 1)) + correction_factor*rand*(swarm(gbest, 3) - swarm(i, 1));   % amplitude velocity parameters
        swarm(i, 6) = rand*inertia*swarm(i, 6) + correction_factor*rand*(swarm(i, 4)...
            - swarm(i, 2)) + correction_factor*rand*(swarm(gbest, 4) - swarm(i, 2));   % distance velocity parameters
        
        %clip velocity if necessary
        if swarm(i,5)>1
            swarm(i,5) = 1;
        end
        if swarm(i,6)>1
            swarm(i,6) = 1;
        end
    end
    
    %% Plotting the swarm
    clf
    plot(swarm(:, 2), swarm(:,1), 'x')% drawing swarm movements
    pause(.1)

    if temp<=5 %if global minimum is less than threshold then exit
        break;
    end

end

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Functions%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[AF] = compute(swarm, Nelem, d, X)
    u=2*pi*d*X;
    j = sqrt(-1);
    AF = 0;
    for i = 1:Nelem
        AF = AF + swarm(i,1) * exp(j*swarm(i,2)*u);
    end
end