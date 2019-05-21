The MATLAB code provided plots the measurement model of the MAV

To plot the noise in radial measurements. In matlab run,

``` radial_measurement_plot.m```

To plot the noise in bearing measurements. In matlab run,

``` bearing_measurement_plot.m ```

To plot the noise in inclination measurements. In matlab run, 

``` inclination_measurement_plot.m ```

The recorded and analyzed rosbags for modeling noise in measurements are available  here: https://owncloud.tuebingen.mpg.de/index.php/s/HFMfTAtgiJbceQZ 

Download the folders  <experiment_name>_<run_information>.bag.analysis/ 

The mat files used for plotting the noise and its variance can be generated using the scripts files:

``` <name>_preprocessing.m ```

To regenerate the .mat files used for plotting, substitute <name> with radial , bearing , or inclination 

To rerun the gazebo simulations please refer to the documentation  of https://github.com/AIRCAP/AIRCAP
