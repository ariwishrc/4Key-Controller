<img width="110" height="115" alt="4key" src="https://github.com/user-attachments/assets/b4bdefee-3d3e-4ad8-a6e3-062136e7e73c" />

# 4Key Controller
an Android app built with godot engine to play games on PC via UDP
to use this you also need to install and run the 4Key Server on your PC at https://github.com/ariwishrc/4Key-Server

Still in a very basic prototype but usable for playing games that needs up to 4-key

# Features Plan
- QR code as input for IP and port (enhancement)
- Multi-buttons support (crucial)
- Toggled button (crucial)
- Custom icons in each buttons (enhancement)
- Different Hitbox size for each buttons (crucial)
- Joystick buttons (enhancement)
- Grid-based edit mode (enhancement)
- Fix Launcher art (enhancement)
- Play Store and Ads/Pro for monetizing (???)


# How to run
1. clone the repo
2. run the app on mobile/pc
3. if on pc since they are on the same device use ip 127.0.0.1 
4. if on phone either export https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html /download apk from releases (easiest) /remote deploy https://docs.godotengine.org/en/stable/tutorials/export/one-click_deploy.html

# The input don't register in the server?
this is most likely because firewall blocked the network packets from arriving so here is how to unblock it
Windows:

MacOS:

Linux:
sudo ufw allow 8000


# Credit
friday night' funkin for inspiration (the fnf mobile input) and the arrows assets (as a placeholder currently)
