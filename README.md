# Homelab

I have some devices (old and new combined) connected together for a homelab. And this repository is for keeping the code needed to manage it.

My devices:
1. One Raspberry Pi 5 8GB with 1TB SSD -> this one is running immich
2. One Raspberry Pi 4 8GB with 64GB MicroSD -> this one is just sitting there.
3. Lenovo M715q Tiny -> running proxmox and some VMs for me to practice k8s.
4. HP 1000 Notebook PC -> this is an ancient one. 12-14 years old, broken chassis, running ubuntu server, eating electricity.
5. Asus VivoBook N580VD -> this is another ancient one. 8 years old, dead display. Needs some thermal paste I guess.
6. HP 705 G4 Mini -> it doesn't exist, lol. I haven't bought it yet. XD

I use tailscale to ssh into these PCs. For public facing services (e.g. my non-existing portfolio), I use cloudflare tunnel.