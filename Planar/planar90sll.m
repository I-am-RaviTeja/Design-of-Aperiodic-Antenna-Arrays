clear
clc

%% Initialization

iterations = 10;
inertia = 1.0;
correction_factor = 2.0;

NelemX=90;
NelemY=90;

j=sqrt(-1);
M=1801; %Angle resolution
k=2*pi; %wavenumber
theta=linspace(0,pi,M);
phi=linspace(-pi/2,pi/2,M);
deltax = 0;
deltay = 0;
dx = 0.5;
dy = 0.5;

% Initial Positions
swarm = zeros(NelemX,7);
% Description of swarm matrix
% 1st col - x-direction co-efficients
% 2nd col - y-direction co-efficients
% 3rd col - updated x-direction coefficients
% 4th col - updated y-direction coefficients
% 5th col - x-direction velocity
% 6th col - y-direction velocity
% 7th col - Global minimum value

posx = zeros(NelemX, 1);
posy = zeros(NelemY, 1);

% Initial values
swarm(:, 7) = 40;       % Greater than maximum possible value
swarm(:, 5) = 0.5;
swarm(:, 6) = 0.5;

%Initial Co-efficients 
swarm(:,1) = 1;
swarm(:,2) = 1;

%Initial Positions in x-direction
posx(1,1) = 1;
posx(2,1) = 2;
posx(3,1) = 3;
posx(4,1) = 4;
posx(5,1) = 6;%<==>
posx(6,1) = 7;
posx(7,1) = 8;
posx(8,1) = 9;
posx(9,1) = 10;
posx(10,1) = 11;
posx(11,1) = 12;
posx(12,1) = 13;
posx(13,1) = 14;
posx(14,1) = 15;
posx(15,1) = 17;%<==>
posx(16,1) = 18;
posx(17,1) = 19;
posx(18,1) = 20;
posx(19,1) = 21;
posx(20,1) = 22;
posx(21,1) = 23;
posx(22,1) = 24;
posx(23,1) = 25;
posx(24,1) = 26;
posx(25,1) = 28;%<==>
posx(26,1) = 29;
posx(27,1) = 30;
posx(28,1) = 31;
posx(29,1) = 32;
posx(30,1) = 33;
posx(31,1) = 34;
posx(32,1) = 35;
posx(33,1) = 36;
posx(34,1) = 37;
posx(35,1) = 39;%<==>
posx(36,1) = 40;
posx(37,1) = 41;
posx(38,1) = 42;
posx(39,1) = 43;
posx(40,1) = 44;
posx(41,1) = 45;
posx(42,1) = 46;
posx(43,1) = 47;
posx(44,1) = 48;
posx(45,1) = 50;%<==>
posx(46,1) = 51;
posx(47,1) = 52;
posx(48,1) = 53;
posx(49,1) = 54;
posx(50,1) = 55;
posx(51,1) = 56;
posx(52,1) = 57;
posx(53,1) = 58;
posx(54,1) = 59;
posx(55,1) = 61;%<==>
posx(56,1) = 62;
posx(57,1) = 63;
posx(58,1) = 64;
posx(59,1) = 65;
posx(60,1) = 66;
posx(61,1) = 67;
posx(62,1) = 68;
posx(63,1) = 69;
posx(64,1) = 70;
posx(65,1) = 72;%<==>
posx(66,1) = 73;
posx(67,1) = 74;
posx(68,1) = 75;
posx(69,1) = 76;
posx(70,1) = 77;
posx(71,1) = 78;
posx(72,1) = 79;
posx(73,1) = 80;
posx(74,1) = 81;
posx(75,1) = 83;%<==>
posx(76,1) = 84;
posx(77,1) = 85;
posx(78,1) = 86;
posx(79,1) = 87;
posx(80,1) = 88;
posx(81,1) = 89;
posx(82,1) = 90;
posx(83,1) = 91;
posx(84,1) = 92;
posx(85,1) = 94;%<==>
posx(86,1) = 95;
posx(87,1) = 96;
posx(88,1) = 97;
posx(89,1) = 98;
posx(90,1) = 99;

