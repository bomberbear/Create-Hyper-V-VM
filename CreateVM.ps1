<#
.SYNOPSIS
This script creates a new Hyper-V virtual machine with specified parameters.

.DESCRIPTION
A PowerShell script to automate the creation of a Hyper-V virtual machine. Users can specify parameters such as VM name, memory, VHD path, VHD size, switch, and ISO path. Default values are provided for each parameter.

.PARAMETER VMName
The name of the virtual machine to be created. Default value is 'MyNewVM'.

.PARAMETER Memory
The amount of memory to allocate to the virtual machine. Default value is 4GB.

.PARAMETER NewVHDPath
The path for the new VHD file. Default value is 'D:\Hyper-V\Default.vhdx'.

.PARAMETER VHDSize
The size of the VHD to be created. Default value is 40GB.

.PARAMETER Switch
The name of the network switch to connect the virtual machine to. Default value is 'Default Switch'.

.PARAMETER ISO
The path to the ISO file for the virtual machine. Default value is 'C:\Users\esudd\Downloads\Windows.iso'.

.EXAMPLE
.\CreateVM.ps1 -VMName 'TestVM' -Memory 8GB -NewVHDPath 'E:\VMs\TestVM.vhdx' -VHDSize 50GB -Switch 'MainNetworkSwitch' -ISO 'C:\ISO\Windows10.iso'
This example creates a new VM named 'TestVM' with 8GB of memory, a 50GB VHD located at 'E:\VMs\TestVM.vhdx', connected to 'MainNetworkSwitch', and uses 'C:\ISO\Windows10.iso' as the installation media.

.EXAMPLE
.\CreateVM.ps1 -VMName 'TestVM' -NewVHDPath 'E:\VMs\TestVM.vhdx'
This example is the base command if you have any more than 2 vms
This creates a new VM named 'TestVM' with 4GB of memory, a 40GB VHD located at 'E:\VMs\TestVM.vhdx', connected to 'MainNetworkSwitch', and uses 'C:\ISO\Windows10.iso' as the installation media.

.NOTES
Author: Emrys Suddarth
Date: 11/8/2023
#>

param (
    [string]$VMName = 'MyNewVM',
    [string]$Memory = 4GB,
    [string]$NewVHDPath = 'D:\Hyper-V\Default.vhdx',
    [string]$VHDSize = 40GB,
    [string]$Switch = 'Default Switch',
    [string]$ISO = 'C:\Users\esudd\Downloads\Windows.iso'
)
$MemoryBytes = [int64]( $Memory.TrimEnd('GB') ) * 1GB
$VHDSizeBytes = [int64]( $VHDSize.TrimEnd('GB') ) * 1GB
# Create a new VM with the specified parameters
New-VM -Name $VMName -MemoryStartupBytes $Memory -Path "C:\Hyper-V" -NewVHDPath $NewVHDPath -NewVHDSizeBytes $VHDSize -SwitchName $Switch
# Sets the ISO default
Set-VMDvdDrive -VMName $VMName -Path $ISO
# Starts the vm
Start-VM -Name $VMName