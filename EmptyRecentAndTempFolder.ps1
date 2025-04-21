                                                    #===================================================#
                                                    #                                                   #
                                                    #     Elimina tutti i file presenti nelle cartelle: #
                                                    #     - Recenti (Windows)                           #
                                                    #     - Recenti (Office)                            #
                                                    #     - Temp (Utente)                               #
                                                    #     - Temp (Sistema)                              #
                                                    #     Ver. 1.0.0  03/05/2020                        #
                                                    #                                                   #
                                                    #===================================================#

Get-DirStats -Path D:\Win10\Temp\Utente | Sort-Object -Property Size

$DirWinRecent = "${env:USERPROFILE}\AppData\Roaming\Microsoft\Windows\Recent" + "\*.*"
Remove-Item $DirWinRecent -Recurse -Force

$DirOfficeRecent = "${env:USERPROFILE}\AppData\Roaming\Microsoft\Office\Recent" + "\*.*"
Remove-Item $DirOfficeRecent -Recurse -Force

$DirUserTmp = get-childitem $env:temp

Remove-Item $DirUserTmp -Recurse -Force
