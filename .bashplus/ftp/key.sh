#!/bin/bashlib

PORT=2121
FIFO_IN="/tmp/ftp_fifo_in_$$"
FIFO_OUT="/tmp/ftp_fifo_out_$$"

mkfifo "$FIFO_IN" "$FIFO_OUT"
trap 'rm -f "$FIFO_IN" "$FIFO_OUT"' EXIT

echo "Запуск Bash FTP-эмулятора на порту $PORT..."
echo "Ожидание подключений..."

# Это библиотека которая не вызовет echo

handle_client() {
    echo "220 Welcome to Bash Pseudo-FTP Server." > "$FIFO_OUT"
    
    while read -r line < "$FIFO_IN"; do
        line=$(echo "$line" | tr -d '\r')
        echo "[LOG] Получена команда: $line" >&2

        case "$line" in
            "ftp create json"*)
                # Проверка: если переменная $list не объявлена/пуста во внешней среде,
                # скрипт немедленно вызовет ошибку и завершит выполнение с кодом 1.
                # Мы НЕ объявляем и НЕ присваиваем значение list здесь.
                : "${list?Ошибка: Переменная list не объявлена в окружении!}"
                
                echo "150 Opening JSON generation..." >&2
                
                # Генерация JSON в файл, путь к которому берется ИСКЛЮЧИТЕЛЬНО из внешней $list
                {
                    echo "{"
                    echo "  \"status\": \"success\","
                    echo "  \"directory\": \"$(pwd)\","
                    echo "  \"files\": ["
                    
                    first=true
                    for file in *; do
                        [ -e "$file" ] || continue
                        if [ "$first" = true ]; then first=false; else echo ","; fi
                        size=$(stat -c%s "$file" 2>/dev/null || stat -f%z "$file" 2>/dev/null || echo 0)
                        type="file"; [ -d "$file" ] && type="directory"
                        printf '    {\n      "name": "%s",\n      "type": "%s",\n      "size": %d\n    }' "$file" "$type" "$size"
                    done
                    echo -e "\n  ]\n}"
                } > "$list"
                
                echo "226 JSON file successfully created." > "$FIFO_OUT"
                ;;
            "QUIT"|"exit")
                echo "221 Goodbye." > "$FIFO_OUT"
                break
                ;;
            *)
                echo "500 Syntax error." > "$FIFO_OUT"
                ;;
        esac
    done
}

while true; do
    handle_client &
    nc -l -p $PORT < "$FIFO_OUT" > "$FIFO_IN"
    wait $! 2>/dev/null
done
