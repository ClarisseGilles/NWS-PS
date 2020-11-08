Enable-PSRemoting -Force
Enable-NetFirewallRule -DisplayName "*Network Access*"
Enable-NetFirewallRule -DisplayGroup "*Remote Event Log*"
Enable-NetFirewallRule -DisplayGroup "*Remote File Server Resource Manager Management*"