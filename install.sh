#!/bin/bash

os=""
arch="Arch"
gentoo="Gentoo"
echo "Welcome to KDE Installer!"
echo "What is your os?"
read os

if [ "$os" == "$arch" ]; then
    sudo pacman -S plasma konsole kate firefox sddm
    sudo systemctl enable sddm
elif [ "$os" == "$gentoo" ]; then
    # Set the correct profile (assuming "X" is appropriate, you might want to guide the user)
    sudo eselect profile set X

    # Install KDE Plasma and dependencies
    sudo emerge --ask kde-plasma/plasma-meta
    sudo emerge --ask sys-apps/ed

    # Install SDDM if using it as a display manager
    sudo emerge --ask x11-misc/sddm
    sudo systemctl enable sddm

    # Ensure the .xinitrc exists and contains the right content
    echo "#!/bin/sh" > ~/.xinitrc
    echo "exec dbus-launch --exit-with-session startplasma-x11" >> ~/.xinitrc

    startx
else
    echo "OS not supported!"
fi