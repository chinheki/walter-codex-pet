@echo off
setlocal

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0codex_notify.ps1" %*
