clear
clc

%% Initialization

iterations = 1000;
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
dx = 1;
dy = 1;

% Initial Positions
swarm = zeros(NelemX,13);
% Description of swarm matrix
% 1st col - x-direction amplitude
% 2nd col - y-direction amplitude
% 3rd col - x-direction distance
% 4th col - y-direction distance
% 5th col - best x-direction coefficients
% 6th col - best y-direction coefficients
% 7th col - best x-direction distance
% 8th col - best y-direction distance
% 9th col - x-direction amplitude velocity
% 10th col - y-direction amplitude velocity
% 11th col - x-direction distance velocity
% 12th col - y-direction distance velocity
% 13th col - Global minimum value

% Initial values
swarm(:, 13) = 40;       % Greater than maximum possible value
swarm(:, 9) = 0.5; 
swarm(:, 10) = 0.5;
swarm(:, 11) = 0.5;
swarm(:, 12) = 0.5;

%Initial Co-efficients 
swarm(:,1) = 1;
swarm(:,2) = 1;

%Initial Positions in x-direction
swarm(1,3) = 1/2;
swarm(2,3) = 2/2;
swarm(3,3) = 3/2;
swarm(4,3) = 4/2;
swarm(5,3) = 6/2;%<==>
swarm(6,3) = 7/2;
swarm(7,3) = 8/2;
swarm(8,3) = 9/2;
swarm(9,3) = 10/2;
swarm(10,3) = 11/2;
swarm(11,3) = 12/2;
swarm(12,3) = 13/2;
swarm(13,3) = 14/2;
swarm(14,3) = 15/2;
swarm(15,3) = 17/2;%<==>
swarm(16,3) = 18/2;
swarm(17,3) = 19/2;
swarm(18,3) = 20/2;
swarm(19,3) = 21/2;
swarm(20,3) = 22/2;
swarm(21,3) = 23/2;
swarm(22,3) = 24/2;
swarm(23,3) = 25/2;
swarm(24,3) = 26/2;
swarm(25,3) = 28/2;%<==>
swarm(26,3) = 29/2;
swarm(27,3) = 30/2;
swarm(28,3) = 31/2;
swarm(29,3) = 32/2;
swarm(30,3) = 33/2;
swarm(31,3) = 34/2;
swarm(32,3) = 35/2;
swarm(33,3) = 36/2;
swarm(34,3) = 37/2;
swarm(35,3) = 39/2;%<==>
swarm(36,3) = 40/2;
swarm(37,3) = 41/2;
swarm(38,3) = 42/2;
swarm(39,3) = 43/2;
swarm(40,3) = 44/2;
swarm(41,3) = 45/2;
swarm(42,3) = 46/2;
swarm(43,3) = 47/2;
swarm(44,3) = 48/2;
swarm(45,3) = 50/2;%<==>
swarm(46,3) = 51/2;
swarm(47,3) = 52/2;
swarm(48,3) = 53/2;
swarm(49,3) = 54/2;
swarm(50,3) = 55/2;
swarm(51,3) = 56/2;
swarm(52,3) = 57/2;
swarm(53,3) = 58/2;
swarm(54,3) = 59/2;
swarm(55,3) = 61/2;%<==>
swarm(56,3) = 62/2;
swarm(57,3) = 63/2;
swarm(58,3) = 64/2;
swarm(59,3) = 65/2;
swarm(60,3) = 66/2;
swarm(61,3) = 67/2;
swarm(62,3) = 68/2;
swarm(63,3) = 69/2;
swarm(64,3) = 70/2;
swarm(65,3) = 72/2;%<==>
swarm(66,3) = 73/2;
swarm(67,3) = 74/2;
swarm(68,3) = 75/2;
swarm(69,3) = 76/2;
swarm(70,3) = 77/2;
swarm(71,3) = 78/2;
swarm(72,3) = 79/2;
swarm(73,3) = 80/2;
swarm(74,3) = 81/2;
swarm(75,3) = 83/2;%<==>
swarm(76,3) = 84/2;
swarm(77,3) = 85/2;
swarm(78,3) = 86/2;
swarm(79,3) = 87/2;
swarm(80,3) = 88/2;
swarm(81,3) = 89/2;
swarm(82,3) = 90/2;
swarm(83,3) = 91/2;
swarm(84,3) = 92/2;
swarm(85,3) = 94/2;%<==>
swarm(86,3) = 95/2;
swarm(87,3) = 96/2;
swarm(88,3) = 97/2;
swarm(89,3) = 98/2;
swarm(90,3) = 99/2;

