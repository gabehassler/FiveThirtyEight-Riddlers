# -*- coding: utf-8 -*-
"""
Created on Fri Jul 14 11:18:40 2017

@author: gabeh
"""

import h5py
import plotly.plotly as py
import plotly.graph_objs as go


file = h5py.File("squishyball_data.h5", "r")
g = file["data"]
xs = list(g['x'])
ys = list(g['y'])

trace = go.Scatter(x=xs, y=ys)
py.plot([trace])




