Mega riassunto di Base Di Dati
# Vocabolario

- **Dangling**
  Record che vengono persi durante una **join**
- **Cluster**
  Area di memoria secondaria assegnata al DBMS
- **Reference Monitor**
  Meccanismo utilizzato per decretare l'autorizzazione di un utente _(totale o parziale)_ all'esecuzione di un operazione.
- **Granularità dei permessi**
  Indica a quale tipologia di oggetti _(attributo, relazione, database, Funzione/procedura, ...)_ un determinato permesso deve essere applicato

---
# Caratteristiche DMBS

## Architettura a 3 livelli di un DBMS

1. **Esterno**:
	Rappresentazione di una porzione della base di dati tramite l'utilizzo del livello logico _(Viste)_
2. **Logico**: 
	Descrizione della basi di dati per mezzo del modello logico adottato
	descrizione di come sono strutturati i dati dal punto di vista logico
3. **Interno**:
	Rappresentazione del livello _Logico_ tramite strutture fisiche di memorizzazione

Tra i diversi livelli c'è Indipendenza

## Componenti di un DBMS

- DDL: Data Definition Language
	È la parte del linguaggio usata per **definire la struttura** della base di dati.
	`CREATE ALTER DROP`

- DML: Data Manipulation Language
	Serve a manipolare i dati contenuti nel database.
	`INSERT UPDATE DELETE`

- DQL:  Data Query Language
	Serve a **interrogare** la base di dati.
	`SELECT`

- DCL: Data Control Language
	Serve a controllare chi può fare cosa sul database.
	`GRANT REVOKE`

**DDL** → modifica la struttura 
**DML** → modifica i dati
**DQL** → legge/interroga i dati
**DCL** → modifica i permessi

- **Autodescrizione**: Il DBMS conserva dati e descrizione dei dati
	Linguaggi DDL e DML

- **Viste multiple**:
	Utenti diversi possono vedere rappresentazioni differenti della stessa base di dati _(Senza dati duplicati)_
	**Multiutenza** Utilizzo contemporaneo della bd

- **Controllo della concorrenza**:
	insieme dei meccanismi con cui il DBMS coordina operazioni eseguite contemporaneamente
	Il controllo della concorrenza impedisce che l'accesso contemporaneo di più utenti produca **inconsistenze** o **perdita di dati.**

- **Controllo dell'accesso**:
	Chi può fare quale operazione su quali dati, gestito, a livello SQL, soprattutto tramite il **DCL**

---
## Definizioni di DBMS

DBMS -> Software
Cosa fa? -> Aiuta a definire, costruire, modificare, gestire una base di dati
mantenendo sicurezza e consistenza dei dati
Base di dati  -> Collezione di dati gestita da un DBMS

---
## Utenza di un DBMS

- **DBA**: 
	Database Admin
- **DB User**:
	Sono utenti con privilegi specifici e limitati.
	- **Developer**:
		Interazione con DML per sviluppo di un applicativo
	- **Occasional User**:
		Utenza che compie attività non standard
	**Occasional User Inesperto**:
		Utenza che compie attività non standard senza avere info sul db tramite applicativi
#### Differenza principale
- Il **DBA** amministra il sistema.
- Il **developer** costruisce applicazioni che utilizzano il database.
- L’**occasional user non esperto** usa funzioni già predisposte.
- Il **casual user** consulta i dati in maniera più autonoma e variabile.

---
## Accesso ad un DBMS

- Locale tramite OS
- Rete tramite TCP/IP

I DBA e i DB User accedono alla base di dati tramite protocollo TCP/IP con un client che si interfaccia con il server del DBMS o localmente tramite un client con protocollo unix socket

---
# Chiavi

- **Superchiave**: insieme di attributi che identifica univocamente un record
- **Chiave**: superchiave minimale 
- **Chiave primaria** chiave scelta per rappresentare record, UNIQUE NOT NULL
- **Chiave candidata** chiave che potrebbe essere PK ma non lo è

_Sia chiave che superchiave possono contenere valori null_

---
# Modello Relazionale

- **Grado di una relazione**: # di attributi che la compongono
- **Cardinalità di una relazione**: # di record che la costituiscono

