%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  MISIS class for thesis files    28 June 2025
%%  For any information, suggestions or bug reports please send
%%  an e-mail to:
%%      lychev@misis.ru
%%  
%%  Adapted from Russian-Phd-LaTeX-Dissertation-Template provided by:
%%      Andrey Akinshin 
%%  Modified by:
%%      Andrey Lychev and Arina Petrova
%%  Versions:
%%      v1.0 Andrey Lychev, Arina Petrova (June 2024)
%%      v1.1 Andrey Lychev (June 2025)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mthesis}[28/06/2025 v1.1 MISIS thesis class]

\RequirePackage[l2tabu,orthodox]{nag}

\LoadClass[a4paper,14pt,oneside,openany]{memoir}

\RequirePackage{geometry}
\RequirePackage{amssymb}
\RequirePackage{mathtools}
\RequirePackage{ifthen}
\RequirePackage{cmap}
\RequirePackage{textcomp}
\RequirePackage[T1,T2A]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[english,russian]{babel}

% Для выбора степени
\DeclareOption{bachelor}{\gdef\@ThesisDegree{bachelor}}
\DeclareOption{master}{\gdef\@ThesisDegree{master}}

% Цветные ссылки
\DeclareOption{colurls}{\gdef\@ColUrls{true}}
\DeclareOption{blackurls}{\gdef\@ColUrls{false}}

% Оформление титульного листа
\DeclareOption{titlestd}{\gdef\@StdTitle{true}}
\DeclareOption{titleikn}{\gdef\@StdTitle{false}}

% Добавление выбранных параметров в класс
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}

% Настройки по-умолчанию
\ExecuteOptions{bachelor,blackurls,titleikn,a4paper,14pt,oneside,openany}

% Обработка параметров
\ProcessOptions\relax

% Шрифт Таймс
\RequirePackage{tempora}

% Текст после заголовков с красной строки
\indentafterchapter
\RequirePackage{indentfirst}

% Цвета
\RequirePackage[dvipsnames,table,hyperref]{xcolor}

% Таблицы
\RequirePackage{tabularray}

% Запятая в десятичных дробях
\RequirePackage{icomma}

% Для разреженного и подчёркнутого текста 
\RequirePackage[normalem]{ulem}
\RequirePackage{soulutf8}

% Для вычисление размера текста
\RequirePackage{calc}

% Кириллица в нумерации subequations
% Для правильной работы требуется выполнение сразу после загрузки пакетов
\patchcmd{\subequations}{\def\theequation{\theparentequation\alph{equation}}}
{\def\theequation{\theparentequation\asbuk{equation}}}
{\typeout{subequations patched}}{\typeout{subequations not patched}}

% Графики, диаграммы + рамка титульного листа
\RequirePackage{tikz}
\usetikzlibrary{calc}

% Гиперссылки
\RequirePackage{hyperref}

% Изображения
\RequirePackage{graphicx}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{pdfpages}

% Счётчики
\RequirePackage{aliascnt}
\RequirePackage[figure,table]{totalcount}
\RequirePackage{totcount}
\RequirePackage{totpages}
\RequirePackage{placeins}   % для \FloatBarrier

% Макет страницы
\geometry{a4paper, top=2cm, bottom=2cm, left=3cm, right=1.5cm, nofoot, nomarginpar}
\setlength{\topskip}{0pt}
\setlength{\footskip}{20pt}

% Колонтитулы
\makeevenhead{plain}{}{}{}
\makeoddhead{plain}{}{}{}
\makeevenfoot{plain}{}{\rmfamily\thepage}{}
\makeoddfoot{plain}{}{\rmfamily\thepage}{}
\pagestyle{plain}

% Выравнивание и переносы
\tolerance 1414
\hbadness 1414
\emergencystretch 1.5em
\hfuzz 0.3pt
\vfuzz \hfuzz
\clubpenalty=10000 % Запрещает разрыв страницы после первой строки абзаца
\widowpenalty=10000 % Запрещает разрыв страницы после последней строки абзаца
\brokenpenalty=4991 % Ограничение на разрыв страницы, если строка заканчивается переносом


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Таблицы

% Разделитель между номером и названием таблицы
\newcommand{\tablabelsep}{~\cyrdash\ }

% Нумерация таблиц
\DeclareCaptionLabelSeparator{tabsep}{\tablabelsep}

% Формат подписи
\captionsetup[table]{
        format=plain,            % формат подписи
        font=normal,             % нормальные размер, цвет, стиль шрифта
        skip=.0pt,               % отбивка под подписью
        parskip=.0pt,            % отбивка между параграфами подписи
        position=above,          % положение подписи
        justification=justified, % выравнивание подписи по ширине
        indent=0pt,              % смещение строк после первой
        labelsep=tabsep,         % разделитель
        singlelinecheck=false,   % не выравнивать по центру, если умещается в одну строку
}

% Тема оформления для длинных таблиц
\DefTblrTemplate{capcont}{gost}{%
Продолжение таблицы~\thetable
}
\DefTblrTemplate{lastfoot}{gost}{%\hline
\UseTblrTemplate{note}{default}
\UseTblrTemplate{remark}{default}
}

\DefTblrTemplate{contfoot-text}{gost}{}
\DefTblrTemplate{caption-sep}{gost}{\tablabelsep}
\DefTblrTemplate{remark-sep}{gost}{\tablabelsep}

