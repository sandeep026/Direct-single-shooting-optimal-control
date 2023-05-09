# Numerical optimal control- Single-shooting

An optimal control problem for a cart system is solved using single shooting method. The optimal control problem is discretized and transformed to a nonlinear optimization problem and solved using the IPOPT solver.

# Requirements
1. MATLAB/[OCTAVE](https://octave.org/)
2. [Casadi](https://web.casadi.org/)

# Problem description

The optimal control problem for the cart system [^1] is provided below.The states are z<sub>1</sub> and z<sub>2</sub>, which are the the position and velocity of the cart, respectively. f is the force applied and there is a drag force which is proportional to the velocity of the cart. The system starts from rest and an additional boundary condition is placed at the end of the trajectory. Along the trajectory the control effort is minimized from time 0 to 2.

![image](https://user-images.githubusercontent.com/16457676/236567436-9d87b891-e74f-4299-802c-a394693c1f60.png)

# Analytical solution

The system admits the following analytical solution, which can be later used to verify the numerical solution and its accuracy.

![image](https://user-images.githubusercontent.com/16457676/236629178-b6da4837-b1d8-454d-9ec4-2d67fb1abeba.png)

# Discretization

The time domain is discretized and a piecewise constant control is assumed over each discretization interval. Using the initial condition for the states, the dynamics are integrated forward in time using a suitable numerical method like Euler foward, ruge kutta 45 etc. This follows a difference equation and the states are represented as a function of the control inputs. Similarly the integral in the objective function is discretized using a riemann sum or a sutable method. The nonlinear constraints are only evaluated at the grid points. Collectively, this results in a nonlinear optimization problem which can be solved using a off-the-shelf solver. Here, we haveused IPOPT for finding the optimal solution. The following figure [^2] illustrates the method, where q represents the discrete control inputs and x the state.

![image](https://user-images.githubusercontent.com/16457676/236629948-21ff2fb0-ab18-4f30-9996-298230e685be.png)

# Results

The results are plotted in phase space for a grid size of 200 and they are in close agreement with the analytical solution.

![image](https://github.com/sandeep026/Single-shooting-optimal-control/assets/16457676/fdd3bac6-e866-4300-8dcc-cc5924e10047)

![image](https://github.com/sandeep026/Single-shooting-optimal-control/assets/16457676/9bcdb07c-e4d3-4117-8086-dea87b1737be)

|Method|Optimal objective value|
|---|---|
|Analytical|0.577678|
|Numerical|0.5779|

The slight difference is due to discretization error which can be reduced to an extent. The peicewise approximation of the control input is one of the reason.

# Advantages

Since, its a sequential method, the control inputs are the only decision variables. As a result, smaller sized optimization problems are solved.


# Known issues

1. Although for simple problems this methods well, for more complex systems with higher nonlinearities it has been known to cause convergence issues for the solver. This is beacause the nonlinearity gets accumulated for every subsequent state when they are expressed as a function of the control input. As a result, Newton method based solvers like IPOPT which uses linearization at each iteration struggles with convergence due to poor approximation. For more details, the [^3] can be referred where an indepth discussion of the issue and a solution to mitigate the issue is presented.
2. The optimization problem is dense and sparsity cannot be exploited (in some cases depends on the objective and constraint function like example problem solved here)

# References

[^1]: Conway, B. A. and K. Larson (1998). Collocation versus differential inclusion in direct optimization. Journal of Guidance, Control, and Dynamics, 21(5), 780–785

[^2]: Diehl, M., & Gros, S. (2011). Numerical optimal control. Optimization in Engineering Center (OPTEC).

[^3]: Albersmeyer, J., & Diehl, M. (2010). The lifted Newton method and its application in optimization. SIAM Journal on Optimization, 20(3), 1655-1684.
