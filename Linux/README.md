How to check your server load

How to install netstat
We’re going to be using the netstat tool to find out what IP addresses are currently connected to your server. To install netstat on Ubuntu, you actually install net-tools, like so:

<code>sudo apt-get install net-tools -y</code>


To check for the number of logical processors, issue the command:

<code> grep processor /proc/cpuinfo | wc -l</code>

We next want to check our network load. There are a number of tools you can do this with, but I choose nload. To install nload, issue the command:

<code>sudo apt-get install nload -y</code>

How to find out what IP addresses are connected to your server

<code>netstat -ntu|awk '{print $5}'|cut -d: -f1 -s|sort|uniq -c|sort -nk1 -r</code>

ref: https://www.techrepublic.com/article/how-to-quickly-check-to-see-if-your-linux-server-is-under-a-ddos-attack-from-a-single-ip-address/


Make sure to look through this listing carefully. If you see an IP address with a large number of instances (over 100), the likelihood is pretty high that address is your culprit. Once you’re sure of the culprit, you can ban the IP address with the command:

<code>sudo route add ADDRESS reject</code>

Where ADDRESS is the IP address of the suspect.