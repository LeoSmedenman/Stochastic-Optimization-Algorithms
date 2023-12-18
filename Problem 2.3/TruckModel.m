%% TruckModel
clear
close
clc

%% Pre Processing
slopeLength = 1000; 
alphaMax = 10; 
g = 9.82;      

deltaTimeStep = 0.2; 
x = 0;       
vStart = 20; 
vMax = 25;   
vMin = 1;    

Tmax = 750; 
ambientT = 283;   
Tb = 500;  
deltaTb = Tb - ambientT; 

M = 20000;     
tau = 30;   
c = 3;
Ch = 40;       
Cb = 3000;    

gear = 3; 
Feb = [7.0*Cb, 5.0*Cb, 4.0*Cb, 3.0*Cb, 2.5*Cb, 2.0*Cb, 1.6*Cb, 1.4*Cb, 1.2*Cb, 1.0*Cb];

%% weights
nIn = 3;
nHidden = 4;
nOut = 2;
wMax = 5;

% Adjust the weight matrix dimensions
wIH = randi([-5, 5], nHidden, nIn + 1);
wHO = randi([-5, 5], nOut, nHidden + 1);

%% Simulate truck
velocityVector = [];
v = vStart;

while x <= slopeLength
    alpha = GetSlopeAngle(x, 1, 1);
    
    chromosome = EncodeNetwork(wIH, wHO, wMax);
    [deltaGear, Pp] = RunFFNNOptimization(v, alpha, Tb, chromosome);
    gear = gear+deltaGear;
    
    
    if gear > 10
        gear = 10;
    elseif gear < 1
        gear = 1;
    end
    
    if v >= vMax
        Pp = 1;
    end
    
    if Pp < 0.01
        deltaTb = deltaTb - deltaTb / tau * deltaTimeStep;
    else
        deltaTb = deltaTb + Ch * Pp * deltaTimeStep;
    end

    % Update Tb based on deltaTb, but constrain it within [ambientT, Tmax]
    Tb = ambientT + deltaTb;

    if Tb < ambientT
        Tb = ambientT;
    elseif Tb >= Tmax
        Pp = 0;   
    end

    if Tb < Tmax - 100
        F_b = M * g / 20 * Pp;
    else
        F_b = M * g / 20 * Pp * exp(-(Tb - (Tmax - 100))/100);
    end
    
    F_g = M * g * sind(alpha);
    
    acceleration = (F_g - F_b - Feb(gear)) / M;
    
    % Update velocity
    v = acceleration * deltaTimeStep + v;  

    % Update position
    x = v * deltaTimeStep + x;

    % Append the current velocity to velocityVector
    velocityVector = [velocityVector v];
    
end
plot(velocityVector)

% FITNESS
distance = x; % Update this accordingly based on your problem
fitness = mean(velocityVector) * distance;
