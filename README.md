# Efektiven algoritem dinamičnega programiranja pri problemu nahrbtnika z minimalnimi stroški in maksimalno zapolnitvijo


*Veronika Nabergoj*

*Luka Vidic*

## Uvod

Predstavila bova problem nahrbtnika z danim naborom predmetov, ki imajo predpisano vrednost in težo. Skušala bova poiskati maksimalno napolnitev nahrbtnika z najmanjšo skupno vrednostjo vsebovanih predmetov. Napisala bova efektiven dinamičen algoritem, ki ima psevdo-polinomsko časovno zahtevnost. Pokazala bova ekvivalenco najinega problema in klasičnega problema polnjenja nahrbtnika. 

## Kratek opis
S tem delom bova poskusila ponuditi poglobljeno študijo točnih metod reševanja MCMKP in MPMKC do dokazljive optimalnosti.
Najprej, bova podala učinkovit dinamični algoritem za reševanje MCMKP, katerega časovna zahtevnost je $O(nC)$ in prostorska zahtevnost $O(n+C)$. Nato bova predstavila nove teoretične rezultate o stabilnosti dveh najboljših MPI (»mixed-iteger programming« ) modelov iz literature. Kasneje bova v obsežni računski študiji na raznolikih primerih pokazala hitrost dinamičnega algoritma v primerjavi z vrhunskim komercialnim mešano celoštevilskim programskim (MIP) reševanjem.

Na koncu bova pokazala še ekvivalenco med MCMKP in MPMKC in da lahko neko optimalno rešitev MCMKP dobimo z ustrezno linearno transformacijo. Ta nakazuje, da je MPMKC prav tako šibko NP-zahteven ter da obstaja postopek dinamičnega programiranja, ki teče v $O(n(W-C))$ času in zahteva $O(n+(W-C))$ prostora, kjer je W skupna teža vseh predmetov. 

## Klasični problem nahrbtnika

Najbolj znan problem v kombinatorični optimizaciji je problem nahrbtnika (PN), ki je definiran takole: Nahrbtnik s kapaciteto $C>0$ in naborom predmetov $I=\{1,…,n\}$, z vrednostjo $p_i≥0$ in težo $w_i≥0$. Iščemo maksimalen profit, pri katerem je teža nahrbtnika ne presega kapacitete nahrbtnika. Ta problem rešimo s programi mešano celoštevilskega linearnega programiranja:
$$\max{\bigg\{\sum_{i \in I}p_i x_i : \sum_{i \in I} w_i x_i \le C, x_i \in \{0,1\}, i \in I \bigg\}},$$


kjer vsaka spremenljivka $x_i$ zavzame vrednost 1, če je i-ti predmet v nahrbtniku. Vsi parametri so cela števila. 
Optimizacijski problem, ki je podoben temu problemu je tudi najin problem nahrbtnika.

### Definicija 1
(Minimalni stroški, maksimalno število predmetov v nahrbtniku - MCMKP)
 Z začetnimi podatki $(I,p,w,C)$, je cilj najti maksimalno napolnitev nahrbtnika  $S^* \subset I$, ki minimizira vrednosti izbranih stvari.
$$S^* = \arg \max_{S \subset I} \bigg\{ \sum_{i \in S} p_i \bigg| \sum_{i \in S}w_i \ge C \text{ and } \sum_{i \in S \backslash \{j\}}w_i < C, \forall j \in S \bigg\}$$
Pri problemu MCMKP privzamemo da je problem $(I,p,w,C)$ netrivialen in je pripadajoča optimalna rešitev $S^*$ lastna podmnožica množice $I$. Obratno kot pri klasičnem problemu nahrbtnika, pri MCMKP iščemo lastno podmnožico predmetov, ki jih damo v nahrbtnik, pri čemer minimiziramo njihovo vrednost. Reševanje klasičnega PN, pri katerem maksimiziramo vrednost je pri MCMKP nadomeščena z minimiziranjem vrednosti ter tako dobimo ničelno zapolnjenost. Zato mora biti pogoj maksimalne zapolnitve nahrbtnika izražen eksplicitno, ko iščemo optimalno rešitev. 
MCMKP lahko apliciramo na problem razporejanje nalog na enem stroju z istim časom dospetja in istim rokom. Ta je torej sestavljen iz izbiranja podmnožice nalog, katere moramo razvrstiti (pred iztekom roka) pri čemer vrstni red postane nepomemben. $I$ je množica vseh nalog, trajanje nalog je podano z  $w_i$, strošek izvajanje naloge je  $p_i$. Skupen rok je $C$, ki ustreza kapaciteti nahrbtnika v MCMKP. Cilj je minimiziranje stroška pri izvajanju izbranih nalog in hkrati maksimizirati podmnožico izbranih nalog. Tako se problem iskanja najboljšega razporeda prevede na problem nahrbtnika (MCMKP).
Podobno, pri primeru MCMKP, je cilj maksimizirati »dobiček« razvrščenih nalog pri čemer želimo minimalizirati podmnožico nalog, ki presegajo rok (to je, ohraniti najmanjše pokritje). 
 
