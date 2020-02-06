# Program to perform integration of the Newtonian cooling
# differential equation using the explicit method.
import numpy as np
import matplotlib.pyplot as plt

# define the physical constants
# initial value of T (unit=C)
temp0=80.0
# decay constant (unit=1/minute) - note that "lambda" has a special meaning
# in python, so we have chosen another name
lambda_decay=0.1

# define the numerical constants
dt=2.0     # time-step (unit=minutes)
n=20       # number of steps

# declare arrays to store the results
time=np.zeros(n+1)          # time
temp_explicit=np.zeros(n+1) # temperature calculated using explicit method
temp_exact=np.zeros(n+1)    # exact temperature

# fill in the initial values of the arrays
time[0]=0.0
temp_explicit[0]=temp0
temp_exact[0]=temp0

# use a loop to fill in the remaining values of the arrays
for i in range(n):
   time[i+1]=time[i]+dt
   temp_explicit[i+1]=temp_explicit[i]*(1-lambda_decay*dt)
   temp_exact[i+1]=temp0*np.exp(-lambda_decay*time[i+1])

# print the results in the Python console
print temp_explicit
print temp_exact

# plot the results
plt.plot(time,temp_explicit,time,temp_exact)
plt.xlabel('t (minutes)')
plt.ylabel('T (K)')
plt.legend(('Explicit method','Exact solution'))
plt.title('Solution of the Newtonian cooling differential equation')
plt.show()