\NewTblrTheme{gost}{%
\SetTblrTemplate{capcont}{gost}
\SetTblrTemplate{caption-sep}{gost}
\SetTblrTemplate{remark-sep}{gost}
\SetTblrTemplate{contfoot-text}{gost}
\SetTblrTemplate{lastfoot}{gost}
\SetTblrStyle{remark}{indent=2.5em,hang=0pt}
\SetTblrStyle{remark-tag}{font=\normalfont}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Рисунки

% Разделитель между номером и названием рисунка
\DeclareCaptionLabelSeparator{figsep}{~\cyrdash\ }

% Формат подписи
\captionsetup[figure]{
        format=plain,                     % формат подписи (plain|hang)
        font=normal,                      % нормальные размер, цвет, стиль шрифта
        skip=.0pt,                        % отбивка под подписью
        parskip=.0pt,                     % отбивка между параграфами подписи
        position=below,                   % положение подписи
        singlelinecheck=true,             % выравнивание по центру, если умещается в одну строку
        justification=centerlast,         % центровка
        labelsep=figsep,                  % разделитель
}

% Подписи подрисунков
\DeclareCaptionSubType{figure}
\renewcommand\thesubfigure{\asbuk{subfigure}} % нумерация подрисунков
\DeclareCaptionFont{norm}{\fontsize{14pt}{16pt}\selectfont}

% Формат подписи подрисунков
\captionsetup[subfloat]{
        labelfont=norm,          % нормальный размер подписей подрисунков
        textfont=norm,           % нормальный размер подписей подрисунков
        labelsep=space,          % разделитель
        labelformat=brace,       % одна скобка справа от номера
        justification=centering, % центровка
        singlelinecheck=true,    % выравнивание по центру, если умещается в одну строку
        skip=.0pt,               % отбивка над подписью
        parskip=.0pt,            % отбивка между параграфами подписи
        position=below,          % положение подписи
}

% Пути к изображениям
\graphicspath{{images/}{figures/}{imgs/}{figs/}{img/}{fig/}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Гиперссылки

% Цвет ссылок hyperref
\ifthenelse{\equal{\@ColUrls}{true}}{
    \definecolor{linkcolor}{rgb}{0.9,0,0}
    \definecolor{citecolor}{rgb}{0,0.6,0}
    \definecolor{urlcolor}{rgb}{0,0,1}
}{
    \definecolor{linkcolor}{rgb}{0,0,0}
    \definecolor{citecolor}{rgb}{0,0,0}
    \definecolor{urlcolor}{rgb}{0,0,0}
}

\hypersetup{
    linktocpage=true,           % ссылки с номера страницы в оглавлении
%    linktoc=all,                % разделы являются ссылками
%    pdfpagelabels=false,        % установить метки страниц PDF (true|false)
    plainpages=false,           % страницы нумеруются арабскими числами
    colorlinks,                 % ссылки отображаются цветным текстом, а не цветным прямоугольником
    linkcolor={linkcolor},      % цвет ссылок типа ref, eqref и т.п.
    citecolor={citecolor},      % цвет ссылок-цитат
    urlcolor={urlcolor},        % цвет гиперссылок
%    hidelinks,                  % Скрыть ссылки (удалив цвет и рамку)
    pdftitle={Заголовок},       % Заголовок
    pdfauthor={Автор},          % Автор
    pdfsubject={Тема},          % Тема
%    pdfcreator={Создатель},     % Автор
%    pdfproducer={Производитель},% Производитель PDF
%    pdfkeywords={Ключевые слова},% Ключевые слова
    pdflang={ru},
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Списки

% Короткое тире для ненумерованных списков
\renewcommand{\labelitemi}{\normalfont\bfseries{--}}

% Перечисление строчными буквами русского алфавита
\RequirePackage{enumitem}
\AddEnumerateCounter{\asbuk}{\russian@alph}{щ}

% Первый уровень нумерации - буквы русского алфавита
\renewcommand{\theenumi}{\asbuk{enumi}}
\renewcommand{\labelenumi}{\theenumi)}
% Второй уровень нумерации - арабские цифры
\renewcommand{\theenumii}{\arabic{enumii}} 
\renewcommand{\labelenumii}{\theenumii)}
% Третий уровень нумерации - буквы латинского алфавита
\renewcommand{\theenumiii}{\alph{enumiii}}
\renewcommand{\labelenumiii}{\theenumiii)}

\setlist{nosep,labelindent=\parindent,leftmargin=*}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Русификация

% Нумерация приложений, рисунков и формул по ГОСТ 2.105
\if@uni@ode
  \def\russian@Alph#1{\ifcase#1\or
    А\or Б\or В\or Г\or Д\or Е\or Ж\or
    И\or К\or Л\or М\or Н\or
    П\or Р\or С\or Т\or У\or Ф\or Х\or
    Ц\or Ш\or Щ\or Э\or Ю\or Я\else\@ctrerr\fi}
\else
  \def\russian@Alph#1{\ifcase#1\or
    \CYRA\or\CYRB\or\CYRV\or\CYRG\or\CYRD\or\CYRE\or\CYRZH\or
    \CYRI\or\CYRK\or\CYRL\or\CYRM\or\CYRN\or
    \CYRP\or\CYRR\or\CYRS\or\CYRT\or\CYRU\or\CYRF\or\CYRH\or
    \CYRC\or\CYRSH\or\CYRSHCH\or\CYREREV\or\CYRYU\or
    \CYRYA\else\@ctrerr\fi}
\fi
\if@uni@ode
  \def\russian@alph#1{\ifcase#1\or
    а\or б\or в\or г\or д\or е\or ж\or
    и\or к\or л\or м\or н\or
    п\or р\or с\or т\or у\or ф\or х\or
    ц\or ш\or щ\or э\or ю\or я\else\@ctrerr\fi}
\else
  \def\russian@alph#1{\ifcase#1\or
    \cyra\or\cyrb\or\cyrv\or\cyrg\or\cyrd\or\cyre\or\cyrzh\or
    \cyri\or\cyrk\or\cyrl\or\cyrm\or\cyrn\or
    \cyrp\or\cyrr\or\cyrs\or\cyrt\or\cyru\or\cyrf\or\cyrh\or
    \cyrc\or\cyrsh\or\cyrshch\or\cyrerev\or\cyryu\or
    \cyrya\else\@ctrerr\fi}
