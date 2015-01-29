#!/bin/bash
                                                                                
# 2015 Jon Suderman
# https://github.com/suderman/local
                                                                                
# Open a terminal and run this command:
# bash <(curl https://raw.githubusercontent.com/suderman/local/master/bin/init)
                                                                                
# Helper methods for prettier shell scripting - http://shelper.suderman.io
eval "$(cat ~/.local/share/shelper.sh || curl shelper.suderman.io/shelper.sh)"

redirectip="0.0.0.0"
blacklist="/config/blacklist.conf"

# Exit if offline                                                                
if ! ping -c 1 yahoo.com ; then exit; fi
                                                                                               
## sources
sources="                                                                   \
http://www.mvps.org/winhelp2002/hosts.txt                                   \
http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts;showintro=0   \
http://support.it-mate.co.uk/downloads/hosts.txt                            \
"
# http://hostsfile.mine.nu/Hosts                                              \
# https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts

echo "" > $blacklist
downloaded="no" 

for url in $sources; do
  if wget $url -O - >> $blacklist; then
    echo "Downloaded $url to $blacklist"
    downloaded="yes"
  else
    echo "Failed to downloaded $url"
  fi
done

# If nothing downloaded, exit here
if [ "$downloaded" = "no" ]; then exit; fi

# Remove extra stuff
sed -i -e '/^[0-9A-Za-z]/!d' $blacklist
sed -i -e '/%/d' $blacklist
sed -i -e 's/[[:cntrl:][:blank:]]//g' $blacklist
sed -i -e 's/^[ \t]*//;s/[ \t]*$//' $blacklist
sed -i -e 's/[[:space:]]*\[.*$//'  $blacklist
sed -i -e 's/[[:space:]]*\].*$//'  $blacklist
sed -i -e '/[[:space:]]*#.*$/ s/[[:space:]]*#.*$//'  $blacklist
sed -i -e '/^$/d' $blacklist
sed -i -e '/127.0.0.1/ s/127.0.0.1//'  $blacklist
sed -i -e '/0.0.0.0/ s/0.0.0.0//'  $blacklist
sed -i -e '/^www[0-9]./ s/^www[0-9].//'  $blacklist
sed -i -e '/^www./ s/^www.//' $blacklist

# Remove dupes
cat $blacklist | sort -u > $blacklist.new
mv $blacklist.new $blacklist

# Format
sed -i -e 's|$|/'$redirectip'|' $blacklist
sed -i -e 's|^|address=/|' $blacklist
                                                                 
