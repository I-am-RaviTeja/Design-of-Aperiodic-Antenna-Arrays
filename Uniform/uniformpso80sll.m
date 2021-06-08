clear
clc

%% Initialization

iterations = 1000;
inertia = 1.0;
correction_factor = 2.0;
Nelem = 80;
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
swarm(:, 3) = 1;         % initial velocity

%Initial Co-efficients 
swarm(:, 1) = 1;

%Initial Positions
position(1,1) = -49.5;
position(2,1) = -48.5;
position(3,1) = -46.5;
position(4,1) = -44.5;
position(5,1) = -43.5;
position(6,1) = -42.5;
position(7,1) = -41.5;
position(8,1) = -40.5;
position(9,1) = -39.5;
position(10,1) = -38.5;
position(11,1) = -36.5;
position(12,1) = -34.5;
position(13,1) = -33.5;
position(14,1) = -32.5;
position(15,1) = -31.5;
position(16,1) = -30.5;
position(17,1) = -29.5;
position(28,1) = -28.5;
position(19,1) = -26.5;
position(20,1) = -24.5;
position(21,1) = -23.5;
position(22,1) = -22.5;
position(23,1) = -21.5;
position(24,1) = -20.5;
position(25,1) = -19.5;
position(26,1) = -18.5;
position(27,1) = -17.5;
position(28,1) = -16.5;
position(29,1) = -14.5;
position(30,1) = -13.5;
position(31,1) = -12.5;
position(32,1) = -11.5;
position(33,1) = -10.5;
position(34,1) = -8.5;
position(35,1) = -7.5;
position(36,1) = -6.5;
position(37,1) = -4.5;
position(38,1) = -3.5;
position(39,1) = -1.5;
position(40,1) = -0.5;
position(41,1) = 0.5;
position(42,1) = 1.5;
position(43,1) = 2.5;
position(44,1) = 3.5;
position(45,1) = 5.5;
position(46,1) = 6.5;
position(47,1) = 8.5;
position(48,1) = 9.5;
position(49,1) = 10.5;
position(50,1) = 11.5;
position(51,1) = 12.5;
position(52,1) = 13.5;
position(53,1) = 15.5;
position(54,1) = 17.5;
position(55,1) = 18.5;
position(56,1) = 19.5;
position(57,1) = 20.5;
position(58,1) = 21.5;
position(59,1) = 22.5;
position(60,1) = 23.5;
position(61,1) = 25.5;
position(62,1) = 26.5;
position(63,1) = 27.5;
position(64,1) = 28.5;
position(65,1) = 29.5;
position(66,1) = 30.5;
position(67,1) = 31.5;
position(68,1) = 33.5;
position(69,1) = 35.5;
position(70,1) = 36.5;
position(71,1) = 37.5;
position(72,1) = 38.5;
position(73,1) = 39.5;
position(74,1) = 40.5;
position(75,1) = 42.5;
position(76,1) = 43.5;
position(77,1) = 45.5;
position(78,1) = 46.5;
position(79,1) = 47.5;
position(80,1) = 49.5;

%% Iterations

for iter = 1 : iterations
    for i = 1 : Nelem
        swarm(i, 1) = swarm(i, 1) + swarm(i, 3)/1.2 ; %update amplitude
        
        %clip amplitude if needed
        if swarm(i,1) > 4
            swarm(i,1) = 4;
        end
       if swarm(i,1) < -4
            swarm(i,1) = -4;
       end
        [AF] = compute(swarm, Nelem, d, cos(theta), position);
        U=(abs(AF)./max(abs(AF))).^2;
        AFdB=10.*log10(U);
        
        TF = islocalmax(AFdB(1:895));%store all local maxima postions in TF
        mat = AFdB(TF);% storing all local maxima values
        if size(mat) == 0 %if no local maxima
             break;
         end
         sll = max(mat);
         
        value = (sll + 17)^2; % objective function

        if abs(value)<abs(swarm(i,4))%if cost is less than global minimum then update best parameters
            swarm(i,2) = swarm(i,1);
            swarm(i,4) = value;
        end
        if abs(value)<=2 %if cost is less than threshold then exit
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
    if abs(temp)<=2 %if global minimum is less than threshold then exit
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
