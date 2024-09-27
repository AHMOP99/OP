# Use the Windows Server base image
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Install RDP (Remote Desktop Protocol)
RUN powershell -Command \
    # Install Remote Desktop Services
    Install-WindowsFeature -Name Remote-Desktop-Services; \
    # Set the default user credentials for RDP
    $username = "User"; \
    $password = "Password"; \
    net user $username $password; \
    # Enable automatic login
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'AutoAdminLogon' -Value '1'; \
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultUserName' -Value $username; \
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultPassword' -Value $password; \
    # Allow RDP connections
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name 'fDenyTSConnections' -Value 0; \
    # Set firewall rules to allow RDP
    New-NetFirewallRule -DisplayName "RDP" -Direction Inbound -Protocol TCP -Action Allow -LocalPort 3389

# Open port 3389 for RDP
EXPOSE 3389

# Start the RDP service
CMD ["powershell", "-Command", "Start-Service TermService; while ($true) { Start-Sleep -Seconds 3600 }"]
