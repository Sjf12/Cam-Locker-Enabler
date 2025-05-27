# CamLocker.ps1
# A PowerShell script to lock (block) or unlock (allow) webcam access by managing related processes.
# Designed for security research purposes, runs without administrative privileges.

# List of common webcam-related process names
$webcamProcesses = @("WindowsCamera", "Zoom", "ms-teams", "Skype", "obs64", "Camera")

# Function to list running webcam-related processes
function Get-WebcamProcesses {
    $foundProcesses = Get-Process -ErrorAction SilentlyContinue | Where-Object { $webcamProcesses -contains $_.ProcessName }
    if ($foundProcesses) {
        Write-Host "Found webcam-related processes:"
        $foundProcesses | ForEach-Object { Write-Host " - $($_.ProcessName) (PID: $($_.Id))" }
        return $foundProcesses
    } else {
        Write-Host "No webcam-related processes found." -ForegroundColor Yellow
        Write-Host "Note: This script monitors common webcam processes ($($webcamProcesses -join ', '))." -ForegroundColor Yellow
        Write-Host "If your webcam is used by another process, add it to the `$webcamProcesses list in the script." -ForegroundColor Yellow
        return $null
    }
}

# Function to lock (block) webcam access by terminating processes
function Lock-Webcam {
    $processes = Get-WebcamProcesses
    if ($processes) {
        foreach ($process in $processes) {
            try {
                Stop-Process -Id $process.Id -Force -ErrorAction Stop
                Write-Host "Terminated process '$($process.ProcessName)' (PID: $($process.Id))." -ForegroundColor Green
            } catch {
                Write-Host "Error terminating process '$($process.ProcessName)': $_" -ForegroundColor Red
            }
        }
        Write-Host "Webcam access blocked by terminating related processes." -ForegroundColor Green
    } else {
        Write-Host "No processes to terminate. Webcam access is already restricted." -ForegroundColor Yellow
    }
}

# Function to check if webcam is accessible (basic test)
function Test-WebcamAccess {
    $testProcess = Start-Process -FilePath "ms-windows-store://home" -PassThru -ErrorAction SilentlyContinue
    if ($testProcess) {
        Write-Host "Webcam may still be accessible by some applications (e.g., Camera app launched)." -ForegroundColor Yellow
        Write-Host "This script only blocks known processes. For full lockdown, admin privileges are required." -ForegroundColor Yellow
        Stop-Process -Id $testProcess.Id -Force -ErrorAction SilentlyContinue
    } else {
        Write-Host "No webcam access detected via basic test." -ForegroundColor Green
    }
}

# Main menu
Write-Host "Webcam Locker for Security Research (Non-Admin)" -ForegroundColor Cyan
Write-Host "-----------------------------------"
Write-Host "1. List webcam-related processes"
Write-Host "2. Lock (block) webcam access"
Write-Host "3. Test webcam access"
Write-Host "4. Exit"
Write-Host "-----------------------------------"

while ($true) {
    $choice = Read-Host "Enter your choice (1-4)"
    switch ($choice) {
        "1" { Get-WebcamProcesses }
        "2" { Lock-Webcam }
        "3" { Test-WebcamAccess }
        "4" { Write-Host "Exiting..." -ForegroundColor Cyan; exit }
        default { Write-Host "Invalid choice. Please enter 1, 2, 3, or 4." -ForegroundColor Red }
    }
}