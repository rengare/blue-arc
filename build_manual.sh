rm -rf output
mkdir output
sudo /usr/bin/podman run --rm -it --privileged --pull=newer --net=host --security-opt label=type:unconfined_t -v /home/ren/workspace/custom_os/blue-arc/iso.toml:/config.toml:ro -v /home/ren/workspace/custom_os/blue-arc/output:/output -v /var/lib/containers/storage:/var/lib/containers/storage localhost/bootc-image-builder:latest --rootfs btrfs --type iso --local localhost/blue-arc

sudo chown -R $USER:$USER output
