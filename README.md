# Cloyne servers installation

This repository contains [Salt](http://docs.saltstack.com/en/latest/) files to deploy Cloyne servers.
Expected to be used with Ubuntu Server 16.04, but it might work with other distributions as well.

Check out all submodules:
```bash
git submodule update --init --recursive
```

Install `salt-ssh` using `virtualenv` (you do NOT need `sudo` for these):
```bash
# Create a virtualenv, for example:
virtualenv salt-virtualenv
. salt-virtualenv/bin/activate

# Install salt==2016.11.1
pip install salt==2016.11.1

# Check version of salt-ssh
salt-ssh --version
# salt-ssh 2016.11.1 (Carbon)
```

Then you can sync the state of a server by doing:
(This updates the live server to match the docker images built from github, so
make sure all the docker images still work!)

```
$ salt-ssh '<servername>' state.highstate
```
Note: This might take ~10 minutes with no output until the end.
If it fails quickly with `ImportError: No module named oncurrent.futures`: ssh
into `<servername>` and run `sudo pip install futures`.

Secrets are encrypted with a GPG keypair to be protected. Future secrets can be encrypted using:

```
echo -n "supersecret" | gpg --armor --encrypt -r <keyid>
```

[See Salt GPG renderer documentation for more information](https://docs.saltstack.com/en/latest/ref/renderers/all/salt.renderers.gpg.html).

When adding a new server, the `cloyne` user on the target server should have sudo permissions without needing to provide a password.
You can configure that in `/etc/sudoers` on the target server with such line (you can replace existing
one without `NOPASSWD`):

```
# Allow members of group sudo to execute any command
%sudo   ALL=(ALL) NOPASSWD: ALL
```
