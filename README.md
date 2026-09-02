# DevOps Homework

My submissions for the DevOps sessions. One folder per session, each with its own README that has
the commands I ran, the real output, and screenshots.

Course repo the tasks come from: [Nency-Ravaliya/devops-heros](https://github.com/Nency-Ravaliya/devops-heros)

**Name:** Manasvi
**Enrollment number:** _<10406>_

## Sections

| # | Session | What is in it |
|---|---|---|
| 1 | [Linux Fundamentals](01-linux-fundamentals) | soft vs hard links, `adduser` vs `useradd`, `journalctl`, command cheat sheet practice |
| 2 | [Shell Scripting](02-shell-scripting) | system information script with variables, `read -p`, `mkdir`, `touch` and `>` redirection |
| 3 | [Networking](03-networking) | `ip`, `ping`, `traceroute`, `dig`, `nslookup`, `netstat`, `ss`, `telnet`, plus IP/subnet/DNS/TCP notes |
| 4 | [Git / GitHub](04-git-github) | `git commit -a -m` vs `git commit -m`, and a full cherry-pick walkthrough |
| 5 | [Docker Hello World](05-docker-hello-world) | six apps: Node.js, Python, Java, Apache, React, Nginx |
| 6 | [Dockerfiles and Multi-Stage](06-dockerfiles-multistage) | course repo multi-stage build on port 8080, plus a 1.58 GB vs 202 MB size comparison |
| 7 | [Docker Networking and Volumes](07-docker-networking-volume) | 3 containers across 3 networks, host network, bind mount, overlay research |

## How to run any of the Docker sections

```bash
docker build -t <name>:1.0 ./<folder>
docker run -d --name <container> -p <host>:<container> <name>:1.0
docker ps
curl http://localhost:<host>
```

Ports I used, so nothing clashes if you bring everything up at once:

| Port | App |
|---|---|
| 3001 | Node.js hello world |
| 5001 | Python hello world |
| 8081 | Apache hello world |
| 8082 | React hello world |
| 8083 | Nginx hello world |
| 8085 | Java hello world |
| 8080 | multi-stage build app |
| 8090 | nginx bind mount demo |

## Notes on how I ran things

The Linux, shell scripting, networking and git tasks were done on an Ubuntu 24.04 machine, since
`useradd`, `adduser`, `journalctl` and `ip` behave differently or do not exist on macOS. The Docker
tasks were run on Docker Desktop on my Mac. Where the platform changed a result, for example
`--network host` behaving differently on Docker Desktop, I have said so in that section rather than
pretending the output matched.

My public IP is masked as `49.200.xxx.xxx` in the networking output.

The terminal screenshots are rendered from the output files I captured while running each command,
so the text in them is the actual output of those runs.
