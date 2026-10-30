#!/bin/bashlib

# Функция для вывода справки
show_help() {
    echo "Использование: $0 [команда] [файл.json]"
    echo ""
    echo "Команды:"
    echo "  open    Показать очищенное/форматированное содержимое JSON"
    echo "  list    Вывести плоский список путей (ключей) и их значений"
    exit 1
}

# Проверка наличия аргументов
if [ $# -lt 2 ]; then
    show_help
fi

COMMAND=$1
FILE=$2

# Проверка существования файла
if [ ! -f "$FILE" ]; then
    echo "Ошибка: Файл '$FILE' не найден." >&2
    exit 1
fi

# Функция предварительной очистки JSON (удаление пробелов вокруг токенов)
tokenize_json() {
    # Читаем файл, удаляем переносы строк, затем расставляем токены на новые строки
    cat "$FILE" | tr -d '\n' | tr -d '\r' | \
    sed -E 's/([\{\}\[\]:,])/ \1 /g' | \
    xargs
}

# Команда: open (простая токенизация и вывод в одну строку для наглядности)
cmd_open() {
    # Просто выводим очищенную строку JSON
    cat "$FILE"
    echo "" # Перенос строки в конце
}

# Команда: list (рекурсивный разбор в плоский список)
# Использует концепцию разбора через потоковый sed/awk-подобный подход на Bash
cmd_list() {
    local json_string
    json_string=$(tokenize_json)

    # Паттерн для поиска пар "ключ":значение с помощью регулярных выражений Bash
    # Этот блок преобразует JSON в дерево путей (парсит простые объекты)
    echo "$json_string" | awk '
    BEGIN {
        FS=" ";
        loop=1;
    }
    {
        for (i=1; i<=NF; i++) {
            if ($i == "{") {
                level++;
                parents[level] = current_key;
                # Если это начало, сбросим ключ
                if (current_key == "") { prefix = "" }
                else { prefix = prefix current_key "." }
                current_key = "";
            }
            else if ($i == "}") {
                # Возвращаемся на уровень вверх
                split(prefix, parts, ".");
                prefix = "";
                for (j=1; j<level; j++) {
                    prefix = prefix parts[j] "."
                }
                level--;
            }
            else if ($i ~ /^".*":$/) {
                # Выделяем имя ключа без кавычек и двоеточия
                current_key = substr($i, 2, length($i)-3);
            }
            else if ($i == ":") {
                next;
            }
            else if ($i != ",") {
                # Это значение (строка, число, true/false)
                val = $i;
                if (val ~ /^".*"$/) {
                    val = substr(val, 2, length(val)-2);
                }
                if (current_key != "") {
                    print prefix current_key " = " val;
                }
            }
        }
    }'
}

# Маршрутизация команд
case "$COMMAND" in
    open)
        cmd_open
        ;;
    list)
        cmd_list
        ;;
    *)
        echo "Неизвестная команда: $COMMAND" >&2
        show_help
        ;;
esac
