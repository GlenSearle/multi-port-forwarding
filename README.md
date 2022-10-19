# multi-port-forwarding
A networking tool that allows you to migrate servers to a new location without the need to reconfigure any servers.

## How it works
This can run a single on a low power computer, such as a Raspberry Pi 2. If can take the traffic for many IP addresses.
The script /etc/systemd/system/multi-port-forwarding@.service used the Linux Systemd task manager to keep ssh tunnels open to the new site. 
Each server has a configuration file located in /etc/default/multi-port-forwarding@server-name

### Starting

To pretend to be a departed server on the local network this command would be run:
```sudo systemctl start multi-port-forwarding@multi-port-forwarding@server-name```

The ip addess of the server will be added to the network interface.
An ssh tunnel will be created to the remote machine on the new network that is being used as the other end of the network bridge.

### Stopping

To stop forwarding traffic run this command:
```sudo systemctl start multi-port-forwarding@multi-port-forwarding@server-name```

This closes the SSH tunnel.
If the IP address being used for the tunnel is not the default IP address, it will be removed from the ethernet device.

### Making changes

Edit the file that describes the tunnel ```/etc/default/multi-port-forwarding@example```
then to apply the changes run the command
``````sudo systemctl start multi-port-forwarding@multi-port-forwarding@example```

It does this by taking on the IP address of the mirated machines and forwarding any traffic to those machines to the new site.

