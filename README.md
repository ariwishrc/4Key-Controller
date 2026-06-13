<div align="center"><img width="110" height="115" alt="4key" src="https://github.com/user-attachments/assets/b4bdefee-3d3e-4ad8-a6e3-062136e7e73c" />

# 4Key Controller
Android app built with Godot Engine to play games on PC via UDP

> Still in a basic prototype but usable for playing games that needs up to 4-key
</div>

---

## Requirements
To use 4Key Controller, you also need to install and run the **4Key Server** on your PC.  
Get it here: [github.com/ariwishrc/4Key-Server](https://github.com/ariwishrc/4Key-Server)

---

## How to Run
1. Clone and run the [4Key Server](https://github.com/ariwishrc/4Key-Server)
2. Install this app from Releases and run it
3. Make sure both your phone and PC are on the same network
4. In this app, click settings and put IP to your PC local IP (you can see it from the [4Key Server](https://github.com/ariwishrc/4Key-Server) too)
5. Remember to use the same port in this mobile app and the server
6. Done!

---
 
## Inputs Not Registering?
 
This is most likely caused by your firewall blocking incoming UDP packets. Here's how to allow the app through:
 
**Windows:**
```
Open Windows Defender Firewall -> Advanced Settings -> Inbound Rules -> New Rule -> Port -> UDP -> 8000 -> Allow the connection
 ```
**macOS:**
```
System Settings -> Network -> Firewall -> Options -> Add the 4Key Server app and allow incoming connections
```
**Linux:**
```
sudo ufw allow 8000
```
 
---

## Contributing
As this project is still a massive W.I.P prototype, the codebase is subject to major structural changes. 
Contributions are currently on hold until the features marked as **crucial** below are implemented.

### Devs Notes
- You can run the project in godot without a phone, since they are on the same device use IP 127.0.0.1.
- You can also use [Godot one-click deploy](https://docs.godotengine.org/en/stable/tutorials/export/one-click_deploy.html) for testing.

---

## Features Plan

- [ ] Adding & Removing buttons support (crucial)
- [ ] Toggled buttons (crucial)
- [ ] Custom hitbox size, icons, colors, shape and outline for each buttons (crucial)
- [ ] Volume buttons as input (enhancement)
- [ ] QR code as input for IP and Port (enhancement)
- [ ] Grid-based edit mode (enhancement)
- [ ] Fix Launcher art (enhancement)

---

## Credit
Friday Night' Funkin Game for inspiration and the arrows assets (as a placeholder currently)
