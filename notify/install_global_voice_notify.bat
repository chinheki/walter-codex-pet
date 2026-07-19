@echo off
setlocal

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install_global_voice_notify.ps1" %*
