# What for
Scripts to identify the onset of luminance change collected by two or more photodiodes.
One of the photodiodes is collecting luminance change due to occlusion of a vibrating object,
while the other is measuring luminance change of a screen or a LED.

I will identify the onset using the following methods:
    1. thresholding the amplitude (iSolution = 0)
    2. thresholding the amplitude (iSolution = 2)
    2. thresholding the change in power on one frequency which is computed using wtc toolbox (iSolution = 3)
    3. ... to be added if there are some other methods

# What file
## /onset_detection/ (the main part)
Detect the onset of signal change of interest.
* Run sc.m and input a number to do one of the operations below:
    * Input 1 to choose a dataset: run sc_main.m
        An interactive plot with two control panels will appear. 
        The two panels are for two data channels, respectively. 
        You can play with the values for each parameter (including trial number and channel number) separately for each channel.
    * Input 2 to save the parameters you have modified into .xlsx files
        They will be automatically loaded in future usage of sc_main.m
    * Input 3 to perform onset detection on all trials in the currently selected data set (if qViewTrialByTrial = true, a preview of the onset for each trial will be displayed in a new figure)


## /Preprocessing/: to be implemented later
The data are screenshots of a tektronix oscilloscope collected using a home-made matlab script.
The screenshots could only catch one channel at a time, and there is a time lag between requesting and saveing screenshots for multiple channels.
This part of scripts will allign data from different channels assuming the time lag between a neighboring request is shorter than one cycle of the oscilloscope (1 second here).

**All existing data have been preprocessed, so I leave rewriting this part for now and am going to rewrite the onset detection part first.**


# License
These scripts are naive. Please feel free to use them if you want, but I'm not responsible for any correction, updates of these scripts since no one pays me for that.
I will appreciate it if anyone could point out any helpfult updates.
I will implement them only if I will.
Thanks!
Sam Z. S.