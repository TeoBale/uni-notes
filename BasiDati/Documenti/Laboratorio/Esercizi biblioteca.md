
Testo dell'Esercizio

Si vuole modellare il sistema informativo di una rete di biblioteche comunali. I requisiti sono i seguenti:
- La rete è composta da più biblioteche, ciascuna identificata da un codice e caratterizzata da nome, indirizzo e numero di telefono.

- Ogni biblioteca possiede un certo numero di copie di libri. Un libro può essere posseduto da più biblioteche in più copie.

- I libri sono identificati dal codice ISBN e descritti da titolo, anno di pubblicazione e genere. Ogni libro è scritto da uno o più autori.

- Gli autori hanno un codice identificativo, nome, cognome e nazionalità.

- Gli utenti della biblioteca sono identificati da un codice tessera e hanno nome, cognome, email e data di nascita. Un utente è iscritto a esattamente una biblioteca.

- Gli utenti possono prendere in prestito le copie disponibili. Di ogni prestito si registra la data di inizio, la data di restituzione prevista e la data di restituzione effettiva (NULL se il libro non è ancora stato restituito). Uno stesso utente può prendere in prestito lo stesso libro in momenti diversi.


**Parte 1 — Schema Entità-Relazione**
Disegnare lo schema ER che rappresenta i requisiti sopra descritti. Per ogni entità e relazione specificare attributi, chiave primaria e cardinalità.

**Parte 2 — Schema Relazionale**
Tradurre lo schema ER in schema relazionale (notazione testuale). Indicare chiavi primarie (PK) e chiavi esterne (FK).

**Parte 3 — Implementazione SQL (PostgreSQL)**
Scrivere le istruzioni CREATE TABLE per tutte le relazioni, rispettando i vincoli di integrità referenziale.

**Parte 4 — Query SQL**

Scrivere le query SQL per rispondere alle seguenti richieste.

  

**Query 1 — Libri disponibili in una biblioteca**
Elencare titolo e ISBN di tutti i libri che hanno almeno una copia disponibile nella biblioteca con codice 'BIB001'.


**Query 2 — Prestiti ancora aperti**
Elencare nome, cognome dell'utente, titolo del libro e data di inizio prestito per tutti i prestiti non ancora restituiti, ordinati per data crescente.


**Query 3 — Utenti in ritardo**
Elencare nome e cognome degli utenti che hanno almeno un prestito aperto la cui data prevista di restituzione è già passata.

  
**Query 4 — Numero di prestiti per libro**
Per ogni libro, mostrare ISBN, titolo e numero totale di prestiti. Includere anche i libri mai prestati. Ordinare per numero di prestiti decrescente.


**Query 5 — Autori con più di un libro in catalogo**
Elencare nome e cognome degli autori che hanno scritto (o co-scritto) più di un libro, insieme al conteggio.

  
**Query 6 — Biblioteca con più prestiti attivi**
Trovare il nome della biblioteca che ha attualmente il maggior numero di prestiti aperti.


**Query 7 — Utenti che non hanno mai preso in prestito nulla**
Elencare nome e cognome degli utenti registrati che non hanno mai effettuato un prestito.

  
### **Parte 5 — Funzioni PL/pgSQL**

**Funzione 1 — Numero di prestiti attivi di un utente**
Restituisce il numero di prestiti ancora aperti per un dato utente. Utile per verificare se un utente ha raggiunto il limite di prestiti consentiti.


**Funzione 2 — Libri in ritardo di un utente**
Restituisce una tabella con i libri che un utente non ha ancora restituito oltre la data prevista.

### Parte 6 — Trigger PL/pgSQL

**Trigger 1 — Aggiornamento automatico dello stato della copia**
All'inserimento di un nuovo prestito lo stato della copia passa a 'in prestito'. Alla chiusura del prestito torna a 'disponibile'.

**Trigger 2 — Controllo limite massimo di prestiti per utente**
Impedisce l'inserimento di un nuovo prestito se l'utente ha già 3 prestiti aperti, sollevando un'eccezione esplicita.

### Parte 7 — Vista Materializzata  

**Vista — Riepilogo statistiche per libro**
Precalcola, per ogni libro, le statistiche aggregate sui prestiti: utile per cruscotti e report senza ricalcolare su tabelle grandi.

Trigger per il refresh automatico

In PostgreSQL le viste materializzate non si aggiornano da sole. Questa funzione le aggancia alla tabella Prestito.