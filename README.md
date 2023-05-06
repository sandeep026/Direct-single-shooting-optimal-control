# Single-shooting-optimal-control

An optimal control problem for a cart system is solved using single shooting method. The optimal control problem is discretized and transformed to a nonlinear optimization problem and solved using the state of the art solver IPOPT.

# Requirements
MATLAB/OCTAVE

Casadi


# Problem description

The optimal control problem for the cart system is provided below. z1 and z2 are the position and velocity of the cart and they comprice the states. f is the force applied and there is a drag force which is proportional to the velocity of the cart. The system starts from rest and additional boundary condition is placed at the end of the trajectory.

![image](https://user-images.githubusercontent.com/16457676/236567436-9d87b891-e74f-4299-802c-a394693c1f60.png)

