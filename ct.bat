@echo off
powershell -Command "Set-ExecutionPolicy RemoteSigned"
powershell -Command "iwr -useb https://christitus.com/win | iex"
powershell -Command "Set-ExecutionPolicy Restricted"
