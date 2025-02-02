# Windows 11 Developers' tools installations

## Python on Windows

Not all of the version of python run on windows.

[Installing multiple version of python on Windows with `py.exe`](https://stackoverflow.com/questions/51861943/how-to-install-python-launcher)

Installed path: `%USERPROFILE%\AppData\Local\Programs\Python`

[What is `py.exe`](https://learn.microsoft.com/en-us/windows/python/faqs#what-is-py-exe-)


Manually download and install Python then you can run the following command to access different versions

- [3.11.9](https://www.python.org/ftp/python/3.11.9/python-3.11.9-amd64.exe)
- [3.10.10](https://www.python.org/ftp/python/3.10.10/python-3.10.10-amd64.exe)
- [3.8.10](https://www.python.org/ftp/python/3.8.10/python-3.8.10-amd64.exe)


```powershell
    
    # display version of pip
    py -3.8 -m pip --version

    py -3.8 -m pip install -U pip
```


### Install `pipx`

When python installed manually and not from Windows Store. 

```powershell
    py -3.11 -m pip install --user pipx
```
