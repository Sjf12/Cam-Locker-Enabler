$python_code = @'
import tkinter as tk
from tkinter import messagebox
import subprocess
import platform
import time

def open_camera():
    """Opens the camera based on the OS."""
    if platform.system() == "Windows":
        subprocess.run("start microsoft.windows.camera:", shell=True)
    elif platform.system() == "Linux":
        subprocess.run("cheese", shell=True)
    elif platform.system() == "Darwin":
        subprocess.run("open /System/Applications/Photo Booth.app", shell=True)
    else:
        messagebox.showerror("Error", "Unsupported OS")
        return False  # Camera could not be opened

    return True  # Camera successfully opened

def wait_for_camera():
    """Keeps asking the user to enable the camera until they do so."""
    root = tk.Tk()
    root.withdraw()  # Hide the main window

    while True:
        response = messagebox.askyesno(
            "Heat Warning",
            "Your system is overheating!\nEnable your camera to continue.\n\nClick 'Yes' to enable the camera."
        )

        if response:
            if open_camera():
                break  # Exit the loop only if the camera opens
        else:
            messagebox.showinfo("Warning", "Camera access is required to continue!")

        time.sleep(1)  # Prevent rapid messagebox spam

wait_for_camera()

# Your main code continues here
print("Camera access granted! Continuing execution...")
'@

# Run Python code in memory
$python_code | python
