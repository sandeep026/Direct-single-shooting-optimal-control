clear
close all
import casadi.*

% problem constants
T=2;
a=1;
b=-2.694528;
c=-1.155356;

% grid size
N=50;
opti=Opti();

% decision variables
U=opti.variable(1,N);

% intial condition
X0=[0;0];

% state vector accumulation using RK 45
X=[X0];

% length of a control interval
dt = T/N; 

% loop over N control intervals
for k=1:N 
% Runge-Kutta 4 integration
    x=X(:,end);
    k1 = ode_fun(x,         U(:,k));
    k2 = ode_fun(x+dt/2*k1, U(:,k));
    k3 = ode_fun(x+dt/2*k2, U(:,k));
    k4 = ode_fun(x+dt*k3,   U(:,k));
    x_next = x + dt/6*(k1+2*k2+2*k3+k4);
% Euler forward    
%   x_next=x+dt*(ode_fun(x,U(:,k)));
    X=[X x_next];
end

% Objective function
obj=dt*sum(U.^2);

% Optimization problem construction
opti.minimize(obj)
opti.subject_to(a*X(1,end)+b*X(2,end)-c==0)

%IPOPT solver
opti.solver('ipopt')
sol=opti.solve();
X=sol.value(X);
U=sol.value(U);


% Compare the numerical and analytical solution
t=linspace(0,2,N+1);
X=sol.value(X);
U=sol.value(U);
[Xa,Ua]=analytical_solution(t);
plot(Xa(1,:),Xa(2,:))
hold on
scatter(X(1,:),X(2,:))
grid
xlabel('$x_1$')
ylabel('$x_2$')
legend('analytical','single shooting','Location','northwest')

figure
plot(t,Ua)
hold on
stairs(t,[U U(:,end)])
legend('analytical','single shooting','Location','northwest')


 
