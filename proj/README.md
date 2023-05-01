# VHDL project

### Topic


Časovač na intervalový (kruhový) trénink s možností nastavit počet kol, dobu kola a pauzy mezi nimi za běhu aplikace.


### Team members

* Roman Szymutko (responsible for construction of statemachine)
* Slávek Rylich (responsible for DBC convertor)
* Matyáš Tomeš (responsible for procokol)

## Theoretical description and explanation

Projekt, jehož cílem bylo vytvořit časovač s funkcemi nastavení času pro cvičení, pauzu a nastavení počtu kol. Celý časovač byl navržen jako stavový automat, který se přepíná mezi jednotlivými stavy SET=>RUN=>PAUSE=>(RUN<->PAUSE podle toho, kolik je nastaveno kol)=>FINISH. Díky "clocku_enable", který byl implementován, se na každou vzestupnou hranu počítalo jako jedna sekunda.

V "SET" stavu se nastaví všechny údaje, jako je čas na cvičení, čas na pauzu a počet kol. Tyto údaje se nastavují současně podržením resetu, protože celý stavový automat se resetuje a začíná od začátku. Po puštění tlačítka resetu přechází časovač do stavu "RUN" a začne se odečítat nastavená hodnota, díky "clocku_enable", který byl implementován a na každou náběžnou hranu odečítal jednu sekundu. Znamenaje, že každá náběžná hrana je 1 sekunda. Poté, když časový údaj spadne na "0", přechází stav na "PAUSE" a podle nastavené hodnoty se čas začíná odečítat stejným způsobem jako v "RUN" stavu.

Celý cyklus se opakuje podle toho, kolik bylo nastaveno kol v "SET" stavu. Po každém dokončení stavu "PAUSE" se odečte jedno kolo. Poté, když všechna kola doběhnou, přechází stavový automat ze stavu "PAUSE" do stavu "FINISH".

Zadávání hodnot času pro cvičení a pauzu je provedeno součtem logických jedniček, což znamená, že bylo použito celé číslo (Integer) namísto bitů. To znamená, že každá jednička (spínač) reprezentuje 10 sekund k navýšení času. Poté takové číslo bylo převedeno do binární čísla pro bcd convertor. Stejně tak byl round v binární čísle a byl převeden na BCD convertor.


Modul "bit_to_BCD" využívá stavový automat k implementaci převodu. Stavový automat má tři stavy: start, shift a done. V startovním stavu je binární vstupní číslo načteno do binárního registru a BCD výstupní registr je nastaven na nulu. V stavu shift se binární číslo posune o jeden bit doleva a BCD výstup se aktualizuje, aby odrážel nové binární číslo. Tento proces se opakuje N-krát, kde N je počet bitů v binárním vstupním čísle. V stavu done je převod dokončen a stavový automat se vrátí do startovního stavu.

Převod z binárního na BCD formát se provádí pomocí sekvence operací na výstupu BCD. Výstup BCD je rozdělen na dvě čtyřbitová vektory, bcd0 a bcd1. V prvním kroku převodu se hodnota každého BCD čísla nastaví na nulu. Ve druhém kroku se binární číslo převede do BCD formátu pomocí sekvence operací sčítání a odčítání. Nakonec je BCD výstup upraven tak, aby se zajistilo, že každé číslo je v rozsahu 0 až 9.

Následně všechny výstupy z "bit_to_BCD" přivedeny na vstup "driver_7seg_4digits_for_time". A poté z driveru přivedeno na vstup "hex_7seg", tak aby čislo mohlo být zobrazováno.



## Hardware description of demo application
Celá schematika, jak celý program/přístroj funguje. Ze statemachine poslány výstupy -> sig_round do bcd_convertor1 a -> sig_output do bcd_converter0. Provede se převod a výstupy přejdou do driveru pro 7seg. data0 a data1 - reprezentují timer; data2 a data3 - reprezentují počet kol. Násldně zabalené do topu a výstupem jsou potom čtyři segmentovky. Vstup topu jsou všechny switche na nastavení hodnot, tlačítko na reset a CLOK100MHZ na clock. Vše je právě sychronizované clokem, který je přiveden stejně jako reset na každý modul topu.
![image](img/schematic_visio.jpg)
Schematika, jak byla vygenerovana v programu "Vivado"
![image](img/schematic_vivado.jpg)
Insert descriptive text and schematic(s) of your implementation.

## Software description

Put flowchats/state diagrams of your algorithm(s) and direct links to source/testbench files in `src` and `sim` folders. 
![image](img/state_dia.png)
### Component(s) simulation

Na obrázku níže je krásně vidět, když binarním vstupem přivedem čislo například "001010" což je v desitkové soustavě 10, tak je krásně vidět, jak přes shiftovaní se na výstup bcd1 = 1 a bcd0 = 0 a když je dáme vedle sebe -> vytváří to  číslo 10.

Pro další ukázku:
"000010" což je v desitkové soustavě 2, tak je krásně vidět, jak přes shiftovaní se na výstup bcd1 = 0 a bcd0 = 2 a když je dáme vedle sebe -> vytváří to  číslo 02 - respektivě číslo 2.

"011000" což je v desitkové soustavě 24, tak je krásně vidět, jak přes shiftovaní se na výstup bcd1 = 2 a bcd0 = 4 a když je dáme vedle sebe -> vytváří to  číslo 24

A reset restartuje modul.
![image](img/sim_bcd.png)
Je zde vidět níže na obrázku, jak se stavy automatu mění. Nastaveno 2 kola, 2 krát se opakuje, nastaveno 20 sekund času na cvičení a 30 sekund na pauzu. viz. Obrazky níže.

při zadaní resetu je stav v "SET"
![image](img/sim_states.png)
![image](img/sim_state_pause.png)
![image](img/sim_state_run.png)
## Instructions

Write an instruction manual for your application, including photos or a link to a video.

1.Press and hold reset button 
2.Set time and rounds on switches
3.release button
4.The timer has started and you can start working out

![image](img/photo.jpg)
## References

