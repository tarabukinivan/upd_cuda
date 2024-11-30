#!/bin/bash

# Указываем путь к логам PM2
PM2_LOG_FILE="/path/to/pm2/log/file.log"

# Искомое сообщение
ERROR_MESSAGE="ServingRateLimitExceeded(Module) error. This means: An axon or prometheus serving exceeded the rate limit for a registered neuron"

# Сохраняем позицию, с которой начнем читать (используем временный файл)
POSITION_FILE="/tmp/pm2_log_position"
if [[ ! -f "$POSITION_FILE" ]]; then
    echo 0 > "$POSITION_FILE"
fi

# Читаем последнюю позицию
LAST_POSITION=$(cat "$POSITION_FILE")

# Проверяем размер файла лога
LOG_FILE_SIZE=$(stat -c%s "$PM2_LOG_FILE")

# Если файл уменьшился (лог был перезаписан), начинаем с начала
if [[ "$LOG_FILE_SIZE" -lt "$LAST_POSITION" ]]; then
    LAST_POSITION=0
fi

# Извлекаем новые строки из лога
NEW_LOGS=$(tail -c +$((LAST_POSITION + 1)) "$PM2_LOG_FILE")

# Сохраняем новую позицию
echo "$LOG_FILE_SIZE" > "$POSITION_FILE"

# Ищем сообщение в новых строках
if echo "$NEW_LOGS" | grep -q "$ERROR_MESSAGE"; then
    echo "Error found: $ERROR_MESSAGE"
    # Перезапускаем все процессы PM2
    pm2 restart all
else
    echo "No new error found. All processes are running normally."
fi