%Initial Positions in y-direction
posy(1,1) = 1;
posy(2,1) = 2;
posy(3,1) = 3;
posy(4,1) = 4;
posy(5,1) = 6;%<==>
posy(6,1) = 7;
posy(7,1) = 8;
posy(8,1) = 9;
posy(9,1) = 10;
posy(10,1) = 11;
posy(11,1) = 12;
posy(12,1) = 13;
posy(13,1) = 14;
posy(14,1) = 15;
posy(15,1) = 17;%<==>
posy(16,1) = 18;
posy(17,1) = 19;
posy(18,1) = 20;
posy(19,1) = 21;
posy(20,1) = 22;
posy(21,1) = 23;
posy(22,1) = 24;
posy(23,1) = 25;
posy(24,1) = 26;
posy(25,1) = 28;%<==>
posy(26,1) = 29;
posy(27,1) = 30;
posy(28,1) = 31;
posy(29,1) = 32;
posy(30,1) = 33;
posy(31,1) = 34;
posy(32,1) = 35;
posy(33,1) = 36;
posy(34,1) = 37;
posy(35,1) = 39;%<==>
posy(36,1) = 40;
posy(37,1) = 41;
posy(38,1) = 42;
posy(39,1) = 43;
posy(40,1) = 44;
posy(41,1) = 45;
posy(42,1) = 46;
posy(43,1) = 47;
posy(44,1) = 48;
posy(45,1) = 50;%<==>
posy(46,1) = 51;
posy(47,1) = 52;
posy(48,1) = 53;
posy(49,1) = 54;
posy(50,1) = 55;
posy(51,1) = 56;
posy(52,1) = 57;
posy(53,1) = 58;
posy(54,1) = 59;
posy(55,1) = 61;%<==>
posy(56,1) = 62;
posy(57,1) = 63;
posy(58,1) = 64;
posy(59,1) = 65;
posy(60,1) = 66;
posy(61,1) = 67;
posy(62,1) = 68;
posy(63,1) = 69;
posy(64,1) = 70;
posy(65,1) = 72;%<==>
posy(66,1) = 73;
posy(67,1) = 74;
posy(68,1) = 75;
posy(69,1) = 76;
posy(70,1) = 77;
posy(71,1) = 78;
posy(72,1) = 79;
posy(73,1) = 80;
posy(74,1) = 81;
posy(75,1) = 83;%<==>
posy(76,1) = 84;
posy(77,1) = 85;
posy(78,1) = 86;
posy(79,1) = 87;
posy(80,1) = 88;
posy(81,1) = 89;
posy(82,1) = 90;
posy(83,1) = 91;
posy(84,1) = 92;
posy(85,1) = 94;%<==>
posy(86,1) = 95;
posy(87,1) = 96;
posy(88,1) = 97;
posy(89,1) = 98;
posy(90,1) = 99;

%% Iterations

for iter = 1 : iterations
    for i = 1 : NelemX
        swarm(i, 1) = swarm(i, 1) + swarm(i, 5)/1.2 ; %update x amplitude
        swarm(i, 2) = swarm(i, 2) + swarm(i, 6)/1.2 ; %update y amplitude
        
        %clip amplitudes if necessary
        if swarm(i,1) > 4
            swarm(i,1) = 4;
        end
        if swarm(i,1) < -4
            swarm(i,1) = -4;
        end
        if swarm(i,2) > 4
            swarm(i,2) = 4;
        end
        if swarm(i,2) < -4
            swarm(i,2) = -4;
        end
        
        [AF] = compute(swarm, NelemX, NelemY, dx, dy, theta, phi, posx, posy, j, k, deltax, deltay);
        U=(abs(AF)./max(abs(AF))).^2;
        AFdB=10.*log10(U);
        TF = islocalmax(AFdB(1:895));%store all local maxima postions in TF
        mat = AFdB(TF); % storing all local maxima values
        if size(mat) == 0 %if no local maxima
             break;
         end
         sll = max(mat);
        value = (sll + 30)^2; % objective function, here 30 is taken for better reduction in sll

        if abs(value)<abs(swarm(i,7))%if cost is less than global minimum then update best parameters
            swarm(i,3) = swarm(i,1);
            swarm(i,4) = swarm(i,2);
            swarm(i,7) = abs(value);
        end
        if value<=1%if cost is less than threshold then exit
            break;
        end
    end

    [temp, gbest] = min(swarm(:, 7));        % gbest position
    
    for i = 1 : NelemX
        swarm(i, 5) = rand*inertia*swarm(i, 5) + correction_factor*rand*(swarm(i, 3)...
            - swarm(i, 1)) + correction_factor*rand*(swarm(gbest, 3) - swarm(i, 1));   % x-direction amplitude velocity parameters
        swarm(i, 6) = rand*inertia*swarm(i, 6) + correction_factor*rand*(swarm(i, 4)...
            - swarm(i, 2)) + correction_factor*rand*(swarm(gbest, 4) - swarm(i, 2));   % y-direction amplitude velocity parameters
        %clip velocity if necessary
        if swarm(i,5)>1
            swarm(i,5) = 1;
        end
        if swarm(i,6)>1
            swarm(i,6) = 1;
        end
    end
    % Plotting the swarm
    clf    
    plot(swarm(:, 1), 'x')   % drawing swarm movements
    pause(.1)
    if temp<=1 %if global minimum is less than threshold then exit
        break;
    end
end


%% Figures

% Array Factor dB Plot:
figure
U=(abs(AF)./max(abs(AF))).^2;
AFdB=10.*log10(U);
plot(theta*180/pi, AFdB,'m','linewidth',2);
axis([75 105 max(min(AFdB)-1,-60) 1]);
xlabel(['\theta',' (degrees)']),ylabel('ARRAY FACTOR(dB)')
grid on;

% Radiation Pattern Plot:
figure
polar(theta, U);
hold on
polar(-theta, U);

%% Functions

function[AF] = compute(swarm, NelemX, NelemY, dx, dy, theta, phi, posx, posy, j, k, deltax, deltay)

    psix=(-k*dx*sin(theta).*sin(phi))+deltax;
    psiy=(-k*dy*cos(theta))+ deltay;
    
    AFx=0;
    AFy=0;
    for m=1:NelemX
    AFx= AFx+ swarm(m,1)*exp(j*(posx(m,1)-1)*psix);
    end
    for n=1:NelemY
        AFy=AFy+ swarm(n,2)*exp(j*(posy(n,1)-1)*psiy);
    end
    AF=AFx.*AFy;
end