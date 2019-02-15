# scripts
Some useful scripts

to make use of them everywhere, move them into ~/.local/bin or somewhere else in $PATH

note: To use todo, go to todo-cli and run 'npm install'

Useful programs:

htop: system monitor
ncdu: see disc space usage
df -Th: see disc partitions
systemctl: system control. create and manage services.
journalctl -u SERVICE-NAME.service -f: see service logs in real time
usermod -a -G GROUP1,GROUP2 USER: add USER to groups GROUP1 and GROUP2

# youtube-dl: cli tool for downloading vods
youtube-dl -F <url> # print possible formats
youtube-dl -f '<format>' <url> # example: '720p'

marand ip: 85.191.218.167

at some point: 

in ~/.ssh/config:
Host marand.dk
    ForwardX11 yes
    ForwardX11Trusted yes
