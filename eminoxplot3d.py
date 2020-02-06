# -*- coding: utf-8 -*-
"""
Created on Thu Nov 09 15:27:19 2017

@author: Beth
"""

import numpy as np
import matplotlib.pyplot as plt
import time
from datetime import date, timedelta
from mpl_toolkits.basemap import Basemap, shiftgrid, addcyclic
from netCDF4 import Dataset as ncfile
import matplotlib.colors as colors
from matplotlib.mlab import bivariate_normal

#historical data
fname = '' + \
    'eminox_ACCMIP-monthly_CICERO-OsloCTM2_accrcp26_r1i1p1_210001-210012.nc'


  
nc = ncfile(fname)


lons = nc.variables['lon'][:]
lats = nc.variables['lat'][:]
#levs = nc.variables['lev'][:]
months = nc.variables['time'][:]
nox = nc.variables['eminox'][:, :, :]

#
nox = nox*3.154e13  # Convert to kg/km^2/year


nox, lons = addcyclic(nox, lons)
nox, lons = shiftgrid(180, nox, lons, start=False)

# convert months variable to a calendar date
startdate = np.datetime64('1850-01-01')
dates = startdate + np.array(months, dtype='timedelta64[D]')

#levs = levs*1e3  # Convert height levels to hPa

#setup the plot
plt.figure(figsize=(11, 8))
plt.tick_params(direction='out', which='both')
clevs = np.array([0., 10., 20., 30., 40., 50., 60., 70., 80., 90., 100.])
clevs=clevs*10
mymap = Basemap(projection='cyl', llcrnrlon=-180, urcrnrlon=180,
                llcrnrlat=-90, urcrnrlat=90,
                lon_0=0, lat_0=0, resolution='c')
x, y = mymap(*np.meshgrid(lons, lats))

level = 0
month = 7 - 1
#
# contour the data
cs = mymap.contourf(x, y, nox[month, :, :], clevs, cmap='Reds', extend='both')
cb=plt.colorbar(orientation='horizontal', aspect=75, pad=0.08, ticks=clevs)
cb.set_label(label='(kg/km^2/year)', fontsize=10)
cs = mymap.contour(x, y, nox[month, :, :], clevs, colors='k')
plt.clabel(cs, fmt='%d', colors='k', fontsize=10)



# axes
plt.xticks(np.arange(-180, 210, 60),
           ['180', '120W', '60W', '0', '60W', '120W', '180'])
plt.yticks(np.arange(-90, 120, 30),
           ['90S', '60S', '30S', '0', '30N', '60N', '90N'])


# coastlines and title
mymap.drawcoastlines()
plt.title('NOx emissions in 2100 (RCP 2.6)')
plt.show()
