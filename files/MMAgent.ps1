Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -force

Enable-MMAgent -ApplicationPreLaunch
Enable-MMAgent -MemoryCompression
Enable-MMAgent -OperationAPI
Enable-MMAgent -PageCombining

Exit-PSSession
Exit