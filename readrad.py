# Program to read in radiosonde data from a file named "raob.dat"

# Import numpy since we are going to use numpy arrays and the loadtxt
# function.
import numpy as np
 
# Open the file for reading and store the file handle as "f"
# The filename is 'raob.dat'

f=open('raob.dat')
# Read the data from the file handle f.  np.loadtxt() is useful for reading
# simply-formatted text files.
datain=np.loadtxt(f)
# Close the file.
f.close();

# We can copy the different columns into
# pressure, temperature and dewpoint temperature

# Note that the colon means consider all elements in that dimension.
# and remember indices start from zero
p=datain[:,0]
temp=datain[:,1]
temp_dew=datain[:,2]

print 'Pressure: ', p
print 'Temperature: ', temp
print 'Dewpoint temperature: ', temp_dew
