# commentfinder
Script to pull comments and potentially leaky api's from websites sources more efficient

![image](https://user-images.githubusercontent.com/94721201/142705672-6bc64203-d9f5-4844-812e-cc2e2f2befeb.png)

## Summary

Once given a file with list of directories, it scans every record in search for comments or api's and prints them in pretty colors, so it's
hard to miss next clues in CTF's. Works best with gobuster using -o option to output directory list, but any other tool would be good as long as directories are in first lines:
  /admin
  /assets
  ...

