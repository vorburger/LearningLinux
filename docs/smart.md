# S.M.A.R.T.

## TL;DR

    sudo dnf install smartmontools
    
    sudo smartctl --all /dev/nvme0
    sudo smartctl --capabilities /dev/nvme0
    sudo smartctl --test=short /dev/nvme0
    sudo smartctl -H /dev/nvme0
    sudo smartctl -l selftest /dev/nvme0

    sudo nvme list
    sudo nvme id-ctrl -H /dev/nvme0
    sudo nvme smart-log -H /dev/nvme0
    sudo nvme error-log /dev/nvme0
    sudo nvme fw-log /dev/nvme0

GNOME Disk Monitor GUI also has **SMART Data & Self-Tests** (click on the `⋮` in the upper right hand corner),
_but that doesn't seem to always be available (does it only work for SATA but not for NVMe connected drives?)._

## Monitoring with Prometheus

* https://github.com/prometheus-community/smartctl_exporter
* https://github.com/matusnovak/prometheus-smartctl
* https://github.com/cloudandheat/prometheus_smart_exporter
* https://github.com/PhilipMay/smart-prom-next

## References

* https://www.smartmontools.org
* https://wiki.archlinux.org/title/S.M.A.R.T.
* https://wiki.archlinux.org/title/Solid_state_drive/NVMe#SMART
* https://en.wikipedia.org/wiki/Self-Monitoring,_Analysis_and_Reporting_Technology
