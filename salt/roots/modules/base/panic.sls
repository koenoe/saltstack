kernel_panic_reboot:
  file.managed:
    - name: /etc/sysctl.d/20-kernel-panic-reboot
    - contents: "vm.panic_on_oom=1\nkernel.panic=10"

sysctl_panic_on_oom:
  cmd.run:
    - name: 'sysctl vm.panic_on_oom=1'

sysctl_kernel_panic:
  cmd.run:
    - name: 'sysctl kernel.panic=10'