\fi

% Задаём русскоязычные названия
\addto\captionsrussian{
    \renewcommand{\contentsname}{СОДЕРЖАНИЕ}
    \renewcommand{\figurename}{Рисунок}
    \renewcommand{\tablename}{Таблица}
    \renewcommand{\bibname}{\bibtitlefull}
}

% Русская традиция начертания математических знаков
\renewcommand{\le}{\ensuremath{\leqslant}}
\renewcommand{\leq}{\ensuremath{\leqslant}}
\renewcommand{\ge}{\ensuremath{\geqslant}}
\renewcommand{\geq}{\ensuremath{\geqslant}}
\renewcommand{\emptyset}{\varnothing}

% Русская традиция начертания математических функций (на случай копирования из зарубежных источников)
\renewcommand{\tan}{\operatorname{tg}}
\renewcommand{\cot}{\operatorname{ctg}}
\renewcommand{\csc}{\operatorname{cosec}}

% Русская традиция начертания греческих букв (греческие буквы вертикальные, через пакет upgreek)
\RequirePackage{upgreek}
\renewcommand{\epsilon}{\ensuremath{\upvarepsilon}}
\renewcommand{\phi}{\ensuremath{\upvarphi}}
%\renewcommand{\kappa}{\ensuremath{\varkappa}}
\renewcommand{\alpha}{\upalpha}
\renewcommand{\beta}{\upbeta}
\renewcommand{\gamma}{\upgamma}
\renewcommand{\delta}{\updelta}
\renewcommand{\varepsilon}{\upvarepsilon}
\renewcommand{\zeta}{\upzeta}
\renewcommand{\eta}{\upeta}
\renewcommand{\theta}{\uptheta}
\renewcommand{\vartheta}{\upvartheta}
\renewcommand{\iota}{\upiota}
\renewcommand{\kappa}{\upkappa}
\renewcommand{\lambda}{\uplambda}
\renewcommand{\mu}{\upmu}
\renewcommand{\nu}{\upnu}
\renewcommand{\xi}{\upxi}
\renewcommand{\pi}{\uppi}
\renewcommand{\varpi}{\upvarpi}
\renewcommand{\rho}{\uprho}
%\renewcommand{\varrho}{\upvarrho}
\renewcommand{\sigma}{\upsigma}
%\renewcommand{\varsigma}{\upvarsigma}
\renewcommand{\tau}{\uptau}
\renewcommand{\upsilon}{\upupsilon}
\renewcommand{\varphi}{\upvarphi}
\renewcommand{\chi}{\upchi}
\renewcommand{\psi}{\uppsi}
\renewcommand{\omega}{\upomega}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Оформление заголовков разделов и подразделов

% до какого уровня нумеровать подразделы
\setsecnumdepth{subsection}

% Блок управления параметрами для выравнивания заголовков в тексте
\newlength{\indentlen}
\setlength{\indentlen}{2.5em}
\newcommand{\hdngalign}{} % по левому краю
\newcommand{\hdngaligni}{\hspace{\indentlen}}

