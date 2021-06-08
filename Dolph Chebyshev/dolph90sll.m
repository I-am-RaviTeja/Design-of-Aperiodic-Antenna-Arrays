clear
clc

%% Initialization

iterations = 1000;
inertia = 1.0;
correction_factor = 2.0;
Nelem = 90;
d = 0.5;
theta=linspace(0,pi,1800+1);
dtheta=pi/1800;

% Initial Positions
swarm = zeros(Nelem,4);
% Description of swarm matrix
% 1st col - amplitudes
% 2nd col - best co-efficients
% 3rd col - velocity
% 4th col - local best values

%position matrix
position = zeros(Nelem,1);

%Initial Values

swarm(:, 4) = 1000;       % Greater than maximum possible value
swarm(:, 3) = 0;         % initial velocity

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
position(1,1) = -49.5;
position(2,1) = -48.5;
position(3,1) = -47.5;
position(4,1) = -46.5;
position(5,1) = -44.5;
position(6,1) = -43.5;
position(7,1) = -42.5;
position(8,1) = -41.5;
position(9,1) = -40.5;
position(10,1) = -39.5;
position(11,1) = -38.5;
position(12,1) = -37.5;
position(13,1) = -36.5;
position(14,1) = -34.5;
position(15,1) = -33.5;
position(16,1) = -32.5;
position(17,1) = -31.5;
position(18,1) = -30.5;
position(19,1) = -29.5;
position(20,1) = -28.5;
position(21,1) = -27.5;
position(22,1) = -26.5;
position(23,1) = -24.5;
position(24,1) = -23.5;
position(25,1) = -22.5;
position(26,1) = -21.5;
position(27,1) = -20.5;
position(28,1) = -19.5;
position(29,1) = -18.5;
position(30,1) = -17.5;
position(31,1) = -16.5;
position(32,1) = -14.5;
position(33,1) = -13.5;
position(34,1) = -12.5;
position(35,1) = -11.5;
position(36,1) = -10.5;
position(37,1) = -9.5;
position(38,1) = -8.5;
position(39,1) = -7.5;
position(40,1) = -6.5;
position(41,1) = -4.5;
position(42,1) = -3.5;
position(43,1) = -2.5;
position(44,1) = -1.5;
position(45,1) = -0.5;
position(46,1) = 0.5;
position(47,1) = 1.5;
position(48,1) = 2.5;
position(49,1) = 3.5;
position(50,1) = 5.5;
position(51,1) = 6.5;
position(52,1) = 7.5;
position(53,1) = 8.5;
position(54,1) = 9.5;
position(55,1) = 10.5;
position(56,1) = 11.5;
position(57,1) = 12.5;
position(58,1) = 13.5;
position(59,1) = 15.5;
position(60,1) = 16.5;
position(61,1) = 17.5;
position(62,1) = 18.5;
position(63,1) = 19.5;
position(64,1) = 20.5;
position(65,1) = 21.5;
position(66,1) = 22.5;
position(67,1) = 23.5;
position(68,1) = 25.5;
position(69,1) = 26.5;
position(70,1) = 27.5;
position(71,1) = 28.5;
position(72,1) = 29.5;
position(73,1) = 30.5;
position(74,1) = 31.5;
position(75,1) = 32.5;
position(76,1) = 33.5;
position(77,1) = 35.5;
position(78,1) = 36.5;
position(79,1) = 37.5;
position(80,1) = 38.5;
position(81,1) = 39.5;
position(82,1) = 40.5;
position(83,1) = 41.5;
position(84,1) = 42.5;
position(85,1) = 43.5;
position(86,1) = 45.5;
position(87,1) = 46.5;
position(88,1) = 47.5;
position(89,1) = 48.5;
position(90,1) = 49.5;
    
%% Iterations

for iter = 1 : iterations
    for i = 1 : Nelem
        swarm(i, 1) = swarm(i, 1) + swarm(i, 3)/1.2 ; %update amplitudes
        [AF] = compute(swarm, Nelem, d, cos(theta), position);
        U=(abs(AF)./max(abs(AF))).^2;
        AFdB=10.*log10(U);
        TF = islocalmax(AFdB(1:895));%store all local maxima postions in TF
        mat = AFdB(TF);% storing all local maxima values
        if size(mat) == 0 %if no local maxima
             break;
        end
        sll = max(mat);
        value = (sll + 18.67)^2; % objective function

        if abs(value)<abs(swarm(i,4))%if cost is less than global minimum then update best parameters
            swarm(i,2) = swarm(i,1);
            swarm(i,4) = value;
        end
        if abs(value)<=10%if cost is less than threshold then exit
            break;
        end
    end

    [temp, gbest] = min(swarm(:, 4));        % gbest position
    
    for i = 1 : Nelem
        swarm(i, 3) = rand*inertia*swarm(i, 3) + correction_factor*rand*(swarm(i, 2) - swarm(i, 1)) + correction_factor*rand*(swarm(gbest, 2) - swarm(i, 1));%amplitude velocity parameters
        
        %clip velocity if necessary
        if swarm(i,3)>1
            swarm(i,3) = 1;
        end
    end
    % Plotting the swarm
    clf    
    plot(swarm(:, 1), 'x')   % drawing swarm movements
    pause(.1)
    if abs(temp)<=10 %if global minimum is less than threshold then exit
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

%% Functions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Functions%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[AF] = compute(swarm, Nelem, d, X, Pmat)
    u=2*pi*d*X;
    AF = 0;
    for i = 1:Nelem
        AF = AF + swarm(i,1) * complex(cos(Pmat(i)*u), sin(Pmat(i)*u));
    end
end