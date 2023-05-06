# **Single-shooting-optimal-control**

An optimal control problem for a cart system is solved using single shooting method. The optimal control problem is discretized and transformed to a nonlinear optimization problem and solved using the state of the art solver IPOPT.

# Requirements
-MATLAB/OCTAVE
-Casadi


# Problem description

The optimal control problem for the cart system is provided below. z1 and z2 are the position and velocity of the cart and they comprise the states. f is the force applied and there is a drag force which is proportional to the velocity of the cart. The system starts from rest and additional boundary condition is placed at the end of the trajectory. Along the trajectory the control effort is minimized from time 0 to 2.

![image](https://user-images.githubusercontent.com/16457676/236567436-9d87b891-e74f-4299-802c-a394693c1f60.png)

# Analytical solution

The system admits the following analytical solution, which later can be used to verify the numerical solution and its accuracy.

![image](https://user-images.githubusercontent.com/16457676/236629178-b6da4837-b1d8-454d-9ec4-2d67fb1abeba.png)

# Discretization

The time domain is discretized and a piecewise constant control is assumed over each discretization interval. Using the initial condition for the states, the dynamics are integrated forward in time using a suitable numerical method like Euler foward, ruge kutta 45 etc. This follows a difference equation and the states are represented as a function of the control inputs. Similarly the integral in the objective function is discretized using a riemann sum or a sutable method. The nonlinear constraints are only evaluated at the grid points. Collectively, this results in a nonlinear optimization problem which can be solved using a off-the-shelf solver. Here, we haveused IPOPT for finding the optimal solution. The following figure illustrates the method, where q represents the discrete control inputs and x the state.

![image](https://user-images.githubusercontent.com/16457676/236629948-21ff2fb0-ab18-4f30-9996-298230e685be.png)

# Results

The results are plotted in phase space for a grid size of 50 and they are in close agreement with the analytical solution.
![image](https://user-images.githubusercontent.com/16457676/236630435-26ad7bcb-c5c5-4c6d-a366-9bd5ce6f8922.png)



# Known issues

Although for simple problems this methods well, for more complex systems with higher nonlinearities it has been known to cause convergence issues for the solver. This is beacause the nonlinearity gets accumulated for every subsequent state when they are expressed as a function of the control input. As a result, Newton method based solvers like IPOPT which uses linearization at each iteration struggles with convergence due to poor approximation.