Il dominio di una relazione $R$ tra due attributi $A$ e $B$ è sempre il prodotto cartesiano dei domini degli attributi $D_A \text{ x } D_B$.

$$
R(D_1, D_2) \lor R(A_1, A_2)
$$
Può essere rappresentato con i domini $D_x$ o con dei nomi associati $A_x$.

I valori assunti dagli attributi di ciascun $r$ hanno dominio del proprio attributo.

Una relazione $R$ può essere definita posizionalmente con i domini $D_x$ d
Lo **schema** di una base di dati $BD$ è l'insieme delle relazioni che la compongono:
$$
BD = \{ R_1, R_2, ..., R_m \}
$$
## Vincoli del modello relazionale

1. **valori mancanti (null values)**
	- si può definire **NOT NULL**
	Semantica:
	- Valore ignoto ma esiste
	- Valore non esistente
	- Indistinguibilità tra i due
#### Vincoli di integrità di una relazione $R$ 
sono i vincoli che devono essere soddisfatti da un record $r$ per appartenere alla relazione $R$.

2. **vincoli di dominio**
3. **vincoli di ennupla** 
4. **vincoli di superchiave (vincolo di univocità)**
	Ogni record $r$ deve essere univocamente identificato da un insieme di attributi UNIQUE (superchiave)

5. **Vincolo di entity integrity**
	Non è possibile avere valori nulli sull'identificatore di una relazione.
	Una PK segue questo vincolo
	`PRIMARY KEY`, assume i vincoli `NOT NULL` e `UNIQUE `
	
6. **Vincoli integrità referenziale**
	- I valori assunti dalla FK devono essere presenti fra i valori che costituiscono l'attributo referenziato
	- La FK deve avere lo stesso dominio dell'attributo referenziato
	- l'attributo referenziato da una FK deve essere una chiave nella relazione referenziata 

Gli eventi di modifica UPDATE e DELETE devono essere sottoposti a dei controlli di integrità.

---
# Forme Normali e normalizzazione

obiettivi della normalizzazione:
- ridurre i valori nulli
- ridurre la ridondanza dei dati 

## Dipendenza funzionale
Una **dipendenza funzionale** $X → Y$ tra due sottoinsiemi di attributi $X$ e $Y$ di una relazione R stabilisce un vincolo sui _record_, il valore assunto dagli attributi di $X$ determina il valore assunto dagli attributi di $Y$.
$F^+$ è l'insieme delle dipendenze funzionali.

## Forme Normali
$\forall X \rightarrow A$ dipendenze funzionali di $R$.
### BCNF
Ogni dipendenza funzionale $X \rightarrow A$ è superchiave
### 3NF
Ogni dipendenza funzionale $X \rightarrow A$ è superchiave, o
$A$ appartiene ad una **Ciave** _(superchiave minimale)_
### 2NF
La PK è formata da 1 solo attributo, o
Gli attributi $A$, che non fanno parte di una chiave, dipendono in modo completo da $X$ _(Non posso togliere attributi da $X$)_
### 1NF
Tutti gli attributi $A$ di $R$ devono essere **atomici**

---
# Progettazione Fisica

I dati in memoria secondaria sono organizzati in **Blocchi** di dimensione fissa

**Buffer**: Allocazione dei dati gestiti dal DBMS sulla memoria centrale
Il buffer gestisce autonomamente la lettura/scrittura dei dati sulla memoria secondaria _(primitiva **Flush**)_, le applicazioni possono richiedere la scrittura sincrona in modo forzato se necessario _(primitiva **Force**)_.

**Buffer** diviso in **Pagine** composte da $x$ **Blocchi**.

## Fattore di Blocco

Fattore di blocco $bfr$: numero di record contenti in un blocco
$B$ è la dimensione del blocco, $R$ è la dimensione media del record

$$
bfr = \lfloor\frac{B}{R}\rfloor
$$

Se i record avessero tutti la stessa dimensione in byte si tratta di **record a lunghezza fissa**, altrimenti di **record a lunghezza variabile**.

## Strutture Primarie

Le **strutture primarie** stabiliscono come i record vengono fisicamente organizzati nei file del database.

