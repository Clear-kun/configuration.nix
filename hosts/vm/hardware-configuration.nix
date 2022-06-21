{ config, lib, pkgs, modulesPath, ... }:

{
    imports = 
        [ (modulesPath + "/profiles/qemu-guest.nix")
        ];

    boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems = {
        "/" = {
            device = "/dev/disk/by-uuid/c2330008-9105-491a-b087-88d2c9a0aa71";
            fsType = "ext4";
        };
        "/boot/efi" = {
            device = "/dev/disk/by-uuid/D0C6-F542";
            fsType = "vfat";
        };
    };

    swapDevices = [ { device = "/dev/disk/by-uuid/c08cba2D-0128-46c3-b0c8-a63d683ecae7"; } ];

    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}