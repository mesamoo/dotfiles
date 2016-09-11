#!/usr/bin/env python

#=========================================================================================
#   Written by damo, feb 2012
#   Use as you like :)
#=========================================================================================
#
#   Python script to set per-desktop background wallpaper for Openbox WM, without the need to
#   add shell commands to key and mouse bindings.
#
#   This code uses 'xprop' to get the current desktop, then 'feh' to set the wallpaper
#
#  ( See 'feh' man page for options, which can be entered as fields in the subprocess.call() )
#==========================================================================================
#   USAGE   python /path/to/switchbg.py [options] (or make it executable and put in PATH)
#
#           [option 1] : /path/to/wallpaper/directory/
#           [option 2] : -s (switch desktop backgrounds) / -r (random wallpaper)
#           [option 3] : secs (time to poll xprop - 0.25 works OK for switch,
#                                                   any amount for random change)
#
#   eg 'python switchbg.py /home/damo/wallpaper/ -s 0.25' : set desktop'n' background to
#                                                        'nth' image in sorted file list;
#                                                        run xprop every 0.25 secs
#
#      ''python switchbg.py /home/damo/wallpaper/ -r 360' : change background to random
#                                                           image from directory, every 360 secs
#
#   Add to OB autostart as eg
#   (sleep 2s && python /path/to/switchbg.py /path/to/wallpaper/directory/ -s 0.2) &
#
#=========================================================================================

import time,subprocess
import sys,os
import random

def get_args():
    '''Parse commandline args; add to myargs list, which is returned to _init_'''
    args = sys.argv                                     #Get args from sys module
    myargs = []
    option = str()
    for i in args:
        if os.path.isdir(i):                            # path to wallpaper directory
            myargs.append(i)
        elif i == '-r':                                 # switch desktops, or random
            option = ' random'
            myargs.append(i)
        elif i == '-s':
            option = ' switch'
            myargs.append(i)
        try:            # test if time input(string) can be converted to float(required by sleep() )
          float(i)
        except ValueError, TypeError:
            pass
        else:
            t = float(i)
            myargs.append(t)
    return myargs

def get_desktops():
    '''Use xprop to determine number of desktops;
        return int'''

    xp = 'xprop -root _NET_NUMBER_OF_DESKTOPS | tail -c -2'
    proc = subprocess.Popen(xp,stdout=subprocess.PIPE,shell=True)# subprocess: pipe to stdout
    dnum = proc.communicate()[0]        # output is tuple, so get first val (desktop number)
    return int(dnum)                    # number of desktops cardinal = 0,1,2,3...

def get_images(wp):
    '''Get list of images from wallpaper directory;
        Append to list; sort list and return it'''
    images = []
    for i in os.listdir(wp):
        i = os.path.join(wp,i)          # get full filepath for each image
        images.append(i)                # add to list
        images.sort()                   # listdir order may seem arbitrary, so sort list
    return images

def xprop_pipe(wp,opts,t,imgs):
    '''Params are   path to wallpaper directory;
                    None, or random background;
                    time to wait between xprop calls,
                    list of images in wallpaper directory.
        
        Run xprop subprocess in an endless loop. It gets the current desktop as a string from
        stdout. The desktop number (0,1,2,3...) is the last field (cardinal), which is extracted
        with 'tail';
        communicate() returns a tuple, so we want the first value and discard the '\n';
        If the cardinal has changed, call set_bg() to change the wallpaper.
        If random wallpaper option has been set, then generate a random choice from the number
        of files in the wallpaper directory; use this to set image list index with set_bg()'''

    dtop = 0 # set initial desktop number (flag)
    xp = 'xprop -root _NET_CURRENT_DESKTOP | tail -c -2'# set xprop shell command

    if opts == None:                           # -s chosen 
        while True:
            proc = subprocess.Popen(xp,stdout=subprocess.PIPE,shell=True)# subprocess: pipe to stdout
            curr_dtop = proc.communicate()[0]  # output is tuple, so get first val (desktop number)
            curr_dtop = int(curr_dtop)         # current desktop cardinal = 0,1,2,3...
            if curr_dtop != dtop:              # if cardinal has changed....
                set_bg(curr_dtop,imgs)         # ....call set_bg func
                dtop = curr_dtop               # set the flag to current desktop               
            time.sleep(t)                      # wait for t secs (from args)

    else:                                       #  random choice selected
        while True:
            num = random.choice(range(len(os.listdir(wp))))# select random index from 
            set_bg(num,imgs)                                #   num of files in dir
            time.sleep(t)                                   # wait for t secs (from args)

def set_bg(i,imgs):
    '''params are image list file index, image list;
        Run 'feh' shell command to set wallpaper for current desktop'''

    bg = imgs[i]                            # get background image path from image list
#=== ( See feh man pages for options: each should be in its own comma-separated quoted field) ====#
    subprocess.call(['feh','--bg-scale','--no-xinerama',bg],)# sub.call can be passed a list of strings as
#===    subprocess.call(['hsetroot','-fill',bg],)# sub.call can be passed a list of strings as  ====#
                                             # commandline input - no need to escape spaces etc

if __name__ == '__main__':
    '''commandline arguments are filepath to wallpaper directory [arg 1];
                                    per desktop or random backgrounds[arg 2];
                                    polling time (secs)[arg 3]'''
    args = get_args()           # Parse commandline args and append to args list
    wp = args[0]                # path to wallpaper directory
    option = args[1]            # switch background per desktop, or random background
    t = args[2]                 # time between xprop polls (secs)
    dnum = get_desktops()       # get number of desktops - used to get image list index
    images = get_images(wp)     # get list of image files from wallpaper directory

    subprocess.call(['feh','--bg-scale',images[0]])  # set initial background to first file

    if option == '-s':          # If option is to switch desktops
        opts = None
    elif option == '-r':        # random feh bg slideshow
        opts = dnum

    xprop_pipe(wp,opts,t,images)# run xprop_pipe()