### Strutture ad accesso sequenziale

Blocchi logicamente consecutivi a struttura non ordinata 

**Heap**
Dati conservati privi di ordinamento, inserimenti veloci, ricerche lente _(scansioni)_

**Array**
Inserimento sequenziale, blocchi di dimensione fissa, letture veloci tramite indice, poca flessibilità

#### Pseudochiavi (Campo di ordinamento)

- Il campo di ordinamento di una struttura ordinata può essere costituito da uno o più attributi della relazione

- L’ordinamento avviene sul primo attributo, quindi sui successivi a parità di valore sul primo attributo (e successivamente sui precedenti)

- Il campo di ordinamento della struttura NON è necessariamente la chiave primaria della relazione

## Struttura ad accesso calcolato (hash)

- La posizione di un record nel file dipende dal valore assunto da un campo chiave sul quale viene calcolato un indice con una funzione di **hash**
- La soluzione è applicabile solo con record a lunghezza fissa
- Ricerca puntuale efficiente, ricerca per intervallo non efficiente
- Richiede strategie di gestione delle collisioni (_catene di overflow_)

## Alberi (indici)

L’organizzazione ad albero può essere impiegata sia per realizzare strutture primarie _(strutture contenenti i dati)_ sia strutture secondarie _(strutture ausiliarie mirate a favorire l’accesso ai dati memorizzati in altre strutture)_

- Indici **densi**: una voce per ogni valore della pseudochiave
- Indici **sparsi**: solo alcuni dei valori della pseudochiave
### Indici Primari
- Sono sempre **Sparsi**
- contiene i dati della relazione _(record)_
-  garantisce accesso ai dati in base alla pseudochiave usata come campo di ordinamento dei record e ne determina la posizione

Ciascuna voce dell’indice ha la forma `< k, p >` dove `k` è il valore della pseudochiave e `p` è un puntatore a un area di memoria.
Il puntatore `p` può fare riferimento all’inizio del blocco dove il record con chiave `k` è memorizzato, oppure può tenere conto dell’offset all’interno del blocco.

![[IndicePrimario.png]]
Il numero delle voci dell’indice primario è uguale al numero di blocchi che costituiscono il file
#### Indici Secondari
- Sono sempre **indici densi**
- il campo di indicizzazione secondaria non deve essere per forza una chiave
Un ulteriore struttura di accesso a un file per il quale ci sia già un indice primario
I record contenuti nei blocchi referenziati da un indice secondario non devono per forza essere ordinati rispetto al campo di indicizzazione secondaria

![[Pasted image 20260711143330.png]]

#### Indici secondari su campi non chiave

3 modi per avere valori duplicati sul valore assunto dal campo di indicizzazione secondaria:

1. Più voci con $k$ uguale
2. Voci di lunghezza variabile (varia la quantitò di puntatori $p$)
3. Voci a lunghezza fissa con $p$ che punta ad un ulteriore livello contenente diversi puntatori ai record

![[Pasted image 20260711145452.png]]

## Alberi di ricerca

Si tratta di una struttura dati utilizzata per migliorare la ricerca grazie ad una struttura ad albero a chiave puntatore ordinata e bilanciata.

### Considerazioni

- Un file può avere un solo indice primario (che determina la posizione dei record nei blocchi di memoria secondaria)

- Un file organizzato con accesso sequenziale non ordinato può essere affiancato da un indice secondario per favorire le ricerche puntuali sulla pseudochiave (soluzione sempre prevista in ogni DBMS)

- Un file organizzato con accesso hash o sequenziale non ordinato NON può avere un indice primario

- Un file può avere numerosi indici secondari

- Le ricerche sui file di indice sono efficienti (occupano poche pagine e possono essere interamente caricati nel buffer)

- Essendo ordinati, gli indici rendono efficienti sia le ricerche puntuali sia le ricerche per intervallo

- Gli indici hanno tempi di accesso logaritmico in funzione del numero di blocchi occupati

- Quasi tutti i DBMS creano un indice per gli attributi della chiave primaria e delle chiavi (attributi con vincolo UNIQUE). Questo agevola la verifica del vincolo di univocità

---

# Progettazione Logica

