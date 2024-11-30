#!/bin/bash

# Указываем путь к логам PM2
PM2_LOG_FILE="/path/to/pm2/log/file.log"

# Искомое сообщение
ERROR_MESSAGE="ServingRateLimitExceeded(Module) error. This means: An axon or prometheus serving exceeded the rate limit for a registered neuron"

# Проверяем, есть ли сообщение в логах
if grep -q "$ERROR_MESSAGE" "$PM2_LOG_FILE"; then
    echo "Error found: $ERROR_MESSAGE"
    # Перезапускаем все процессы PM2
    pm2 restart all
else
    echo "No error found. All processes are running normally."
fi
