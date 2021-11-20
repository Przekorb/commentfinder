# commentfinder
Script to pull comments and potentially leaky api's from multiple websites sources in pretty colours

![comments2](https://user-images.githubusercontent.com/94721201/142708639-3fe18f92-f97f-42d9-adf2-b65b84ff90f3.png)

## Summary

Once given a file with list of directories, it scans every record in search for comments or api's, so it's
hard to miss clues in CTF's. Supports html redirection.<br/><br />Works best with gobuster using -o option to output directory list, but any other tool would be good as long as directories are in first lines:<br/>
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
