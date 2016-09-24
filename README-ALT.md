# dotfiles
Config files and pekwm themes

Goals:
Clean, consistant look
    easily distinguish between overlapping windows
    easily distinguish between active and inactive windows
    window resizing without fighting to grab edge of window (just right border width)
    reduce wasted space while retaining readability (designed for 1920x1080 resolution)
    reasonably nice appearance with light or dark gui
    look nice with or without compositing
    try to reduce number of fonts required in system 
    (fira, or arimo for theme), 
    (hack, dejavu, bitstream vera and oxygen elsewhere but working to reduce these)
    
Additional Goal
    Clean configuration file so that others can easily modify and learn from
    (Use hack or other monospace font when editting for clean easily viewed layout)
    
    to get most from my pekwm themes your autoproperties file should be modified
    If you choose to use mine you should review the modified properties, specifically:
        thunderbird mail, no close button, (minimize only)
        email clients open on virt desktop 2
        most web browsers open on own virt desktop
        web browsers have no close button, (minimize only)
        a few other misc tunings
        
    for me, autoproperties is a challenge, usually it works as expected
    occasionally does not do what I expect, so autoproperties is included 
    

These themes have been designed using a monitor resolution of 1920x1280. Some editting may (will) be required for lower resolutions. (Reduce font sizes by about 6 points for 1024x768 resolution) Reduce title height by same amount. Reducing title height may require scaling some buttons as well for proper spacing

PekWM Auto-properties have been used to force some applications to open on specific virtual desktops and to prevent some applications from accidentally being closed.
(Close button removed or replaced with minimize button, especially thunderbird and most web browsers) 

Autoproperties are dependent on theme support,
If auto-properties file does not reference specific decors, defaultdecor will be used.
(all apps will use same decor and open using default config)

Ideas, learned from, and  some graphics taken from:
    AxonKolors
    semitif
    NeoMotif
    Gulfstream
    GreenBars
    Magni
    magic night
    playbillblue
    
    
