# Pagrindiniai nustatymai
Pakeisti lapo šabloną languotu arba paprastu.
*Journal > Configure Page Template > Graph/Plain*

# Įrankių juosta tik su pagrindinėmis spalvomis

Atsidarome failą `C:\Users\User\AppData\Local\xournalpp\toolbar.ini` ir į jį apačioje dedame:
```
[Xournal++ & fav colors]
toolbarTop1=SAVE,NEW,OPEN,SEPARATOR,CUT,COPY,PASTE,SEPARATOR,UNDO,REDO,SEPARATOR,PEN,ERASER,HIGHLIGHTER,IMAGE,TEXT,MATH_TEX,DRAW,SEPARATOR,SELECT,VERTICAL_SPACE,HAND,SEPARATOR,FINE,MEDIUM,THICK,SEPARATOR,TOOL_FILL,SEPARATOR,COLOR(0x000000),COLOR(0x00c0ff),COLOR(0xff0000),COLOR(0x00ff00),SEPARATOR,SELECT_FONT
toolbarBottom1=PAGE_SPIN,SEPARATOR,LAYER,GOTO_FIRST,GOTO_NEXT_ANNOTATED_PAGE,GOTO_LAST,DELETE_CURRENT_PAGE,INSERT_NEW_PAGE,SPACER,PAIRED_PAGES,PRESENTATION_MODE,ZOOM_100,ZOOM_FIT,ZOOM_OUT,ZOOM_SLIDER,ZOOM_IN,SEPARATOR,FULLSCREEN
name=Xournal++ & fav colors
```
# Lango dydis

Nepakeitus šių nustatymų, *Xournal++* langas neatsidaro maksimizuotas.
Todėl reikia nueiti į `C:\Users\User\AppData\Local\xournalpp\settings.xml`
ir pakeisti numatytąsias reikšmes į šias:
```
  <property name="mainWndWidth" value="1920"/>
  <property name="mainWndHeight" value="1080"/>
  <property name="maximized" value="true"/>
```
# Spalvų perjungimo klavišų kombinacija plėtinys

Šis plėtinys visai neblogas naudojant grafinę planšetę, nes nereikia maigyt spalvas, o paskui su *AutoHotkey* galima dar tą pačią kombinaciją baindint prie kokio nors *F12* klavišo. Jis jau įkaltas toje pačioje *Xournal++* programoje.
Norint jį įjungti, reikia meniu juostoje pasirinkti *Plugin > Plugin Manager > ColorCycle > Enabled*. Dabar bus galima perjungti spalvas *Alt* + C kombinacija.

### Tik pagrindinių spalvų perjungimas

Norint 
* Išsisaugome `C:\Users\User\Programs\Xournal++\share\xournalpp\plugins\ColorCycle\main.lua` failą, galime jį nukopijuoti ir kopiją pavadinti *main.lua.bak* toje pačioje vietoje.
* Pakeičiame `local colorList` reikšmes į:
```
local colorList = { 
  {"black", 0x000000},
  {"lightblue", 0x00c0ff},
  {"red", 0xff0000},
  {"lightgreen", 0x00ff00}
}
```
Paskui nueiti į pluginų menedžerį ir įjungti tą *ColorCycle*.
# *AutoHotkey* skriptai
*Xournal++* patogiau naudoti viena ranka rašant, kita pasirenkant spalvą, priemonę, liniją ar formą navigaciniais klavišais, taip pat galima naudoti dalį ekrano užimantį, viršuje liekantį langą tam tikroms veikloms („pane mode“). Tam sukurtas skriptas `xournal++.ahk`, kuris yra paleidžiamas iš pradžios skripto `initiator.ahk`. Pradžios skriptas atlieka dar kelias papildomas funkcijas užtikrinant optimalų veikimą:
* Paleidimo metu ištrina individualių failų nustatymus („metadata“), kurie laiko paskiausiai atvertą puslapį bei mastelį. 
* Atidaro failus iššaukiant *AutoHotkey* vykdomąjį failą:
  `AutoHotkey.exe [skriptas] [failas]`
  tada padidina numatytąjį 100% mastelį iki 161%
* Atidaro naują programos instanciją sumažinant mastelį iš numatytojo 287% iki 162%
* Išlaukia *Xournal++* vykdomojo failo paleidimo ir tik tada paleidžia esminį `xournal++.ahk` skriptą
Norint tai pritaikyti veikime atidarant failus tereikia pakeisti `.xopp` failų *Open with* nustatymą į `Scripts\Xournal++\initiator.bat`. Tai pasirinkus, failai bus vaizduojami su tuščio failo ikona, tačiau tai nekenkia funkcionalumui.
~~Galima pridėti ikoną naudojant `Scripts\Xournal++\initiator.reg` failą – prie `.xopp` failo asociacijos (iš tiesų būtent prie asociacijų, priskirtų `initiator.bat`) bus priskirta `icon.ico` ikona, esanti `Scripts\Xournal++` aplanke. Reikia perkrauti kompiuterį, kad ikona matytųsi.~~
~~Norint atstatyti tereikia pridėti `initiator reverse.reg` failo duomenis prie registro.~~

Atnaujinimas: `initiator.reg` buvo sujungtas su `xournal++.reg`, kuris prideda `.xopp` failus prie darbalaukio kontekstinio meniu *New*. Reikia sukurti tuščią failą pavadinimu `Template.xopp` per pačią *Xournal++* programą ir išsaugoti `C:\Users\User\Programs\Xournal++`.

Teoriškai galima kompiliuoti `initiator.ahk` su norima ikona, kuri bus rodoma failų piktogramose, tačiau sukompiliavus `initiator.ahk` antivirusinė programa aptinka grėsmę vykdomajame faile, todėl geriau apsieiti būtent šiuo būdu.
# Sugadintų ikonų pakeitimas naujesnėse versijose
Su 1.1.2 versija kažkoks programistas nedažiūrėjo ir įgrūdo anokią kitokią „Adwaitos“ versiją į programą, ale mandresnė tokia, kur visokie simboliai yra juodi vietoj sidabrinių. Bet kai visur kitur rodo šlykščius eroro simbolius, nes zaraza neranda paprasčiausiai tokių ikonų su šiais failneimais, tiesiog norisi susigražinti tas senas geras. Tad išskleidus `share\icons\Adwaita` iš diegimo failo *7-Zip* programa į `C:\Users\User\Programs\Xournal++\share\icons`, prieš tai ištrynus numatytųjų aplanką viskas veiks čiki briki.
