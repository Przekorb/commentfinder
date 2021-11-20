# commentfinder
Script to pull comments and potentially leaky api's from websites sources more efficient



## Summary

Once given a file with list of directories, it scans every record in search for comments or api's and prints them in pretty colors, so it's
hard to miss next clues in CTF's. Supports html redirection.<br/>Works best with gobuster using -o option to output directory list, but any other tool would be good as long as directories are in first lines:<br/>
/admin<br/>
/assets<br/>
...

