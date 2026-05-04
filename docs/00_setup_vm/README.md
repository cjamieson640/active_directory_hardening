# 00 - Setup Baseline VMs

1. Installed Windows Server 2022 as a virtual machine in VMware Workstation:  
    - Download Windows Server 2022 iso
    - Create new Virtual macine (Typical)
    - Select "I will install the operating system later"
    - Select Microsoft Windows then Windows Server 2022 as Guest Operating System
    - Name your Virtual machine, I chose Base DC, since its the baseline for the DC servers
    - Specs:
        - Maximum Disk size: 200GB
        - Memory: 8GB
        - Processors: 4
    - Edit VM settings, select CD/DVD (SATA) and select the Windows Server 2022 iso
    - Once the VM settings are complete, start up the VM and continute with the install of Windows Server 2022 Standard Evaluation 
    - Install VMWare tools
    - Take snapshot of the fresh install

2. Installed Windows 11 as a virtual machine in VMware Workstation  
    - Download Windows 11 iso
    - Create new Virtual macine (Typical)
    - Select "I will install the operating system later"
    - Select Microsoft Windows then Windows 11 as Guest Operating System
    - Name your Virtual machine, I chose Base Win11, since its the baseline for the Windows 11 Workstations
    - Specs:
        - Maximum Disk size: 200GB
        - Memory: 8GB
        - Processors: 4
    - Edit VM settings, select CD/DVD (SATA) and select the Windows 11 iso
    - Once the VM settings are complete, start up the VM and continure with the install of Windows 11
    - Install VMWare tools
    - Take snapshot of the fresh install

3. Cloning base machines
Now that the baselines are set up we need to make 3 clones to start setting up our enviornment.  
    - Make a clone of the Baseline Windows server for the domanin controller (DC1)  
    - Make a clone of the Baseline Windows 11 machine for a management client (MGMT01) 
    - Make a clone of the baseline Windows 11 machine for a workstation (WS01)  