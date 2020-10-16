# ceph-example
Small example how to setup a ceph cluster.


```
ceph auth list
```

```
...
client.admin
        key: AQBkMYlf0PS6AxAAqq8VK0MVMAII0jcQZcE9pQ==
        caps: [mds] allow *
        caps: [mgr] allow *
        caps: [mon] allow *
        caps: [osd] allow *
...
```

/etc/ceph/ceph.keyring
```
[client.admin]
        key = AQBkMYlf0PS6AxAAqq8VK0MVMAII0jcQZcE9pQ==
```


```
mount -t ceph mon1:6789,mon2:6789:/ /mnt/mycephfs -o name=admin,secret=`ceph-authtool -p /etc/ceph/ceph.keyring`
```
