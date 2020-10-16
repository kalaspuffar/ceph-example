#!/bin/bash
ssh -t kalaspuffar@$1 "mkdir -p .ssh"
scp .ssh/authorized_keys kalaspuffar@$1:/home/kalaspuffar/.ssh/