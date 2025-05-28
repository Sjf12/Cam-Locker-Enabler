Webcam Security Research Toolkit
Overview
This toolkit contains two PowerShell scripts designed for security researchers and scam baiters to explore webcam access controls and user behavior in controlled, authorized environments. The scripts are:

Enum-Cam.ps1: A script to block webcam access by terminating webcam-related processes (e.g., Zoom, Windows Camera) without requiring administrative privileges. It simulates software-level webcam restrictions for testing purposes.This tool can enumerate cam devices within the system and can enable/disable the cam functionality.
Cam-Forcer.ps1: A script that embeds Python code to force webcam activation by repeatedly prompting the user via a GUI (using tkinter) until the webcam is opened. It supports Windows, Linux, and macOS, and is designed to study user responses to forced access prompts.It is great for scam baiting where if you want to turn on cam the script loops the permission to access the cam until the user gives permisssion.

Note: These scripts are for educational and authorized security research purposes only. Unauthorized use to interfere with systems, networks, or user privacy is illegal and unethical.
Features
Enum-Cam.ps1

List Webcam Processes: Displays running processes that may access the webcam (e.g., WindowsCamera, Zoom, Skype).
Lock Webcam Access: Terminates known webcam-related processes to prevent applications from using the webcam.
Test Webcam Access: Checks if the webcam is still accessible by attempting to launch the Windows Camera app.
Non-Admin Operation: Runs without elevated permissions, making it suitable for user-level testing.
Interactive Menu: Provides a command-line interface to select actions.

Cam-Forcer.ps1

Forced Webcam Activation: Uses a tkinter GUI to repeatedly prompt the user to enable the webcam until they comply or the script is terminated.
Cross-Platform Support: Opens the default camera application on:
Windows: Microsoft Windows Camera (microsoft.windows.camera).
Linux: Cheese (cheese).
macOS: Photo Booth (Photo Booth.app).


Persistent Prompting: Displays a warning about "system overheating" to simulate a scenario requiring user action, continuing until the camera is opened.
Error Handling: Shows an error for unsupported operating systems and handles camera launch failures.

Requirements

Operating System:
Both scripts: Windows 10 or later (tested on Windows 10/11).
lock.ps1: Also supports Linux and macOS (requires Python and tkinter).


PowerShell: Version 5.1 or higher (included with Windows).
Python (for lock.ps1): Python 3.x with tkinter installed (python3-tk on Linux, typically included with Python on Windows/macOS).
Webcam: A webcam (internal or external) recognized by the operating system.
Privileges:
CamLocker.ps1: No administrative privileges required.
lock.ps1: No administrative privileges required, but Python execution must be allowed.



Installation

Clone or Download:
Copy both CamLocker.ps1 and lock.ps1 to a project directory (e.g., C:\Users\DELL\Documents\Python-Projects\CAM-Locker).


PowerShell Execution Policy:
Ensure PowerShell allows running scripts:Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned


Run in a PowerShell prompt and confirm with Y if prompted.




Python Setup (for Cam-Forcer.ps1):
Install Python 3.x if not already present (download from python.org).
Ensure tkinter is available:
Windows/macOS: Typically included with Python.
Linux: Install with sudo apt-get install python3-tk (Debian/Ubuntu) or equivalent.


Verify Python is in your system PATH by running python --version in PowerShell.


Directory Setup:
Save both scripts in the same directory for ease of use.



Usage
Enum-Cam.ps1

Run the Script:
Open PowerShell (no admin rights needed):cd C:\Users\DELL\Documents\Python-Projects\CAM-Locker
.\Enum-Cam.ps1




Interact with the Menu:
Select an option (1-4):
1: List running webcam-related processes (e.g., Zoom, WindowsCamera).
2: Block webcam access by terminating these processes.
3: Test if the webcam is accessible by launching the Camera app.
4: Exit the script.


Example:Webcam Locker for Security Research (Non-Admin)
-----------------------------------
1. List webcam-related processes
2. Lock (block) webcam access
3. Test webcam access
4. Exit
-----------------------------------
Enter your choice (1-4): 2




Verify Results:
After selecting option 2, try opening Zoom or the Windows Camera app to confirm the webcam is inaccessible.
Use option 3 to check if the block is effective.



Cam-Forcer.ps1

Run the Script:
Open PowerShell:cd C:\Users\DELL\Documents\Python-Projects\CAM-Locker
.\Cam-Forcer.ps1


