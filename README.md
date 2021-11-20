# commentfinder
Script to pull comments and potentially leaky api's from multiple websites sources in pretty colours

![comments](https://user-images.githubusercontent.com/94721201/142707360-233df372-c5b6-493b-89f0-6db97f00427b.png)

## Summary

Once given a file with list of directories, it scans every record in search for comments or api's and prints them in pretty colours, so it's
hard to miss clues in CTF's. <br />Supports html redirection.<br/>Works best with gobuster using -o option to output directory list, but any other tool would be good as long as directories are in first lines:<br/>
```
/admin
/assets
...
```
## Installation
```
git clone https://github.com/przekorb/commentfinder
sudo ln -s $(pwd)/commentfinder/commentfinder.sh /usr/local/bin/
chmod +x ($pwd)/commentfinder/commentfinder.sh
commentfinder.sh -h
```
## Usage example
```
commentfinder.sh -t 10.10.10.58:3000 -f port3000dirs.txt
```
