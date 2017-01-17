#!/bin/sh -e
#

gsettings set org.mate.caja.desktop home-icon-visible false

gsettings set org.mate.background secondary-color '#C2C2C2'
gsettings set org.mate.background primary-color '#C2C2C2'
gsettings set org.mate.background color-shading-type 'vertical-gradient'
gsettings set org.mate.background picture-filename '/cismet.png'
gsettings set org.mate.background picture-options 'centered'

exit 0
