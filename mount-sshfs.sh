#!/bin/bash
sshfs <user>@<host>:/path/to/remote /path/to/local -o -o IdentityFile=/path/to/private/key,_netdev,user,idmap=user,transform_symlinks,default_permissions,uid=<uid>,gid=<gid>,reconnect,ServerAliveInterval=15,ServerAliveCountMax=3