Ensure Python is installed and accessible via the python command.


Interact with the Prompt:
A tkinter messagebox will appear with a "Heat Warning" asking to enable the camera.
Click Yes to open the default camera app (e.g., Windows Camera on Windows).
If you click No, the prompt will reappear after a 1-second delay until the camera is opened.
If the OS is unsupported, an error message will appear.


Verify Results:
On successful camera activation, the script prints "Camera access granted! Continuing execution..." and exits.
Test with different applications (e.g., Zoom, Skype) to observe behavior after forced activation.



Technical Details

Enum-Cam.ps1:
Uses Get-Process and Stop-Process to manage webcam-related processes (WindowsCamera, Zoom, ms-teams, etc.).
Monitors a predefined list of processes, customizable via the $webcamProcesses array.
Tests webcam access by attempting to launch the Windows Camera app.


Cam-Forcer.ps1:
Embeds Python code executed via PowerShell’s python command.
Uses tkinter for GUI prompts and subprocess to launch OS-specific camera applications.
Implements a loop to persistently prompt the user until the camera is opened.
Handles cross-platform differences with platform.system() checks.



Troubleshooting

Enum-Cam.ps1:
No Webcam Processes Found:
Add relevant process names to the $webcamProcesses array if your webcam application isn’t listed.
Run Get-Process | Where-Object { $_.MainWindowTitle -like "*camera*" } to identify other processes.


Webcam Still Accessible:
The script only terminates known processes. Other applications or system services may still access the webcam.
For hardware-level disabling, use an admin-based script (available in earlier versions).




Cam-Forcer.ps1:
Python Not Found:
Ensure Python is installed and added to the system PATH (python --version should work).
Update the script to use python3 if that’s the command on your system (e.g., Linux).


tkinter Not Found:
Install tkinter on Linux (sudo apt-get install python3-tk) or reinstall Python with GUI support.


Camera App Doesn’t Open:
Verify the camera app exists (e.g., WindowsCamera on Windows, Cheese on Linux).
Check webcam drivers in Device Manager (devmgmt.msc).


Unsupported OS:
The script only supports Windows, Linux, and macOS. For other OSes, modify the open_camera() function.




General:
Ensure the PowerShell execution policy allows scripts (Get-ExecutionPolicy).
Check for markdown artifacts (e.g., ````powershell`) in the script files.



Ethical Considerations

Authorized Use Only: Use these scripts only on systems you own or have explicit permission to test. Unauthorized interference with webcams or processes may violate privacy laws or policies.
Research Context:
CamLocker.ps1: Suitable for testing application-level webcam security or simulating restricted environments.
lock.ps1: Useful for studying user behavior under forced access prompts or testing camera activation vulnerabilities.


Responsible Disclosure: If vulnerabilities are identified (e.g., bypassing process termination or persistent camera access), report them through proper channels.
User Privacy: lock.ps1’s forced activation could be intrusive. Use it only in controlled environments with informed consent.
Limitations:
CamLocker.ps1 is limited to known processes and cannot prevent system-level or admin access.
lock.ps1 relies on user interaction and OS-specific camera apps, which may not cover all scenarios.



Limitations

Enum-Cam.ps1:
Only affects predefined processes; other applications may access the webcam.
Less secure than hardware-level disabling (requires admin privileges).


Cam-Forcer.ps1:
Requires Python and tkinter, adding setup complexity.
May not force camera access if the default camera app is unavailable or blocked.
Persistent prompting may be bypassed by closing the script or application.


General: Effectiveness depends on the system configuration, webcam drivers, and running applications.

Integration with Other Projects

These scripts can complement your Google Dorking project (GD-Website.html) by testing local webcam security against vulnerabilities found online (e.g., exposed webcam feeds via inurl:webcam).
Consider adding a web interface to your Google Dorking tool to trigger these scripts (requires a backend like Node.js or Python Flask).

Disclaimer
This toolkit is provided for educational and authorized security research purposes only. The creators are not responsible for any misuse or unauthorized use. Always adhere to legal and ethical guidelines when conducting security research.
Acknowledgments

Enum-Cam.ps1: Built using PowerShell process management cmdlets.
Cam-Forcer.ps1: Utilizes Python’s tkinter and subprocess for cross-platform camera activation.
Inspired by the need to explore webcam security in controlled research environments, complementing tools like the Google Dorking Educational Website.