%Initial Positions in y-direction
swarm(1,4) = 1/2;
swarm(2,4) = 2/2;
swarm(3,4) = 3/2;
swarm(4,4) = 4/2;
swarm(5,4) = 6/2;%<==>
swarm(6,4) = 7/2;
swarm(7,4) = 8/2;
swarm(8,4) = 9/2;
swarm(9,4) = 10/2;
swarm(10,4) = 11/2;
swarm(11,4) = 12/2;
swarm(12,4) = 13/2;
swarm(13,4) = 14/2;
swarm(14,4) = 15/2;
swarm(15,4) = 17/2;%<==>
swarm(16,4) = 18/2;
swarm(17,4) = 19/2;
swarm(18,4) = 20/2;
swarm(19,4) = 21/2;
swarm(20,4) = 22/2;
swarm(21,4) = 23/2;
swarm(22,4) = 24/2;
swarm(23,4) = 25/2;
swarm(24,4) = 26/2;
swarm(25,4) = 28/2;%<==>
swarm(26,4) = 29/2;
swarm(27,4) = 30/2;
swarm(28,4) = 31/2;
swarm(29,4) = 32/2;
swarm(30,4) = 33/2;
swarm(31,4) = 34/2;
swarm(32,4) = 35/2;
swarm(33,4) = 36/2;
swarm(34,4) = 37/2;
swarm(35,4) = 39/2;%<==>
swarm(36,4) = 40/2;
swarm(37,4) = 41/2;
swarm(38,4) = 42/2;
swarm(39,4) = 43/2;
swarm(40,4) = 44/2;
swarm(41,4) = 45/2;
swarm(42,4) = 46/2;
swarm(43,4) = 47/2;
swarm(44,4) = 48/2;
swarm(45,4) = 50/2;%<==>
swarm(46,4) = 51/2;
swarm(47,4) = 52/2;
swarm(48,4) = 53/2;
swarm(49,4) = 54/2;
swarm(50,4) = 55/2;
swarm(51,4) = 56/2;
swarm(52,4) = 57/2;
swarm(53,4) = 58/2;
swarm(54,4) = 59/2;
swarm(55,4) = 61/2;%<==>
swarm(56,4) = 62/2;
swarm(57,4) = 63/2;
swarm(58,4) = 64/2;
swarm(59,4) = 65/2;
swarm(60,4) = 66/2;
swarm(61,4) = 67/2;
swarm(62,4) = 68/2;
swarm(63,4) = 69/2;
swarm(64,4) = 70/2;
swarm(65,4) = 72/2;%<==>
swarm(66,4) = 73/2;
swarm(67,4) = 74/2;
swarm(68,4) = 75/2;
swarm(69,4) = 76/2;
swarm(70,4) = 77/2;
swarm(71,4) = 78/2;
swarm(72,4) = 79/2;
swarm(73,4) = 80/2;
swarm(74,4) = 81/2;
swarm(75,4) = 83/2;%<==>
swarm(76,4) = 84/2;
swarm(77,4) = 85/2;
swarm(78,4) = 86/2;
swarm(79,4) = 87/2;
swarm(80,4) = 88/2;
swarm(81,4) = 89/2;
swarm(82,4) = 90/2;
swarm(83,4) = 91/2;
swarm(84,4) = 92/2;
swarm(85,4) = 94/2;%<==>
swarm(86,4) = 95/2;
swarm(87,4) = 96/2;
swarm(88,4) = 97/2;
swarm(89,4) = 98/2;
swarm(90,4) = 99/2;

