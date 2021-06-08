clear
clc

%% Initialization
iterations = 1000;
inertia = 1.0;
correction_factor = 2.0;
Nelem = 80;
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
swarm(:, 5) = 0;          % initial velocity
swarm(:, 6) = 0;          % initial velocity

%Initial Co-efficients 
swarm(:,1) = 1;

%Initial Positions
swarm(1,2) = -49.5/2;
swarm(2,2) = -48.5/2;
swarm(3,2) = -46.5/2;
swarm(4,2) = -44.5/2;
swarm(5,2) = -43.5/2;
swarm(6,2) = -42.5/2;
swarm(7,2) = -41.5/2;
swarm(8,2) = -40.5/2;
swarm(9,2) = -39.5/2;
swarm(10,2) = -38.5/2;
swarm(11,2) = -36.5/2;
swarm(12,2) = -34.5/2;
swarm(13,2) = -33.5/2;
swarm(14,2) = -32.5/2;
swarm(15,2) = -31.5/2;
swarm(16,2) = -30.5/2;
swarm(17,2) = -29.5/2;
swarm(28,2) = -28.5/2;
swarm(19,2) = -26.5/2;
swarm(20,2) = -24.5/2;
swarm(21,2) = -23.5/2;
swarm(22,2) = -22.5/2;
swarm(23,2) = -21.5/2;
swarm(24,2) = -20.5/2;
swarm(25,2) = -19.5/2;
swarm(26,2) = -18.5/2;
swarm(27,2) = -17.5/2;
swarm(28,2) = -16.5/2;
swarm(29,2) = -14.5/2;
swarm(30,2) = -13.5/2;
swarm(31,2) = -12.5/2;
swarm(32,2) = -11.5/2;
swarm(33,2) = -10.5/2;
swarm(34,2) = -8.5/2;
swarm(35,2) = -7.5/2;
swarm(36,2) = -6.5/2;
swarm(37,2) = -4.5/2;
swarm(38,2) = -3.5/2;
swarm(39,2) = -1.5/2;
swarm(40,2) = -0.5/2;
swarm(41,2) = 0.5/2;
swarm(42,2) = 1.5/2;
swarm(43,2) = 2.5/2;
swarm(44,2) = 3.5/2;
swarm(45,2) = 5.5/2;
swarm(46,2) = 6.5/2;
swarm(47,2) = 8.5/2;
swarm(48,2) = 9.5/2;
swarm(49,2) = 10.5/2;
swarm(50,2) = 11.5/2;
swarm(51,2) = 12.5/2;
swarm(52,2) = 13.5/2;
swarm(53,2) = 15.5/2;
swarm(54,2) = 17.5/2;
swarm(55,2) = 18.5/2;
swarm(56,2) = 19.5/2;
swarm(57,2) = 20.5/2;
swarm(58,2) = 21.5/2;
swarm(59,2) = 22.5/2;
swarm(60,2) = 23.5/2;
swarm(61,2) = 25.5/2;
swarm(62,2) = 26.5/2;
swarm(63,2) = 27.5/2;
swarm(64,2) = 28.5/2;
swarm(65,2) = 29.5/2;
swarm(66,2) = 30.5/2;
swarm(67,2) = 31.5/2;
swarm(68,2) = 33.5/2;
swarm(69,2) = 35.5/2;
swarm(70,2) = 36.5/2;
swarm(71,2) = 37.5/2;
swarm(72,2) = 38.5/2;
swarm(73,2) = 39.5/2;
swarm(74,2) = 40.5/2;
swarm(75,2) = 42.5/2;
swarm(76,2) = 43.5/2;
swarm(77,2) = 45.5/2;
swarm(78,2) = 46.5/2;
swarm(79,2) = 47.5/2;
swarm(80,2) = 49.5/2;


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
        
        %clip amplitude if necessary
        if swarm(i,1) > 4
            swarm(i,1) = 4;
        end
        if swarm(i,1) < -4
            swarm(i,1) = -4;
        end    

        [AF] = compute(swarm, Nelem, d, cos(theta));
        U=(abs(AF)./max(abs(AF))).^2;
        Prad=2*pi*sum(U.*sin(theta).*dtheta);
        D=4*pi*U/Prad;
        DdB=10.*log10(D+eps);
        Do=max(D);
        DodB=max(DdB);

        value = (DodB - 20)^2; % objective function
        
        if abs(value) < swarm(i, 7)   %if cost is less than global minimum then update best parameters        
            swarm(i, 3) = swarm(i, 1);    % update best position of u,
            swarm(i, 4) = swarm(i, 2);    % update best postions of v,
            swarm(i, 7) = value;          % best updated minimum value
        end
        if value<=4 %if cost is less than threshold then exit
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

    if temp<=4 %if global minimum is less than threshold then exit
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
