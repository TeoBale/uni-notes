
Una transazione è un insieme di operazioni atomiche.
_(Permette di rendere atomico un insieme di operazioni)_

Per garantire **Integrità** e **Isolamento** le transazioni permettono di:
- Assicurarsi che tutte le operazioni che contengono vadano a buon fine, in modo tale che se anche una sola fosse fallita i dati non sarebbero stati lasciati in una condizione intermedia
- Isolare le operazioni atomiche della transazione dalle altre transazioni che non possono accedervi _(ne il loro stato, ne il loro esito)_

Sostanzialmente o tutte hanno successo, e le modifiche vengono applicate, oppure, anche se solo una fallisce,  tutte le modifiche vengono scartate.

Una transazione trasforma lo stato corretto di un db in un altro stato corretto, ma nel mentre, il db, può assumere uno stato non corretto.

- **Commit** nel caso di stato corretto
- **Rollback** nel caso di stato non corretto

## Concorrenza nell’accesso ai dati
Quando più utenti o applicazioni lavorano in modo concorrente sui dati i tempi di lettura e scrittura possono provocare anomalie:

- **Lost update**
	due utenti U1, U2 leggono il medesimo dato X ed eseguono un’operazione di aggiornamento. Poiché U2 legge il dato X prima che U1 scriva, l’aggiornamento effettuato da U1 viene perso

- **Dirty read**
	l’utente U1 aggiorna un dato X e successivamente fallisce. Il dato X (temporaneamente) aggiornato da U1 viene letto dall’utente U2 prima che X venga riportato al suo valore originale precedente la modifica effettuata da U1

- **Incorrect summary**
	se un utente calcola una funzione aggregata su un insieme di record mentre un altro utente effettua un aggiornamento sui record, il primo client può calcolare la funzione aggregata considerando alcuni valori prima dell’aggiornamento e alcuni valori dopo l’aggiornamento

## Proprietà delle transazioni

Il DBMS esegue transazioni concorrenti in modo tale da garantire le

seguenti proprietà _(ACID)_:
- **A**tomicity
- **C**onsistency
- **I**solation
- **D**urability

 In SQL esistono tre concetti chiave per la gestione delle transazioni:
 
1. **AUTOCOMMIT**
	ogni singola istruzione SQL è automaticamente una transazione completa, senza bisogno di  BEGIN / COMMIT  espliciti.
2. **COMMIT/ROLLBACK**
	concludono la transazione corrente, permettendo l'avvio di una nuova.
3. **ROLLBACK** 
	può scattare automaticamente (in caso di errore) oppure essere chiamato manualmente dall'utente per gestire condizioni logiche non soddisfatte.

### Atomicity
L'esecuzione di una transazione deve essere per definizione **totale** o **nulla**.
- COMMIT: se bene
- ROLLBACK: se male, o mi voglio male
###  Consistency
Ogni transazione può assumere di lavorare su un DB dove tutti i vincoli di integrità sono verificati
Dopo ogni transazione il db deve continuare a rispettare tutti i vincoli di integrità
- **IMMEDIATE**
	Controllo di integrità dopo ogni operazione
	La violazione di un vincolo di integrità da parte di un istruzione non compromette l'esecuzione della transazione, ma l'istruzione viene cancellata _(UNDO)_
- **DEFERRED**
	Controllo di integrità dopo al termine della transazione
### Isolation
Ogni transazione deve essere eseguita in modo isolato e indipendente dalle altre
Ogni transazione in esecuzione blocca le risorse a cui deve accedere, in questo modo permette l'esecuzione simultanea di diverse transazioni che non interferiscono tra loro.

Alcuni dei meccanismi utilizzati a questo scopo:
- lock
- controllo multiversione, MVCC
- timestamp
- livelli di isolamento
- rilevamento dei deadlock
### Durability
Anche detta **persistency**, stabilisce gli effetti delle operazioni di una transazione giunta al COMMIT non debbano essere persi.

 dopo ogni salvataggio vengono salvate tutte le transazioni che vengono eseguite, in questo modo se ci fosse un malfunzionamento prima del prossimo salvataggio sarebbe possibile risalire allo stato corrente
 _(log delle transazioni eseguite)_
 