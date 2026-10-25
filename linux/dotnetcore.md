# `dotnetcore` Installation Guide for Linux

[Download .NET SDK For Linux](https://dotnet.microsoft.com/en-us/download)

## Install .NET Core SDK

```bash

# https://download.visualstudio.microsoft.com/download/pr/0e717d01-aad7-475a-8b67-50c59cf043b1/6eaa1c636e15ec8e1b97b3438360c770/dotnet-sdk-9.0.102-linux-x64.tar.gz

    mkdir -p $HOME/dotnet && tar zxf dotnet-sdk-9.0.102-linux-x64.tar.gz -C $HOME/dotnet

    echo 'export DOTNET_ROOT=$HOME/dotnet' >> ~/.bashrc
    echo 'export PATH=$PATH:$HOME/dotnet' >> ~/.bashrc
    echo 'export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools' >> ~/.bashrc
    echo 'export SSL_CERT_DIR=$HOME/.aspnet/dev-certs/trust:/usr/lib/ssl/certs' >> ~/.bashrc

    export DOTNET_ROOT=$HOME/dotnet
    export PATH=$PATH:$HOME/dotnet
    export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
    export SSL_CERT_DIR=$HOME/.aspnet/dev-certs/trust:/usr/lib/ssl/certs

```

## Manage SDKs with `dotnetup`

[dotnetup](https://devblogs.microsoft.com/dotnet/introducing-dotnetup/) is Microsoft's toolchain manager for user-level .NET installs (preview). Point it at `$HOME/dotnet` so the `.bashrc` lines above, `DOTNET_ROOT` and any `/usr/local/bin/dotnet` symlink keep working unchanged.

Before switching, see what is installed today and what will be affected:

```bash
    ./linux/scripts/dotnet-inventory.sh [project-dir]   # read-only; project-dir is searched upward for global.json
```

dotnetup refuses to take over an install it did not create, so move the old one aside and let it rebuild the same path:

```bash
    mv ~/dotnet ~/dotnet.bak

    ~/.dotnetup/dotnetup init --install-path ~/dotnet
    ~/.dotnetup/dotnetup sdk install 10.0.100 9.0.203 8.0.404 --install-path ~/dotnet

    # .bashrc and the symlink already point at ~/dotnet, so dotnetup only puts itself on PATH
    ~/.dotnetup/dotnetup env set none

    dotnetup list
    dotnet --list-sdks && dotnet --list-runtimes
```

Rollback: `rm -rf ~/dotnet && mv ~/dotnet.bak ~/dotnet`. Delete `~/dotnet.bak` once builds and global tools work.

Day to day:

```bash
    dotnetup update                                   # patch every tracked SDK
    dotnetup sdk install 11 --install-path ~/dotnet   # add a new major version
    dotnetup uninstall 9.0.2xx                        # remove an SDK and runtimes nothing else uses
```

Each SDK brings only its own runtime. A global tool that targets an older framework fails with "You must install or update .NET"; run it with `DOTNET_ROLL_FORWARD=Major`, or install that runtime with `dotnetup runtime install <version> --install-path ~/dotnet`.

## Issues

### Certificate issues

- [Linux certificate not trusted](https://learn.microsoft.com/en-us/aspnet/core/security/enforcing-ssl?view=aspnetcore-9.0&tabs=visual-studio%2Clinux-sles#linux-certificate-not-trusted)

```bash
    # check if the certificate is valid
    ls -la ~/.dotnet/corefx/cryptography/x509stores/my

    # The HTTPS developer Kestrel certificate file is the SHA1 thumbprint. When the file is deleted via dotnet dev-certs https --clean, it's regenerated when needed with a different thumbprint. Check the thumbprint of the exported certificate matches with the following command:
    openssl x509 -noout -fingerprint -sha1 -inform pem -in /usr/local/share/ca-certificates/aspnet/https.crt

```

- [Linux-specific considerations](https://learn.microsoft.com/en-us/aspnet/core/security/enforcing-ssl?view=aspnetcore-9.0&tabs=visual-studio%2Clinux-sles#linux-specific-considerations)

```bash
    # Trust HTTPS certificate on Linux with linux-dev-certs
    dotnet tool update -g linux-dev-certs
    dotnet linux-dev-certs install
```

- [Ubuntu trust the certificate for service-to-service communication](https://learn.microsoft.com/en-us/aspnet/core/security/enforcing-ssl?view=aspnetcore-6.0&tabs=visual-studio%2Clinux-ubuntu%2Clinux-sles#ubuntu-trust-the-certificate-for-service-to-service-communication)

```bash
    dotnet dev-certs https
    sudo -E dotnet dev-certs https -ep /usr/local/share/ca-certificates/aspnet/https.crt --format PEM
    sudo update-ca-certificates
```


### The configured user limit (128) on the number of inotify instances has been reached.

While running tests I can into the following error:

(System.IO.IOException: The configured user limit (128) on the number of inotify instances has been reached.)[https://github.com/dotnet/aspnetcore/issues/8449#issuecomment-512275929]

Solution:

```bash
    echo fs.inotify.max_user_instances=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
```
