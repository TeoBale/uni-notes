Vincoli di formato e coerenza dei dati -> Necessari per dati strutturati

I dati possono essere:
- **(Apparentemente) Strutturati**:
	Nn è detto che siano rispettati i vincoli di formato e coerenza
	Solitamente memorizzati in forma tabellare (DBMS Relazionali)
- **Semi Strutturati**:
	DBMS NoSQL
- **Non Strutturati**:
	Semplicemente nessuna struttura

Una base si può dire _strutturata_ se i dati contenuti seguono uno schema (Struttura: formato e vincolo dei dati, che definiscono una rappresentazione degli oggetti reali)
Una possibile rappresentazione di questi oggetti, se rispetta i vincoli di dei dati e di formato si dice valida rispetto lo schema.

## Quali sono le sfide nella gestione dei dati ??

1. Duplicazioni
2. Violazione di integrità
3. Errori di inserimento
4. Mancanza di controlli sui tipi
5. Difficoltà di collegamento fra file
6. Controllo dell'accesso

Per gestire queste sfidi abbiamo bisogno di un sistema di gestione della base di dati 
_DBMS Database Management System_

---

## Modelli dei dati

- Modello Relazionale
- Modello Gerarchico: Basato su strutture ad albero
- Modello ad Oggetti
- Modello XML
- Modello Reticolare
- Modello NoSQL
- ...

---

## Architettura a 3 livelli

Architettura standardizzata nei dbms è strutturata su 3 livelli:
1. **Esterno**:
	Rappresentazione di una porzione della base di dati tramite l'utilizzo del livello logico
	_(Viste)_
2. **Logico**: 
	Descrizione della basi di dati per mezzo del modello logico adottato
	descrizione di come sono strutturati i dati dal punto di vista logico
3. **Interno**:
	Rappresentazione del livello _Logico_ tramite strutture fisiche di memorizzazione

---
## Caratteristiche DMBS

- DDL: Data Definition Language
	È la parte del linguaggio usata per **definire la struttura** della base di dati.
	`CREATE ALTER DROP`
	Serve per **creare, modificare o eliminare**:
	- database
	- schemi
	- tabelle
	- attributi
	- domini
	- vincoli
- DML: Data Manipulation Language
	Serve a manipolare i dati contenuti nel database.
	`INSERT UPDATE DELETE`

- DQL:  Data Query Language
	Serve a **interrogare** la base di dati.
	`SELECT`

- DCL: Data Control Language
	Serve a controllare chi può fare cosa sul database.
	`GRANT REVOKE`

DDL → modifica la struttura 
DML → modifica i dati
DQL → legge/interroga i dati
DCL → modifica i permessi

- **Autodescrizione**: Il DBMS conserva dati e descrizione dei dati
	Linguaggi DDL e DML

- **Indipendenza**:  
	 Si cerca di separare come i dati vengono visualizzati dagli utenti da come sono fisicamente memorizzati.
	- **Logica**: indipendenza tra livello **logico** e livello **esterno**, è possibile modificare le viste esterne senza intaccare il livello logico e a sua volta modificare il livello logico senza intaccare le viste esterne
	- **Fisica**: posso modificare il modo in cui i dati vengono fisicamente memorizzati senza modificare le applicazioni che li utilizzano.
- **Viste multiple**:
	Utenti diversi possono vedere rappresentazioni differenti della stessa base di dati 
	_(Senza dati duplicati)_
	Utilizzo contemporaneo della bd -> **Multiutenza**
		Linguaggio DQL

- **Controllo della concorrenza**:
	insieme dei meccanismi con cui il DBMS coordina operazioni eseguite contemporaneamente
	Il controllo della concorrenza impedisce che l'accesso contemporaneo di più utenti produca **inconsistenze** o **perdita di dati.**

- **Controllo dell'accesso**:
	Chi può fare quale operazione su quali dati
	Il controllo dell'accesso si basa su:
	- utenti
	- ruoli
	- privilegi
	- autorizzazioni
	gestito, a livello SQL, soprattutto tramite il **DCL**

---
## Caratteristiche delle basi di dati

Idealmente ogni insieme di dati può essere una base di dati...
Quali caratteristiche deve avere un insieme di dati per essere chiamato base di dati ?

- Rappresenta un **aspetto limitato della realtà**
- Costituisce un insieme di dati che hanno un **significato intrinseco**
- Progettata e costruita per uno **scopo preciso** a servizio di utenti e applicazioni
  _(Da qui discendono vincoli e regole)_

---
## Definizioni di DBMS

Un sistema di gestione di basi di dati è un sistema software in grado di gestire collezioni di dati che siano grandi, condivise e persistenti, assicurando la laoro affidabilità e privatezza. Come ogni prodotto informatico un DBMS deve essere efficiente e efficace.
Una base di dati è una collezione di dati gestita da un DBMS.

Un sistema di gestione di base di dati è un insieme di programmi che permettono agli utenti di
creare e mantenere una base di dati. Il DBMS è un sistema software a scopi generici che facilita
il processo di definire, costruire, manipolare e condividere base di dati per varie applicazioni. 

DBMS -> Software
Cosa fa? -> Aiuta a definire, costruire, modificare, gestire una base di dati
Base di dati  -> Collezione di dati gestita da un DBMS

---
## Utenza di un DBMS

- **DBA**: 
	Database Admin
- **DB User**:
	Sono untenti con privilegi specifici e limitati rispetto ad una o più basi dati gestite dal dbms
- **Developer**:
	Interazione con DML
- **Occasional User**:
	Utenza che compie attività non standardù
#### Differenza principale
- Il **DBA** amministra il sistema.
- Il **developer** costruisce applicazioni che utilizzano il database.
- L’**occasional user non esperto** usa funzioni già predisposte.
- Il **casual user** consulta i dati in maniera più autonoma e variabile.

---
## Accesso ad un DBMS

I DBA e i DB User accedono alla base di dati tramite protocollo TCP/IP con un client che si interfaccia con il server del DBMS o localmente tramite un client con protocollo unix socket

---

#BasiDatiTeoria