%% Iterations

for iter = 1 : iterations
    for i = 1 : NelemX
        swarm(i, 1) = swarm(i, 1) + swarm(i, 9)/1.2 ; %update x amplitude
        swarm(i, 2) = swarm(i, 2) + swarm(i, 10)/1.2 ; %update y amplitude
        swarm(i, 3) = swarm(i, 3) + swarm(i, 11)/1.2 ; %update x distance
        swarm(i, 4) = swarm(i, 4) + swarm(i, 12)/1.2 ; %update y distance
        
        %clip values if necessary
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

        [AF] = compute(swarm, NelemX, NelemY, dx, dy, theta, phi, j, k, deltax, deltay);
        U=(abs(AF)./max(abs(AF))).^2;
        AFdB=10.*log10(U);
        TF = islocalmax(AFdB(1:895)); %store all local maxima postions in TF
        mat = AFdB(TF); % storing all local maxima values
        if size(mat) == 0 %if no local maxima
             break;
         end
         sll = max(mat); %max value of local maxima is taken as sidelobe level for better result
        value = (sll + 33)^2; % objective function, here 33 is taken for better reduction in sll

        if abs(value)<abs(swarm(i,13)) %if cost is less than global minimum then update best parameters
            swarm(i,5) = swarm(i,1);
            swarm(i,6) = swarm(i,2);
            swarm(i,7) = swarm(i,3);
            swarm(i,8) = swarm(i,4);
            swarm(i,13) = abs(value);
        end
        if value<=1 %if cost is less than threshold then exit
            break;
        end
    end

    [temp, gbest] = min(swarm(:, 13));        % gbest position
    
    for i = 1 : NelemX
        
        swarm(i, 9) = rand*inertia*swarm(i, 9) + correction_factor*rand*(swarm(i, 5)...
            - swarm(i, 1)) + correction_factor*rand*(swarm(gbest, 5) - swarm(i, 1));   % x-direction amplitude velocity parameters
        swarm(i, 10) = rand*inertia*swarm(i, 10) + correction_factor*rand*(swarm(i, 6)...
            - swarm(i, 2)) + correction_factor*rand*(swarm(gbest, 6) - swarm(i, 2));   % y-direction amplitude velocity parameters
        swarm(i, 11) = rand*inertia*swarm(i, 11) + correction_factor*rand*(swarm(i, 7)...
            - swarm(i, 3)) + correction_factor*rand*(swarm(gbest, 7) - swarm(i, 3));   % x-direction distance velocity parameters
        swarm(i, 12) = rand*inertia*swarm(i, 12) + correction_factor*rand*(swarm(i, 8)...
            - swarm(i, 4)) + correction_factor*rand*(swarm(gbest, 8) - swarm(i, 4));   % y-direction distance velocity parameters
        
        %clip velocity if necessary
        if swarm(i,9)>1
            swarm(i,9) = 1;
        end
        if swarm(i,10)>1
            swarm(i,10) = 1;
        end
        if swarm(i,11)>1
            swarm(i,11) = 1;
        end
        if swarm(i,12)>1
            swarm(i,12) = 1;
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
xlabel(['Angle',' (degrees)']),ylabel('ARRAY FACTOR(dB)')
grid on;

% Radiation Pattern Plot:
figure
polar(theta, U);
hold on
polar(-theta, U);

%% Functions

function[AF] = compute(swarm, NelemX, NelemY, dx, dy, theta, phi, j, k, deltax, deltay)

    psix=(-k*dx*sin(theta).*sin(phi))+deltax;
    psiy=(-k*dy*cos(theta))+ deltay;
    
    AFx=0;
    AFy=0;
    for m=1:NelemX
    AFx= AFx+ swarm(m,1)*exp(j*(swarm(m,3)-1)*psix);
    end
    for n=1:NelemY
        AFy=AFy+ swarm(n,2)*exp(j*(swarm(n,4)-1)*psiy);
    end
    AF=AFx.*AFy;
end
