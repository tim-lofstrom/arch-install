# Virtual Box Commands

- Attach ISO
    ```
    VBoxManage storageattach Arch --storagectl "IDE" --port 1 --device 0 --type dvddrive --medium path-to.iso
    ```

- Detach ISO
    ```
    VBoxManage storageattach Arch --storagectl "IDE" --port 1 --device 0 --type dvddrive --medium none
    ```

- Staring virtual machine
    ```
    VBoxManage startvm Ubuntu --type headless
    ```

- Check state
    ```
    vboxmanage showvminfo Arch | grep State
    ```

- Power off machine
    ```
    vboxmanage controlvm Arch poweroff
    ```