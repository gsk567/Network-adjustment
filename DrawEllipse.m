function DrawEllipse(xo,yo,a,b,phi)
i = 0;
phi = -phi;
sizeTita = length(0:pi/180:2*pi);
X = zeros(sizeTita,1);
Y = zeros(sizeTita,1);
for tita = 0:pi/180:2*pi
    i = i+1;
   X(i) = xo+b*cos(tita)*cos(phi/(200/pi))-a*sin(tita)*sin(phi/(200/pi));
   Y(i) = yo+b*cos(tita)*sin(phi/(200/pi))+a*sin(tita)*cos(phi/(200/pi));
end

plot(X,Y,'LineWidth',0.5,'Color','b')
end