\newcommand{\cchapter}[1]{{%
    \renewcommand{\hdngalign}{\centering}
    \renewcommand{\hdngaligni}{}
    \setlength{\indentlen}{0pt}
    \chapter*{#1}}}

% Задаём размер шрифта
\newcommand{\basegostsectionfont}{\fontsize{14pt}{16pt}\selectfont\bfseries}

% Интервал между заголовками и между заголовком и текстом
\newlength{\intvl}
\setlength{\intvl}{1.25\onelineskip}

% Стиль заголовков
\makechapterstyle{thesisgost}{%
    \chapterstyle{default}
    \setlength{\beforechapskip}{0pt}
    \setlength{\midchapskip}{0pt}
    \setlength{\afterchapskip}{\intvl}
    \renewcommand*{\chapnamefont}{\basegostsectionfont}
    \renewcommand*{\chapnumfont}{\basegostsectionfont}
    \renewcommand*{\chaptitlefont}{\basegostsectionfont}
    \renewcommand*{\chapterheadstart}{}
    \renewcommand*{\afterchapternum}{\quad}
    \renewcommand*{\printchapternum}{\hdngaligni\hdngalign\chapnumfont \thechapter}
    \renewcommand*{\printchaptername}{}
    \renewcommand*{\printchapternonum}{\hdngaligni\hdngalign}
}

\makechapterstyle{thesisgostchapname}{%
    \chapterstyle{thesisgost}
    \renewcommand*{\printchapternum}{\chapnumfont \thechapter}
    \renewcommand*{\printchaptername}{\hdngaligni\hdngalign\chapnamefont \@chapapp} %
}

\chapterstyle{thesisgost}

\setsecheadstyle{\basegostsectionfont\hdngalign}
\setsecindent{\indentlen}

\setsubsecheadstyle{\basegostsectionfont\hdngalign}
\setsubsecindent{\indentlen}

\setsubsubsecheadstyle{\basegostsectionfont\hdngalign}
\setsubsubsecindent{\indentlen}

% Интервалы между заголовками
\setbeforesecskip{\intvl}
\setaftersecskip{\intvl}
\setbeforesubsecskip{\intvl}
\setaftersubsecskip{\intvl}
\setbeforesubsubsecskip{\intvl}
\setaftersubsubsecskip{\intvl}

% Сквозная нумерация формул, таблиц, рисунков
\counterwithout{equation}{chapter}
\counterwithout{figure}{chapter}
\counterwithout{table}{chapter}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Оглавление

% Отбивка точками до номера страницы начала главы/раздела
\renewcommand{\cftchapterdotsep}{\cftdotsep}

% до какого уровня подразделов выносить в оглавление
\settocdepth{subsection}

% Запрет переносов в оглавлении
\setrmarg{2.55em plus1fil}

% Обычный шрифт у названий разделов и номеров страниц
\renewcommand{\cftchapterpagefont}{\normalfont}
\renewcommand{\cftchapterfont}{\normalfont}

% Отточия 
\renewcommand{\cftchapterleader}{\cftdotfill{\cftchapterdotsep}}

% Убираем отступ у заголовка
\renewcommand{\tocheadstart}{\setlength{\indentlen}{0pt}}

% Формат заголовка
\renewcommand{\printtoctitle}[1]{\centering\bfseries #1}

% Отступы для подразделов в оглавлении
\setlength\cftsectionindent{\indentlen}
\setlength\cftsubsectionindent{\indentlen}

% Слово Приложение в оглавлении
\renewcommand*{\cftappendixname}{\appendixname\space}

\AfterEndPreamble{
% регистрируем счётчики в системе totcounter
    \regtotcounter{totalcount@figure}
    \regtotcounter{totalcount@table}
    \regtotcounter{TotPages}
    \newtotcounter{totalappendix}
    \newtotcounter{totalchapter}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Библиография

\RequirePackage[%
    backend=biber,      % движок
    bibencoding=utf8,   % кодировка bib файла
    sorting=none,       % список формируется по порядку упоминания в тексте
    style=gost-numeric, % стиль цитирования и библиографии (по ГОСТ)
    language=autobib,   % получение языка из babel, default: autobib 
                        % если ставить autocite или auto, то цитаты в тексте с указанием страницы, 
                        % получат указание страницы на языке оригинала
    autolang=other,     % многоязычная библиография
    clearlang=true,     % внутренний сброс поля language, если он совпадает с языком из babel
    defernumbers=true,  % нумерация проставляется после двух компиляций, 
                        % зато позволяет выцеплять библиографию по ключевым словам 
                        % и нумеровать не из большего списка
    sortcites=true,     % сортировать номера затекстовых ссылок при цитировании 
                        % (если в квадратных скобках несколько ссылок, то отображаться 
                        % будут отсортировано, а не абы как)
    doi=false,          % Показывать или нет ссылки на DOI
    isbn=false,         % Показывать или нет ISBN, ISSN, ISRN
]{biblatex}
\ltx@iffilelater{biblatex-gost.def}%
{\toggletrue{bbx:gostbibliography}%
\renewcommand*{\revsdnamepunct}{\addcomma}}{}

% Отключение курсива в поле автор
\renewcommand*{\mkgostheading}[1]{#1}

% Формат номера в списке библиографии
\defbibenvironment{bibliography}
    {\list
        {\printtext[labelnumberwidth]{%
        \printfield{labelprefix}%
        \printfield{labelnumber}}}
    {\setlength{\labelwidth}{\labelnumberwidth}% 
     \setlength{\leftmargin}{0pt}
     \setlength{\itemindent}{\parindent}%
%     \setlength{\labelsep}{\biblabelsep}%
     \setlength{\itemsep}{\bibitemsep}%
     \setlength{\parsep}{\bibparsep}}%
     \renewcommand*{\makelabel}[1]{\hss\hspace{\dimexpr\labelnumberwidth+\labelsep}##1}}
  {\endlist}
  {\item}

% Исправление ситуации, когда знак номера не поддерживается в pdflatex
\DefineBibliographyStrings{russian}{number={\textnumero}}

% Подключение файлов bib
\addbibresource{bib/bibliography.bib}

% Модификация bib-файла перед обработкой biblatex
% http://tex.stackexchange.com/a/141831/79756
\DeclareSourcemap{
    \maps{
        % преобразование поля language в поле langid, которое использует biblatex
        \map{
            \step[fieldsource=language, fieldset=langid, origfieldval, final]
            \step[fieldset=language, null]
        }
        % удаляем поле issn
        \map[overwrite]{
            \step[fieldset=issn, null]
        }
        % удаляем поле abstract
        \map[overwrite]{
            \step[fieldsource=abstract]
            \step[fieldset=abstract,null]
        }
        % удаляем поле keywords
        \map[overwrite]{
            \step[fieldsource=keywords]
            \step[fieldset=keywords,null]
        }
    }
}

% Тире как разделитель в библиографии традиционной русской длины:
\renewcommand*{\newblockpunct}{\addperiod\addnbspace\cyrdash\space\bibsentence}

% В списке литературы обозначение одной буквой диапазона страниц англоязычного источника
\DefineBibliographyStrings{english}{%
    pages = {p\adddot} % заглавность буквы затем по месту определяется работой самого biblatex
}

% Задаём длину тире в диапазонах
% \cyrdash --- тире «русской» длины, \textendash --- en-dash
\DefineBibliographyExtras{russian}{%
  \protected\def\bibrangedash{%
    \textendash\penalty\value{abbrvpenalty}}%
  \protected\def\bibdaterangesep{\bibrangedash}%
}
\DefineBibliographyExtras{english}{%
  \protected\def\bibrangedash{%
    \textendash\penalty\value{abbrvpenalty}}%
  \protected\def\bibdaterangesep{\bibrangedash}%
}

% Устанавливаем штраф за разрыв в числах, датах и номерах страниц
\setcounter{abbrvpenalty}{10000}

% Устанавливаем штраф за разрыв в названиях
\setcounter{highnamepenalty}{10000}
\setcounter{lownamepenalty}{10000}


% Макросы автоматического подсчёта количества публикаций.
% Печатает невидимую (пустую) библиографию, считая количество источников.
% http://tex.stackexchange.com/a/66851/79756
\newtotcounter{citenum}
\defbibenvironment{counter}
    {\setcounter{citenum}{0}\renewcommand{\blx@driver}[1]{}} % begin code: убирает весь выводимый текст
    {} % end code
    {\stepcounter{citenum}} % item code: считает "печатаемые в библиографию" источники

% Пустой заголовок, для подсчёта публикаций с помощью невидимой библиографии
\defbibheading{nobibheading}{}

\defbibheading{bibliography}{%
  \cchapter{#1}%
  \markboth{#1}{#1}
  \addcontentsline{toc}{chapter}{#1}}

% Заголовок для списка литературы
\newcommand{\bibtitlefull}{СПИСОК ИСПОЛЬЗОВАННЫХ ИСТОЧНИКОВ}

% Вставка источников
\newcommand*{\insertbibliofull}{
	\ifthenelse{\equal{\@ColUrls}{false}}{
		\hypersetup{ urlcolor=black }               % Ссылки делаем чёрными
	}{}
    \printbibliography[section=0,title=\bibtitlefull]
    \printbibliography[section=0,env=counter,heading=nobibheading]
	\ifthenelse{\equal{\@ColUrls}{false}}{
		\hypersetup{ urlcolor={urlcolor} }          % Восстанавливаем цвет ссылок
	}{}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Листинги

% Листинги с исходным кодом программ
\RequirePackage{fancyvrb}
\RequirePackage{listings}

% Ширина текста минус ширина надписи 999
\newlength{\twless}
\newlength{\lmarg}
\setlength{\lmarg}{\widthof{999}}
\setlength{\twless}{\textwidth-\lmarg}

\lstset{ %
    language=python,                % язык указать здесь, если во всех листингах преимущественно 
                                    % один язык, в результате часть настроек может пойти только для этого языка
    numbers=left,                   % где располагаются номера строк
    numberstyle=\fontsize{12pt}{14pt}\selectfont\color{Gray},  % стиль для номеров строк
    firstnumber=1,                  % в этой и следующей строках задаётся поведение нумерации 5, 10, 15...
    stepnumber=5,                   % шаг между номерами строк
    numbersep=5pt,                  % отступ номеров от кода
    backgroundcolor=\color{white},  % цвет фона листинга
    showspaces=false,               % показывать пробелы, добавляя специальные знаки подчёркивания
    showstringspaces=false,         % подчёркивать пробелы в строках
    showtabs=false,                 % показывать символы табуляции
    frame=leftline,                 % рамка вокруг листинга
    rulecolor=\color{black},        % если не задать, то цвет рамки может быть изменён при переносе цветного текста (комментария)
    tabsize=2,                      % отступ табуляции - два пробела
    captionpos=t,                   % заголовок сверху
    breaklines=true,                % автоматический разрыв строки
    breakatwhitespace=false,        % должны ли автоматические разрывы происходить только в пробелах
    basicstyle=\fontsize{12pt}{14pt}\selectfont\ttfamily, % размер шрифта, используемого для кода
    keywordstyle=\color{blue},      % стиль ключевых слов
    commentstyle=\color{ForestGreen}\emph, % стиль комментариев
    stringstyle=\color{Mahogany},   % стиль строк
    escapeinside={\%*}{*)},         % для добавления комментариев в коде
    morekeywords={*,...},           % добавление дополнительных ключевых слов
    inputencoding=utf8,             % кодировка кода
    xleftmargin={\lmarg},           % чтобы весь код и полоска с номерами строк была смещена влево, 
                                    % так чтобы цифры не вылезали за пределы текста слева
}

% http://tex.stackexchange.com/questions/26872/smaller-frame-with-listings
% Окружение, чтобы листинг был компактнее обведён рамкой, если она задаётся, а не на всю ширину текста
\newenvironment{SmallListing}[1][]
{\lstset{#1}\VerbatimEnvironment\begin{VerbatimOut}{VerbEnv.tmp}}
{\end{VerbatimOut}\settowidth\@tempdima{%
        \lstinputlisting{VerbEnv.tmp}}
    \minipage{\@tempdima}\lstinputlisting{VerbEnv.tmp}\endminipage}


\DefineVerbatimEnvironment % с шрифтом 12 пт
{Verb}{Verbatim}
{fontsize=\fontsize{12pt}{14pt}\selectfont}

\newfloat[chapter]{ListingEnv}{lol}{Листинг}

\renewcommand{\lstlistingname}{Листинг}

% Общие счётчики окружений листингов
% http://tex.stackexchange.com/questions/145546/how-to-make-figure-and-listing-share-their-counter
% Если смешивать плавающие и не плавающие окружения, то могут быть проблемы с нумерацией

% https://tex.stackexchange.com/a/252682
\AfterEndPreamble{
    \let\c@ListingEnv\relax % удалить существующий счётчик "ListingEnv"
    \newaliascnt{ListingEnv}{lstlisting} % команда требует пакет aliascnt
    \let\ftype@lstlisting\ftype@ListingEnv % дать окружениям одинаковый приоритет
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Команды для печати титульного листа и задания на ВКР

\def\@AuthorFullName{}
\newcommand{\AuthorFullName}[1]{\gdef\@AuthorFullName{#1}}
\def\@AuthorFullNameGen{}
\newcommand{\AuthorFullNameGen}[1]{\gdef\@AuthorFullNameGen{#1}}
\def\@AuthorShortName{}
\newcommand{\AuthorShortName}[1]{\gdef\@AuthorShortName{#1}}
\def\@AuthorGroup{}
\newcommand{\AuthorGroup}[1]{\gdef\@AuthorGroup{#1}}
\def\@ThesisTitle{}
\newcommand{\ThesisTitle}[1]{\gdef\@ThesisTitle{#1}}
\def\@SupervisorShort{}
\newcommand{\SupervisorShort}[1]{\gdef\@SupervisorShort{#1}}
\def\@SupervisorFull{}
\newcommand{\SupervisorFull}[1]{\gdef\@SupervisorFull{#1}}
\def\@SupervisorDegree{}
\newcommand{\SupervisorDegree}[1]{\gdef\@SupervisorDegree{#1}}
\def\@GOSTComplianceReviewer{}
\newcommand{\GOSTComplianceReviewer}[1]{\gdef\@GOSTComplianceReviewer{#1}}
\def\@PlagiarismChecker{}
\newcommand{\PlagiarismChecker}[1]{\gdef\@PlagiarismChecker{#1}}
\def\@DeptHead{}
\newcommand{\DeptHead}[1]{\gdef\@DeptHead{#1}}
\def\@DeptShort{}
\newcommand{\DeptShort}[1]{\gdef\@DeptShort{#1}}
\def\@DeptFull{}
\newcommand{\DeptFull}[1]{\gdef\@DeptFull{#1}}
\def\@InstHead{}
\newcommand{\InstHead}[1]{\gdef\@InstHead{#1}}
\def\@InstShort{}
\newcommand{\InstShort}[1]{\gdef\@InstShort{#1}}
\def\@InstFull{}
\newcommand{\InstFull}[1]{\gdef\@InstFull{#1}}
\def\@SpecShort{}
\newcommand{\SpecShort}[1]{\gdef\@SpecShort{#1}}
\def\@SpecFull{}
\newcommand{\SpecFull}[1]{\gdef\@SpecFull{#1}}
\def\@City{}
\newcommand{\City}[1]{\gdef\@City{#1}}
\def\@Year{}
\newcommand{\Year}[1]{\gdef\@Year{#1}}
\def\@ThesisPurpose{}
\newcommand{\ThesisPurpose}[1]{\gdef\@ThesisPurpose{#1}}
\def\@ThesisData{}
\newcommand{\ThesisData}[1]{\gdef\@ThesisData{#1}}
\def\@ThesisBooks{}
\newcommand{\ThesisBooks}[1]{\gdef\@ThesisBooks{#1}}
\def\@ThesisReports{}
\newcommand{\ThesisReports}[1]{\gdef\@ThesisReports{#1}}
\def\@ThesisJournals{}
\newcommand{\ThesisJournals}[1]{\gdef\@ThesisJournals{#1}}
\def\@ThesisManuals{}
\newcommand{\ThesisManuals}[1]{\gdef\@ThesisManuals{#1}}
\def\@ThesisStages{}
\newcommand{\ThesisStages}[1]{\gdef\@ThesisStages{#1}}
\def\@ThesisEquipment{}
\newcommand{\ThesisEquipment}[1]{\gdef\@ThesisEquipment{#1}}
\def\@ThesisComputer{}
\newcommand{\ThesisComputer}[1]{\gdef\@ThesisComputer{#1}}
\def\@ThesisLitReview{}
\newcommand{\ThesisLitReview}[1]{\gdef\@ThesisLitReview{#1}}
\def\@IllustrMaterials{}
\newcommand{\IllustrMaterials}[1]{\gdef\@IllustrMaterials{#1}}
\def\@DateApproval{}
\newcommand{\DateApproval}[1]{\gdef\@DateApproval{#1}}
\def\@DateAssignment{}
\newcommand{\DateAssignment}[1]{\gdef\@DateAssignment{#1}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Оформление титульного листа и задания на ВКР

% Строка по центру без отступов
\newcommand\CenterLine[2]
{{\parskip=#1\par\nopagebreak\centering%
#2\par\noindent\ignorespacesafterend}}%

% Строка без отступов
\newcommand\LeftLine[2]
{{\parskip=#1\par\noindent\nopagebreak%
#2\par\noindent\ignorespacesafterend}}%

% Заголовок
\newcommand{\MakeThesisHead}{%
\CenterLine{7pt}{\scriptsize МИНИСТЕРСТВО НАУКИ И ВЫСШЕГО ОБРАЗОВАНИЯ 
РОССИЙСКОЙ ФЕДЕРАЦИИ}%
\CenterLine{0pt}{\miniscule\bfseries ФЕДЕРАЛЬНОЕ ГОСУДАРСТВЕННОЕ 
АВТОНОМНОЕ ОБРАЗОВАТЕЛЬНОЕ УЧРЕЖДЕНИЕ ВЫСШЕГО ОБРАЗОВАНИЯ}%
\CenterLine{0pt}{\small\bfseries <<НАЦИОНАЛЬНЫЙ ИССЛЕДОВАТЕЛЬСКИЙ ТЕХНОЛОГИЧЕСКИЙ}%
\CenterLine{2pt}{\small\bfseries УНИВЕРСИТЕТ {\normalsize <<МИСИС>>}}%
}

% Подчёркнутый текст
\newcommand{\InsertUlineText}[1]{%
\expandafter\uline\expandafter{#1}%
}

% Подчёркнутый текст с отступом
\newcommand{\InsertUlineTextSp}[1]{%
\hspace{1ex}\InsertUlineText{#1\hfill}%
}

% Стиль разреженного текста для заголовка
\sodef\sotitle{}{.12em}{.65em plus .08em minus .06em}{.55em plus .275em minus .183em}

% Тип квалификационной работы
\newcommand{\ThesisDegreeText}{%
\ifthenelse{\equal{\@ThesisDegree}{master}}{\sotitle{МАГИСТРА}}{\sotitle{БАКАЛАВРА}}
}

% Титульная страница и задание на ВКР
\newcommand{\MakeThesisTitlePage}{
% Рамка
\begin{tikzpicture}[remember picture,overlay,shift=(current page.north west)]
\begin{scope}[x={(current page.north east)},y={(current page.south west)}]
\draw[line width=2pt] ($(0,0)+(3cm,-2cm)+(-2pt,2pt)$) rectangle ($(1,1)+(-1cm,2cm)+(2pt,-2pt)$);
\draw[line width=2pt] ($(0,0)+(3cm,-2cm)+(-6pt,6pt)$) rectangle ($(1,1)+(-1cm,2cm)+(6pt,-6pt)$);
\draw[line width=1pt] ($(0,0)+(3cm,-4.85cm)+(2mm,0)$)   -- ($(1,0)+(-1cm,-4.85cm)+(-2mm,0)$);
\draw[line width=1pt] ($(0,0)+(3cm,-4.85cm)+(2mm,2pt)$) -- ($(1,0)+(-1cm,-4.85cm)+(-2mm,2pt)$);
\end{scope}
\end{tikzpicture}
% Заголовок
\thispagestyle{empty}
\begin{adjustwidth}{0cm}{-0.5cm}
\MakeThesisHead
\vspace{1.7cm}

\begin{minipage}{15.5cm}
\textsl{\small ИНСТИТУТ \uline{\@InstFull\hfill}}\par
\textsl{\small КАФЕДРА \uline{\@DeptFull\hfill}}\par
\textsl{\small НАПРАВЛЕНИЕ \uline{\@SpecFull\hfill}}\par
\end{minipage}
\vspace{1.4cm}

\SingleSpacing
\begin{center}
\fontsize{26}{31.2}\selectfont\bfseries
\sotitle{ВЫПУСКНАЯ КВАЛИФИКАЦИОННАЯ РАБОТА} 
\ThesisDegreeText
\end{center}
\vspace{1.5cm}

\DoubleSpacing*
\begin{minipage}{15.5cm}
\small\textbf{на тему:} 
\uline{<<}\InsertUlineText{\@ThesisTitle}\uline{>>\hfill}
\end{minipage}
\vspace{0.5cm}

\begin{minipage}{15.5cm}
\ifthenelse{\equal{\@StdTitle}{true}}{
    \small\textit{Студент} 
    \uline{\hfill}\hspace{1ex}\makebox[4cm][l]{\uline{\hspace{0.5ex}\@AuthorShortName\hfill}}\par
    \small\textit{Руководитель работы} 
    \uline{\hfill}\hspace{1ex}\makebox[4cm][l]{\uline{\hspace{0.5ex}\@SupervisorShort\hfill}}\par
    \small\textit{Нормоконтроль проведен} \uline{\hfill}\hspace{1ex}\makebox[4cm][l]{\uline{\hspace{0.5ex}\@GOSTComplianceReviewer\hfill}}\par
    \small\textit{Проверка на заимствования проведена} \uline{\hfill}\hspace{1ex}\makebox[4cm][l]{\uline{\hspace{0.5ex}\@PlagiarismChecker\hfill}}\par
}{
	\newlength{\authlen}
	\settowidth{\authlen}{\small\textit{\@AuthorFullName}}
	\newlength{\suplen}
	\settowidth{\suplen}{\small\textit{\@SupervisorFull}}
	\newlength{\mlen}
	\setlength{\mlen}{\maxof{\authlen}{\suplen}}
    \small\textit{Студент} 
	\uline{\hfill}\makebox[\mlen][l]{\uline{\textit{\@AuthorFullName}\hfill}}\par
    \small\textit{Руководитель работы} 
    \uline{\hfill}\makebox[\mlen][l]{\uline{\textit{\@SupervisorFull}\hfill}}\par
    \small\textit{Нормоконтроль проведен}
	\uline{\hfill}\makebox[\mlen][l]{\uline{\textit{\@GOSTComplianceReviewer}\hfill}}\par
	\small\textit{Проверка на заимствования проведена}
	\uline{\hfill}\makebox[\mlen][l]{\uline{\textit{\@PlagiarismChecker}\hfill}}\par
}
\end{minipage}
\vspace{0pt plus3fill}

\begin{center}
\small\textbf{Работа рассмотрена кафедрой и допущена к защите в ГЭК}
\vspace{-4mm}\par
\begin{tikzpicture}
    \draw[line width=1pt,line cap=rect] (1.8cm,0) -- (15.2,0);
\end{tikzpicture}
\end{center}
\vspace{3mm}

\begin{minipage}{15.5cm}
\ifthenelse{\equal{\@StdTitle}{true}}{
    \small\textit{Заведующий кафедрой} 
    \uline{\hfill}\hspace{1ex}\makebox[4cm][l]{\uline{\hspace{0.5ex}\@DeptHead\hfill}}\par
    \small\textit{Директор института} 
    \uline{\hfill}\hspace{1ex}\makebox[4cm][l]{\uline{\hspace{0.5ex}\@InstHead\hfill}}\par
}{
    \small\textit{Заведующий кафедрой} \uline{\hfill\textit{\@DeptHead}}\par
    \small\textit{Директор института} \uline{\hfill\textit{\@InstHead}}\par
}
\end{minipage}

\vspace{0pt plus2fill}
\begin{center}
\footnotesize \@City, \@Year
\end{center}

\SingleSpacing*
\clearpage
% Задание на ВКР
\thispagestyle{empty}
\MakeThesisHead
\OnehalfSpacing*
\vspace{-0.1cm}
{\small
\begin{tikzpicture}
    \draw[line width=1pt,line cap=rect] (0,0) -- (\textwidth,0);
    \draw[line width=1pt,line cap=rect] (0,2pt) -- (\textwidth,2pt);
\end{tikzpicture}\par\vspace{0.3cm}\noindent
\hfill\textbf{УТВЕРЖДАЮ}\par
\noindent\makebox[8cm][l]{\textbf{Институт}\hspace{1ex}\uline{\@InstShort\hfill}}\hfill\hfill\par
\noindent\makebox[8cm][l]{\textbf{Кафедра}\hspace{1ex}\uline{\@DeptShort\hfill}}\hfill
\textbf{Зав. кафедрой}\hspace{1ex}\makebox[4cm][l]{\uline{\hfill\@DeptHead\hfill}}\par
\noindent\makebox[8cm][l]{\textbf{Направление}\hspace{1ex}\uline{\@SpecShort\hfill}}\hfill \@DateApproval \par}
\vspace{0.5cm}

\begin{center}
\bfseries\so{ЗАДАНИЕ}\par
\so{НА ВЫПОЛНЕНИЕ ВЫПУСКНОЙ}\par
\so{КВАЛИФИКАЦИОННОЙ РАБОТЫ}
\ThesisDegreeText
\end{center}
\LeftLine{0pt}{\small \textbf{Студенту группы}\hspace{1ex}%
\uline{\@AuthorGroup, \@AuthorFullNameGen\hfill}}
\CenterLine{0pt}{\miniscule (номер группы, Ф.И.О. полностью)}
\begin{enumerate}[wide,labelindent=1.25cm,itemsep=\parsep+2ex,topsep=\topsep+1ex,label=\arabic*.]
\OnehalfSpacing*
\scriptsize
\item Тема работы\InsertUlineTextSp{\@ThesisTitle}

\item Цель работы\InsertUlineTextSp{\@ThesisPurpose}

\item Исходные данные\InsertUlineTextSp{\@ThesisData}
 
\item Основная литература, в~том числе:

\begin{enumerate}[wide,labelindent=1.25cm,itemsep=\parsep+2ex,label=4.\arabic*.]
\item Монография, учебники \mbox{и~т.\,п}.\InsertUlineTextSp{\@ThesisBooks}

\item Отчёты по НИР, диссертации, дипломные работы \mbox{и~т.\,п}.
\InsertUlineTextSp{\@ThesisReports}

\item Периодическая литература\InsertUlineTextSp{\@ThesisJournals}

\item Справочники и~методическая литература (в~том числе литература 
по методам обработки экспериментальных данных)
\InsertUlineTextSp{\@ThesisManuals}

\end{enumerate}

\item Перечень основных этапов исследования и~форма промежуточной 
отчётности по каждому этапу\InsertUlineTextSp{\@ThesisStages}

\item Аппаратура и методики, которые должны быть использованы 
в~работе\InsertUlineTextSp{\@ThesisEquipment}

\item Использование ЭВМ\InsertUlineTextSp{\@ThesisComputer}

\item Перечень (примерный) основных вопросов, которые должны 
быть рассмотрены и~проанализированы в~литературном 
обзоре\InsertUlineTextSp{\@ThesisLitReview}

\item Перечень (примерный) графического и~иллюстрированного 
материала\InsertUlineTextSp{\@IllustrMaterials}

\item Руководитель работы\hspace{1ex}\uline{\@SupervisorDegree, \@SupervisorFull\hfill}
\CenterLine{0pt}{\miniscule (должность, уч. степень, звание, Ф.И.О.)}
\uline{\hfill}
\CenterLine{0pt}{\miniscule (подпись)}

\end{enumerate}
\vspace{0.5cm}

\thispagestyle{empty}
\hspace{1cm}{\small Дата выдачи задания \uline{\hfill \@DateAssignment \hfill}}
\vspace{0.5cm}

\hspace{1cm}{\small\textbf{Задание принял к исполнению студент} \uline{\hfill}}
\CenterLine{0pt}{\miniscule\hspace{10cm} (подпись)}
\end{adjustwidth}

% Включаем полуторный интервал для последующего текста
\OnehalfSpacing*
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Прочее

% Настройка приложений
\newcommand{\ThesisAppendix}{
    \appendix
    \setlength{\midchapskip}{20pt}
    \renewcommand*{\afterchapternum}{\par\nobreak\vskip \midchapskip}
    \renewcommand\thechapter{\Asbuk{chapter}} % Чтобы приложения русскими буквами нумеровались
    \renewcommand{\hdngaligni}{\centering}
    \renewcommand*{\printchaptername}{\chapnumfont \appendixname}
}

% Команды для сочетания существительного с предшествующим числительным
% используются при автоматическом подсчёте количества страниц, рисунков, таблиц и т.п.
% http://www.linux.org.ru/forum/general/6993203#comment-6994589 (используется totcount)
\newcommand{\formtotal}[5]{%
    \newcount\@c
    \@c\totvalue{#1}\relax
    \newcount\@last
    \newcount\@pnul
    \@last\@c\relax
    \divide\@last 10
    \@pnul\@last\relax
    \divide\@pnul 10
    \multiply\@pnul-10
    \advance\@pnul\@last
    \multiply\@last-10
    \advance\@last\@c
    #2%
    \ifnum\@pnul=1#5\else%
    \ifcase\@last#5\or#3\or#4\or#4\or#4\else#5\fi
    \fi
}
\newcommand{\pls}[4]{%
    #2\ifnum\totvalue{#1}>1#4\else#3\fi
}
\newcommand{\formbytotal}[5]{\total{#1}~\formtotal{#1}{#2}{#3}{#4}{#5}}
\newcommand{\formbytotalen}[4]{\total{#1}~\pls{#1}{#2}{#3}{#4}}

% Команда для пояснения значений символов после формулы
% https://tex.stackexchange.com/a/493780/42803
\newcommand{\where}[1]{%
  \hspace*{\fill}%
  \parbox[b]{\textwidth-\parindent-\widthof{где }}{%
    \makebox[0pt][r]{\hspace{\parindent}где }\ignorespaces#1%
  }\vspace{\belowdisplayskip}%
}

\AtBeginDocument{
    % Абзацный отступ
    \setlength{\parindent}{2.5em}
    
    % Заполнение атрибутов PDF файла
    \hypersetup{
        pdftitle={ВКР \@AuthorShortName\ \@Year},
        pdfauthor={\@AuthorShortName},
        pdfsubject={\@ThesisTitle},
    }

    % Титульный лист и задание
    \MakeThesisTitlePage
}

\AtEndDocument{
    % Счётчик количества приложений
    \setcounter{totalappendix}{\value{chapter}}
}

\endinput