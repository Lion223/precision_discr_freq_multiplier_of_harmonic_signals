% FM parameters
n = 24;
A = 3/n;
 
y(1) = 0.;
x(1) = 0.;
z(1) = 0.;

% loop x(k) for derivates x(k-1), x(k+1) 
for k = 1:102,
    x(k) = A * sin((2*pi*n*(k-1))/100);
end

% loop z, y, first and second order derivatives
for k = 2:101,
    dx = (x(k+1) - x(k-1))/2;
    dx2 = x(k+1) - 2*x(k) + x(k-1);
    y(k) = (x(k)*dx)/(sqrt(0.148* dx*dx - 0.148 * x(k) * dx2));
    z(k) = 1.3 * sin( (4*pi * n * (k-1))/100 )  ;
end

% x,y,z arrays output
x
y
z

% graphs for x,y,z
figure
plot(x)
legend('x')
axis([0, 100, -0.15, 0.15 ])

grid

figure
plot(y)
legend('y')
axis([0, 100, -0.15, 0.15 ])

grid

figure
plot(z)
legend('z')
axis([0, 100, -1.5, 1.5 ])

grid

% max. absolute error expression
a1 = abs (z - y);
fprintf('Max. abs. error:')
disp(max(a1))

% rms error expression
diff(1) = 0.;
for k = 2:101,
	diff(k) = (z(k)-y(k))^2;
end

summ = sum(diff);
sr = sqrt(summ/100);
fprintf('rms error:')

disp(sr)

% loop for x while eps = 0.0001
for k = 1:102,
    x(k) = A * sin((2* pi * (1.0001)* n * (1.0001) *(k-1))/100* (1.0001))* (1.0001);
end

% loop for y,z while eps = 0.0001
for k = 2:101,
    dx = (x(k+1) - x(k-1))/2* (5.0001);
    dx2 = x(k+1) - 2*x(k)* (1.0001) + x(k-1);
    y(k) = (x(k)* (1.0001)*dx)/(sqrt(0.148* (1.0001)* dx* (1.0001)*dx - 0.148 * (1.0001)* x(k) * dx2)* (1.0001));
    z(k) = 1.3 * sin( (4* (1.0001) *pi* (1.0001) * n * (k-1))/100 )  ;
end

% max. abs. error expression while eps = 0.0001
a2 = abs (z - y);
fprintf('Max. abs. error while eps = 0.0001:')
disp(max(a2))

% rms error expression while eps = 0.0001
diffe(1) = 0.;

for k = 2:101,
	diffe(k) = (z(k)-y(k))^2;
end
summ = sum(diffe);
sr = sqrt(summ/100);
	
fprintf('rms error while eps = 0.0001:')
disp(sr)

% worst sensitivity
for k = 1:102,
    x(k) = A * sin((2*pi*n*(k-1))/100);
end

format long 

for k = 2:101,
    dx = (x(k+1) - x(k-1))/2;
    dx2 = x(k+1) - 2*x(k) + x(k-1);
    y1(k) = (x(k)* (1.0001)*dx)/(sqrt(0.148* (1.0001)* dx* (1.0001)*dx - 0.148 * (1.0001)* x(k) * dx2)* (1.0001));
	y2(k) = (x(k)*dx)/(sqrt(0.148* dx*dx - 0.148 * x(k) * dx2));
	yy(k) = y1(k) - y2(k);
end

e = 0.0001;
m = max(yy);
worst_sens = m/e;

fprintf('Worst sensitivity:')
disp(worst_sens)