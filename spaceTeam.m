clear
clc

% Constants
mSat =        2000; % 2000 kg satellite
mE =    5.97219e24; % 5.97219 × 10^24 kg Earth
G =    6.67430e-11; % G = 6.67430 x 10^-11 N*m^2/kg^2
rEarth =    6357e3; % 6357 km in meters Radius of Earth(meters)
rEtoM =   384400e3; % 384,400km from Earth to Moon from center to center(meters)
rMoon =   1738.1e3; % Radius of moon in meters

% Variables
totTime = 1000000;
delTime = 1; 
timeSteps = totTime/delTime;

x(1) = 0; % initial x-position
y(1) = (0.2* rEtoM); % initial y-position

vx(1) =   sqrt(G*mE/y(1)) ;  % initial x-velocity
vy(1) =   0;  % initial y-velocity

s(1) = sqrt(x(1)^2  + y(1)^2); % dist. bwt. Earth and Sat

ax(1) = -(1/mSat) * (G*mE*mSat/(s(1)^2)) * (x(1)/s(1)); % Acceleration in x-axis
ay(1) = -(1/mSat) * (G*mE*mSat/(s(1)^2)) * (y(1)/s(1)); % Acceleration in y-axis

for n = 1: timeSteps
    x(n+1) = x(n) + vx(n) * delTime;
    y(n+1) = y(n) + vy(n) * delTime;
    
    vx(n+1) = vx(n) + ax(n) * delTime;
    vy(n+1) = vy(n) + ay(n) * delTime;
    
    s(n+1) = sqrt(x(n+1)^2 + y(n+1)^2);
    
    if(s(n+1) < rEarth)
        disp("CRASH!!!")
        break;
    elseif (s(n+1) > rEtoM)
        disp("Satellite flew away...")
        break;
    else
        ax(n+1) = -(1/mSat) * (G*mE*mSat/(s(n+1)^2)) * (x(n+1)/s(n+1)); 
        ay(n+1) = -(1/mSat) * (G*mE*mSat/(s(n+1)^2)) * (y(n+1)/s(n+1));
    end
end

figure
hold on
axis equal

d1 = rEarth*2;
px1 = 0 - rEarth;
py1 = 0 - rEarth;
rectangle('Position', [px1 py1 d1 d1], 'Curvature', [1,1], 'FaceColor', 'green');

d2 = rMoon*2;
px2 = (rEarth + rEtoM) - rMoon;
py2 = (rEarth + rEtoM) - rMoon;
rectangle('Position', [px2 py2 d2 d2], 'Curvature', [1,1], 'FaceColor', 'red');
%plot(x,y)
comet(x,y)


    
    