## Ristrutturazione
[[progettazione.3.pdf]]

- **attributi derivati**
	Materializzare come attributo un conteggio
	_(deve sempre essere associato ad un vincolo extra schema)_
	
- **attributi multivalore**
	Se un entità può assumere più valori per uno stesso attributo viene
	generato un ulteriore entità detta **debole**
	
- **attributi composti (compositi)**
	Si può scegliere di dividere ogni singolo attributo o concatenare gli attributi in uno solo che assumerà un tipo che glielo permette
	
- **gerarchie di generalizzazione**
	- Accorpamento nell'entità padre
		Si può fare solo se la gerarchia è **Esclusiva**,
		l'entità figlio viene salvato in un attributo (multiselect) e tutti i suoi attributi associati vengono legati all'entità padre come opzionali
		_(bisogna aggiunge un vincolo esterno per gli attributi opzionali)_

	- Mantenimento delle sole entità figlie
		Si può fare solo se la gerarchia è **Totale**,
		Si elimina l'entità padre e si tengono solo se entità figlie.
		_(Se fosse parziale perderemmo le entità)_
		
	- Mantenimento di tutte le entità
		Tutte le entità figlie vengono conservate come entità separate in relazione all'entità padre

**Associazione di tipo storico**:
definisce un periodo di tempo in cui avviene la relazione.
se voglio una associazione di tipo storico devo includere **data_inizio** nella chiave.

## Gerarchie
Data una entità $E$ (_superclasse_) e una gerarchia composta da $n$ sottoclassi:

- **Totale T:**  $E$ appartiene ad almeno una delle sottoclassi
- **Parziale P:** $E$ non deve per forza appartenere ad una sottoclasse

- **Esclusiva E**: $E$ può appartenere solo ad una delle sue sottoclassi
- **Sovrapposta S:** $E$ può appartenere a più sottoclassi contemporaneamente

---
# Sicurezza
- **Segretezza**: Protezione dalle letture non autorizzate
- **Integrità**: Protezione da modifiche o cancellazioni non autorizzate
- **Disponibilità**: Garantire l'accesso ai dati agli utenti legittimi
## Tecniche
- **Autenticazione**
	meccanismi per verificare l’identità dell’utente che si connette al sistema
- **Controllo dell’accesso**
	controllo dei permessi dell'utente per gli accessi ai dati
- **Crittografica**
	i dati fisici sono cifrati

## Controllo dell'accesso
Decide quali **utenti** possono **eseguire** quali **operazioni** su quali **dati**
### Politiche di sicurezza
L'implementazione delle politiche di sicurezza costituisce un insieme di regole di autorizzazione che stabiliscono le operazioni ed i diritti che gli utenti.

Due classi fondamentali:

#### Politiche per l’amministrazione della sicurezza
Stabiliscono chi concede e revoca i diritti di accesso:

- **Centralizzata**
	un unico soggetto, detto DBA, controlla l’intera base di dati
- **Decentralizzata**
	più soggetti sono responsabili del controllo di porzioni diverse della base di dati
- _Ownership_
	l’utente che crea un oggetto (il proprietario) gestisce le autorizzazioni sull’oggetto

#### Politiche per il controllo dell'accesso
stabiliscono se e come i soggetti possono accedere a quali dati, e se e come possono venire trasmessi i diritti di accesso:

- **Need-To-Know** (minimo privilegio)
	permette ad ogni utente l’accesso solo ai dati strettamente necessari per eseguire le proprie attività
	Offre massima sicurezza ma può essere troppo restrittiva, negando accessi innocui.
	**Sistema chiuso** -> nel peggiore dei casi problema di **Disponibillità**
	
- **Maximized Sharing** (massima condivisione)
	massimo accesso alle informazioni nella base di dati, mantenendo comunque informazioni riservate.
	Soddisfa il massimo numero possibile di richieste di accesso, fiducia tra gli utenti
	**Sistema aperto** -> nel peggiore dei casi problema di **segretezza** e **integrità**

### Tipologia di controllo dell'accesso

- **Controllo dipendente dal nome**  
    L’accesso è basato sul nome dell’oggetto
    
- **Controllo dipendente dal contenuto**  
    L'accesso è determinato dal valore assunto da uno o più attributi
    
