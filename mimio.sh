wget https://dl.min.io/server/minio/release/linux-amd64/archive/minio_20241107005220.0.0_amd64.deb -O minio.deb
sudo dpkg -i minio.deb

sudo tee /etc/systemd/system/minio.service > /dev/null <<EOF
[Unit]
Description=MinIO
Documentation=https://min.io/docs/minio/linux/index.html
Wants=network-online.target
After=network-online.target
AssertFileIsExecutable=/usr/local/bin/minio

[Service]
WorkingDirectory=/usr/local
User=root
Group=root
ProtectProc=invisible
EnvironmentFile=-/etc/default/minio
ExecStart=/usr/local/bin/minio server --console-address :9001 /mnt/data
Restart=always
# Specifies the maximum file descriptor number that can be opened by this process
LimitNOFILE=65536
# Specifies the maximum number of threads this process can create
TasksMax=infinity
# Disable timeout logic and wait until process is stopped
TimeoutStopSec=infinity
SendSIGKILL=no

[Install]
WantedBy=multi-user.target
EOF

MINIO_ROOT_USER=myminioadmin >> /etc/default/minio
MINIO_ROOT_PASSWORD=Tarab739 >> /etc/default/minio
MINIO_VOLUMES="/mnt/data" >> /etc/default/minio
MINIO_OPTS="--console-address :9001" >> /etc/default/minio

sudo systemctl daemon-reload
sudo systemctl enable minio.service
sudo systemctl restart minio.service&& sudo journalctl -u minio.service -f

cat /etc/default/minio
