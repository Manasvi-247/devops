# Shell Scripting

Homework task: write one script that prints system information, uses variables, takes input with
`read -p`, creates a directory and a file, and saves the running processes into that file using `>`.

Script: [`system_info.sh`](system_info.sh)

## What the script covers

Every item the task asked for, and where it happens in the script:

| Requirement | How it is done |
|---|---|
| Current date | `CURRENT_DATE=$(date)` then echo |
| Hostname | `HOST_NAME=$(hostname)` |
| Username | `USER_NAME=$(whoami)` |
| Disk usage | `df -h` |
| Running processes | `ps aux \| head -10` |
| Variables | `CURRENT_DATE`, `HOST_NAME`, `USER_NAME`, `DIR_NAME`, `FILE_NAME` |
| User input | `read -p "Enter a directory name to create: " DIR_NAME` |
| `mkdir` | `mkdir -p "$DIR_NAME"` |
| `touch` | `touch "$DIR_NAME/$FILE_NAME"` |
| Output redirection | `ps aux > "$DIR_NAME/$FILE_NAME"` |

## The script

```bash
#!/bin/bash

CURRENT_DATE=$(date)
HOST_NAME=$(hostname)
USER_NAME=$(whoami)

echo "=============================="
echo "     SYSTEM INFORMATION"
echo "=============================="

echo "Date      : $CURRENT_DATE"
echo "Hostname  : $HOST_NAME"
echo "Username  : $USER_NAME"

echo
echo "------ Disk Usage ------"
df -h

echo
echo "------ Running Processes (top 10) ------"
ps aux | head -10

echo
read -p "Enter a directory name to create: " DIR_NAME
read -p "Enter a file name to create inside it: " FILE_NAME

mkdir -p "$DIR_NAME"
echo "Directory created: $DIR_NAME"

touch "$DIR_NAME/$FILE_NAME"
echo "File created: $DIR_NAME/$FILE_NAME"

ps aux > "$DIR_NAME/$FILE_NAME"
echo "Running process list saved to $DIR_NAME/$FILE_NAME"

echo
echo "------ First 5 lines of $DIR_NAME/$FILE_NAME ------"
head -5 "$DIR_NAME/$FILE_NAME"

echo
echo "Line count in file: $(wc -l < "$DIR_NAME/$FILE_NAME")"
echo "Script finished."
```

## How to run it

Two ways, and the difference matters:

```bash
chmod +x system_info.sh
./system_info.sh
```

or

```bash
bash system_info.sh
```

With `./system_info.sh` the file itself has to be executable, and the shebang line `#!/bin/bash`
decides which interpreter runs it. With `bash system_info.sh` I am handing the file to bash as an
argument, so the execute bit is not needed and the shebang is ignored.

## Output

I answered `sysinfo` for the directory and `processes.txt` for the file name.

```
$ chmod +x system_info.sh
$ ./system_info.sh
==============================
     SYSTEM INFORMATION
==============================
Date      : Wed Sep  2 14:23:11 UTC 2026
Hostname  : f89ce1f76cf8
Username  : root

------ Disk Usage ------
Filesystem      Size  Used Avail Use% Mounted on
overlay         453G  3.6G  426G   1% /
tmpfs            64M     0   64M   0% /dev
shm              64M     0   64M   0% /dev/shm
/dev/vda1       453G  3.6G  426G   1% /etc/hosts
tmpfs           3.9G     0  3.9G   0% /proc/scsi
tmpfs           3.9G     0  3.9G   0% /sys/firmware

------ Running Processes (top 10) ------
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0   2272  1216 ?        Ss   14:20   0:00 sleep infinity
root        3679  0.0  0.0   2384  1588 pts/0    Ss+  14:23   0:00 sh -c cd /root && ./system_info.sh
root        3680  0.0  0.0   4036  3044 pts/0    S+   14:23   0:00 /bin/bash ./system_info.sh
root        3685  0.0  0.0   7632  3652 pts/0    R+   14:23   0:00 ps aux
root        3686  0.0  0.0   2284  1228 pts/0    S+   14:23   0:00 head -10

Enter a directory name to create: sysinfo
Enter a file name to create inside it: processes.txt
Directory created: sysinfo
File created: sysinfo/processes.txt
Running process list saved to sysinfo/processes.txt

------ First 5 lines of sysinfo/processes.txt ------
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0   2272  1216 ?        Ss   14:20   0:00 sleep infinity
root        3673  0.0  0.0   2296  1572 ?        Ss   14:23   0:00 script -qec cd /root && ./system_info.sh
root        3679  0.0  0.0   2384  1588 pts/0    Ss+  14:23   0:00 sh -c cd /root && ./system_info.sh
root        3680  0.0  0.0   4036  3048 pts/0    S+   14:23   0:00 /bin/bash ./system_info.sh

Line count in file: 6
Script finished.
```

![script run](screenshots/script-run.png)

## Things I picked up while writing it

**No spaces around `=`.** `NAME="value"` works, `NAME = "value"` does not, because bash reads that
as running a command called `NAME`.

**Command substitution.** `$(date)` runs the command and gives back its output. Backticks do the
same but `$( )` nests properly, so I stick to it.

**Quote your variables.** I wrote `mkdir -p "$DIR_NAME"` with quotes on purpose. If someone types
`my folder` at the prompt, without quotes bash would treat it as two arguments and create two
directories.

**`>` vs `>>`.** `>` truncates the file and writes fresh, `>>` appends. The task asked for `>`,
which is why `processes.txt` holds only the process list from that one run.

**`mkdir -p` does not fail if the directory exists**, which makes the script safe to run twice.

**Why the line count is small.** `ps aux` inside a container only sees the processes in that
container's PID namespace, so the file has 6 lines. On a normal VM this would be a few hundred.
