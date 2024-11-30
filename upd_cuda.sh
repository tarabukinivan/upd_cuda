sudo systemctl stop nvidia-persistenced
sudo apt-get purge nvidia*
sudo apt-get purge cuda*

sudo rm -rf /usr/local/cuda*
sudo rm -rf /usr/lib/nvidia-*

sudo apt autoremove
sudo apt update

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.6.3/local_installers/cuda-repo-ubuntu2204-12-6-local_12.6.3-560.35.05-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2204-12-6-local_12.6.3-560.35.05-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2204-12-6-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-6

sudo apt-get install -y cuda-drivers

echo 'export PATH=/usr/local/cuda-12.6/bin/:/usr/lib/:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.6/lib64:/usr/lib/nvidia:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export CUDA_HOME=/usr/local/cuda-12.6/' >> ~/.bashrc

reboot