- **Controllo dipendente dal contesto**  
    L'accesso è determinato dal valore di variabili di sistema _(es., data, tempo)_
    
- **Controllo dipendente dalla storia degli accessi**  
    L'accesso è determinato dal numero di volte a cui si è fatto accesso ad una risorsa in precedenza _(n di accessi limitati ad un risorsa)_

### Politiche discrezionali

Accesso bassato su regole di concessione e revoca di accesso a risorse.

- _Vantaggio_  
    flessibili e adatte a numerosi contesti
- _Svantaggio_  
    nessun controllo sul flusso di informazioni nel sistema  
    _(Si ha un flusso tra un oggetto X e un oggetto Y quando si effettua una lettura del valore di X e una scrittura del valore in Y)_

### Politiche mandatorie (multilivello)

Per le basi di dati che richiedono elevati livelli di sicurezza

Regolano l’accesso ai dati mediante la definizione di classi di sicurezza per i soggetti e gli oggetti del sistema

- **La classe di sicurezza assegnata ad un soggetto** è una misura del grado di fiducia che si ha nel fatto che tale soggetto non commetta violazioni
- **La classe di sicurezza assegnata ad un oggetto** indica quanto sarebbe grave il rilascio delle informazioni dell'oggetto a soggetti non autorizzati

La classe di un soggetto rappresenta normalmente il suo **livello di autorizzazione**, mentre la classe di un oggetto rappresenta la **sensibilità dell’informazione**.

non basta che l'oggetto e il soggetto abbiano la stessa medesima classe di sicurezza segnata, ma è necessario anche andare a controllare nello specifico i permessi relativi a ciascun'operazione.

Possono essere classificate anche come **politiche per il controllo del flusso**, poiché evitano che le informazioni una volta accedute vengano trasferite verso oggetti con classificazione inferiore e quindi più accessibili (vedere esempio Cavallo di Troia)

## System R
- Modello che implementa una **politica di tipo discrezionale** e supporta il controllo dell'accesso in base sia la _nome_ che al _contenuto_

- Si tratta di un _sistema chiuso_

- Amministrazione dei **privilegi** è **decentralizzata** mediante **ownership**: 
  Chi crea la relazione ne possiede i privilegi e possiede la capacità di concederli ad altri.
  _Un utente può revocare solo privilegi che lui stesso ha concesso_.

### Delega dei privilegi

La delega dei privilegi avviene mediante la grant option _(WITH GRANT OPTION)_
I privilegi sono quindi divisi in:
- _delegabili_  
    concessi con grant option
- _non delegabili_:  
    concessi senza grant option

### I cataloghi SYSAUTH e SYSCOLAUTH
Le regole di autorizzazione specificate dagli utenti sono memorizzate in due cataloghi di sistema di nome **sysauth** e **syscolauth**, implementati come relazioni

![[SysAuth.png]]![[SyscolAuth.png]]

L’insieme dei privilegi delegabili che l’utente _u_ possiede è intersecato con l’insieme dei privilegi specificati nel comando di GRANT.

 Se i due insieme non dovessero coincidere, l'intersezione dei permessi viene concessa e i restanti permessi non vengono assegnati. 

### Revoca ricorsiva
è revocato il privilegio oggetto del comando di revoca e tutti i privilegi che non avrebbero potuto essere concessi se l’utente specificato nel comando di revoca non avesse ricevuto il privilegio revocato

![[EsempioRevocaRicorsiva.png]]


## Attacco cavallo di Troia

 un utente Y vuole accedere al contenuto di un file a cui non hai permesso di accedere. 

 questo utente crea una procedura general-parpose che risulta apparentemente utile e al suo interno nasconde il codice necessario a copiare il contenuto del file che vuole leggere in un file in cui lui ha il permesso di leggere. 
 _(oppure anche qualsiasi colice malevalo che vuole che un utente di maggiori permessi esegua)_

 Un utente con permessi maggiori di quelli dell'utente Y, osserva la procedura general purpose e decide di utilizzarla, eseguedo a sua insaputa anche il codice malevolo. 


![[AttaccoCavalloDiTroia.png]]