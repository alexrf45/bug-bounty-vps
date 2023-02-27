Commands to run post apply

PUBLIC_IP=$(terraform output -raw public_ip)

Ref this for setting up vnc. might wanna look into ssh vnc or something encrypted. 


https://ubuntu.com/tutorials/ubuntu-desktop-aws#5-connecting-to-ubuntu-desktop


vncserver :1

set up vnc config file then kill vncserver

vncserver -kill :1

vncserver :1

Then we can use remmina to log in via vnc