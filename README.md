# ceph-example
Small example how to setup a ceph cluster.

First you need a couple of machines, in my case I used the simple-cdd-example repository on my github in order to create 8 virtual machines to play around with. For a Ceph cluster you need atleast 1 machine that is really powerful and one that is not. But to make an optimal install you need 8 machines. Three Object Stores, two Monitors/Managers, one Metadata store and one client. I added a grafana client as well but that service could be running on one of the other machines as well as it doesn't use that much resources.

* OSD - A object store require disks and a lot of memory, minimum 8 GB.
* MON/MAN - Requires atleast 2 Gb of memory and some CPU
* MDS - Require atleast 2 Gb and some CPU
* Client - Could be any machine really.

First I installed ansible on my work machine in this case the client.
Add the following line to /etc/apt/sources.list:

```
deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main
```

Then run these commands:
```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
sudo apt update
sudo apt install ansible
```

Next up I installed the repo.
```
git clone https://github.com/ceph/ceph-ansible.git
git checkout stable-5.0
pip install -r requirements.txt
```

Next up I went through all the servers and inventored them and created a host file with all the IP's of my cluster. Next up I added that host file to my client and also edited the ansible.cfg file to contain all my hosts.

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
