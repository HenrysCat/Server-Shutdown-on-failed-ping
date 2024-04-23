# Define the name or IP address of the first server connected to UPS
$server1 = "192.168.0.xxx"
# Define the name or IP address of the second server to shutdown
$server2 = "192.168.0.xxx"

# Define the number of consecutive failed pings before shutting down server2
$failedPingCount = 3

# Function to check if the first server is still running
function Check-Server1Status {
    $ping = Test-Connection -ComputerName $server1 -Count 1 -Quiet
    return $ping
}

# Function to shutdown the second server
function Shutdown-Server2 {
    Stop-Computer -ComputerName $server2 -Force
}

Write-Host "Monitoring $server1..."

# Initialize the failed ping counter
$failedPing = 0

# Check the status of the first server continuously
while ($true) {
    Write-Host "Checking $server1 status..."
    Start-Sleep -Seconds 60  # Check every 60 seconds

    # Check if the first server is still running
    if (!(Check-Server1Status)) {
        $failedPing++
        Write-Host "Failed to ping $server1 ($failedPing/$failedPingCount)"
        if ($failedPing -ge $failedPingCount) {
            Write-Host "First server is shutting down. Initiating shutdown of $server2."
            Shutdown-Server2
            break
        }
    } else {
        # Reset failed ping counter if ping is successful
        $failedPing = 0
    }
}

Write-Host "$server1 is offline. Monitoring stopped."