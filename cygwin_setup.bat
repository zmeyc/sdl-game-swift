mkdir ThirdParty\cygwin
cd ThirdParty\cygwin
bitsadmin /transfer "cygwindownloadjob" "https://cygwin.com/setup-x86_64.exe" "%cd%\setup-x86_64.exe"
setup-x86_64.exe
