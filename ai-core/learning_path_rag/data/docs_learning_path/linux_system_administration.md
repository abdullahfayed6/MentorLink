# Linux System Administration

## Linux Fundamentals

### File System and Navigation
- **Directory Structure**: /, /home, /var, /etc, /usr hierarchy
- **File Operations**: cp, mv, rm, find, locate commands
- **File Permissions**: chmod, chown, chgrp access control
- **Links**: Hard links and symbolic links creation
- **File System Types**: ext4, xfs, btrfs characteristics

### Process Management
- **Process Viewing**: ps, top, htop process monitoring
- **Process Control**: kill, killall, jobs, bg, fg commands
- **System Services**: systemd, service management
- **Cron Jobs**: Scheduled task automation
- **Process Priorities**: nice, renice priority adjustment

### Text Processing
- **Text Editors**: vi/vim, nano, emacs usage
- **Text Manipulation**: sed, awk, grep, sort, uniq
- **File Viewing**: cat, less, more, head, tail commands
- **Text Comparison**: diff, comm, cmp utilities
- **Regular Expressions**: Pattern matching in text processing

## System Configuration

### User and Group Management
- **User Accounts**: useradd, usermod, userdel commands
- **Group Management**: groupadd, groupmod, groupdel operations
- **Password Management**: passwd, chage security settings
- **sudo Configuration**: Privilege escalation setup
- **User Environment**: Profile files and shell configuration

### Network Configuration
- **Network Interfaces**: ip, ifconfig interface management
- **DNS Configuration**: /etc/resolv.conf, hostname setup
- **Firewall**: iptables, firewalld rule management
- **SSH Configuration**: Secure shell setup and key management
- **Network Troubleshooting**: ping, traceroute, netstat tools

### Package Management
- **APT (Debian/Ubuntu)**: apt, apt-get, dpkg commands
- **YUM/DNF (Red Hat/Fedora)**: yum, dnf, rpm operations
- **Package Updates**: System update procedures
- **Repository Management**: Adding and configuring repositories
- **Dependency Resolution**: Handling package dependencies

## Advanced Administration

### System Monitoring
- **Performance Monitoring**: vmstat, iostat, sar tools
- **Log Management**: /var/log analysis, rsyslog configuration
- **Disk Usage**: df, du, lsblk storage monitoring
- **Memory Analysis**: free, /proc/meminfo investigation
- **System Load**: uptime, load average interpretation

### Security Hardening
- **Access Control**: PAM configuration and security policies
- **File System Security**: ACLs, SELinux, AppArmor
- **Network Security**: Port scanning, intrusion detection
- **System Auditing**: auditd log analysis
- **Backup Strategies**: tar, rsync, automated backups

### Virtualization and Containers
- **KVM Virtualization**: libvirt, virt-manager setup
- **LXC Containers**: Linux container management
- **Docker Integration**: Container runtime on Linux
- **System Resources**: CPU, memory allocation for VMs
- **Storage Management**: LVM, RAID configuration
