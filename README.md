# Предпосылки
Я любитель новых сборок Ubuntu, однако при обновлении одной версии Ubuntu 19.04 на 19.10 столкнулся с проблемой переноса программ, часть моих пакетов попросту была удалена из системы. И их теперь приходится устанавливать заново. А так как я могу что-то забыть и забытое напомнит о себе в самый неудобный момент, буду вести список установленных мной программ. Возможно позже напишу скрипты для автоматизации установки отдельных пакетов и программ

# Список программ
Пожалуй начнем:

* [Latex](http://tmel.ru/installyaciya-latex/) - Thanks, YouTube channel `Диджитализируй` for show me this perfect PDF creating product. В качестве редактора используем [TexStudio](https://www.texstudio.org/)
```bash
#Установка достаточно проста:
sudo apt-get install texlive texlive-full

#если планируется работа с графикой
sudo apt-get install imagemagick

sudo apt-get install texstudio
```

* [PHP]() - At that, I need different versions of a PHP. 5.6 for old projects and latest respectively.
* [apache2] - Хотя он прудустановлен в системе, как показывает практика настройки слетают при переустановке системы
