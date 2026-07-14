Si pone gli obbiettivi:
- **Segretezza**: Protezione dalle letture non autorizzate
- **Integrità**: Protezione da modifiche o cancellazioni non autorizzate
- **Disponibilità**: Garantire l'accesso ai dati agli utenti legittimi

# Tecniche

- **Autenticazione**
	meccanismi per verificare l’identità dell’utente che si connette al sistema
- **Controllo dell’accesso**
	controllo dei permessi dell'utente per gli accessi ai dati
- **Crittografica**
	i dati fisici sono cifrati

## Controllo dell'accesso

Previene azioni accidentali o deliberate che potrebbero compromettere l’integrità e la segretezza dei dati

Decide quali **utenti** possono **eseguire** quali **operazioni** su quali **dati**

### Politiche di sicurezza
Norme e principi che esprimono le scelte di fondo dell’organizzazione relativamente alla sicurezza dei propri dati.

L'implementazione delle politiche di sicurezza costituisce un insieme di regole di autorizzazione che stabiliscono le operazioni ed i diritti che gli utenti.

**Reference Monitor**: meccanismo utilizzato per decretare l'autorizzazione di un utente _(totale o parziale)_ all'esecuzione di un operazione.

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
	
- **Maximized Sharing** (massima condivisione)
	massimo accesso alle informazioni nella base di dati, mantenendo comunque informazioni riservate.
	Soddisfa il massimo numero possibile di richieste di accesso, fiducia tra gli utenti

---
## Tipologie di sistema

- **Sistema aperto**
	L' accesso è consentito a meno che non sia esplicitamente negato
	_(Accesso a tutto tranne denylist)_ _MaximizedSharing_
- **Sistema chiuso**
	L’acceso è permesso solo se esplicitamente autorizzato
	_(Accesso negato a tutto tranne allowlist)_ _NeedToKnow_
	
Un possibile errore in un sistema **chiuso** genererebbe solo un problema di **disponibilità**, mentre un errore in un sistema **aperto** potrebbe causare problemi di **segretezza** e di **integrità**.

---
## Granularità dei permessi

La granularità dei permessi indica a quale tipologia di oggetti _(attributo, relazione, database, Funzione/procedura, ...)_ un determinato permesso deve essere applicato

---
## Tipologia di controllo dell'accesso

- **Controllo dipendente dal nome**
	L’accesso è basato sul nome dell’oggetto
- **Controllo dipendente dal contenuto**
	L'accesso è determinato dal valore assunto da uno o più attributi
- **Controllo dipendente dal contesto**
	L'accesso è determinato dal valore di variabili di sistema _(es., data, tempo)_
- **Controllo dipendente dalla storia degli accessi**
	L'accesso è determinato dal numero di volte a cui si è fatto accesso ad una risorsa in precedenza _(n di accessi limitati ad un risorsa)_

---
### Politiche discrezionali

Richiedono la definizione di **regole di autorizzazione** per determinare l'accesso e i permessi di uno o più soggetti ad un sistema
Il meccanismo di controllo concede l'accesso solo in presenza di una regola che lo autorizza
- _Vantaggio_
	flessibili e adatte a numerosi contesti
- _Svantaggio_
	nessun controllo sul flusso di informazioni nel sistema
	_(Si ha un flusso tra un oggetto X e un oggetto Y quando si effettua una lettura del valore di X e una scrittura del valore in Y)_
### Politiche mandatorie (multilivello)

Per le basi di dati che richiedono elevati livelli di sicurezza

Regolano l’accesso ai dati mediante la definizione di classi di sicurezza per i soggetti e gli oggetti del sistema

- **La classe di sicurezza assegnata ad un soggetto** è una misura del grado di fiducia che si ha nel fatto che tale soggetto non commetta violazioni
- **La classe di sicurezza assegnata ad un oggetto** indica quanto sarebbe grave il rilascio delle informazioni dell'oggetto a soggetti non autorizzati

La classe di un soggetto rappresenta normalmente il suo **livello di autorizzazione**, mentre la classe di un oggetto rappresenta la **sensibilità dell’informazione**.

 non basta che l'oggetto e il soggetto abbiano la stessa medesima classe di sicurezza segnata, ma è necessario anche andare a controllare nello specifico i permessi relativi a ciascun'operazione. 

Possono essere classificate anche come politiche per il controllo del flusso, poiché evitano che le informazioni una volta accedute vengano trasferite verso oggetti con classificazione inferiore e quindi più accessibili (vedere esempio Cavallo di Troia)

---
## System R

Modello che implementa una **politica di tipo discrezionale** e supporta il controllo dell'accesso in base sia la _nome_ che al _contenuto_

Si tratta di un _sistema chiuso_

Amministrazione dei privilegi è decentralizzata mediante ownership:
	Chi crea la relazione ne possiede i privilegi e possiede la capacità di concederli ad altri.

```sql
GRANT Lista Privilegi | ALL [PRIVILEGES] ON Lista

Relazioni | Lista Viste TO Lista Utenti | PUBLIC [WITH

GRANT OPTION]
```

```sql
REVOKE Lista Privilegi | ALL [PRIVILEGES] ON Lista

Relazioni | Lista Viste FROM Lista Utenti | PUBLIC
```

_Un utente può revocare solo privilegi che lui stesso ha concesso_.

### Delega dei privilegi
La delega dei privilegi avviene mediante la grant option _(WITH GRANT OPTION)_
I privilegi sono quindi divisi in:
- _delegabili_
	privilegi concessi con grant option
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


# Attacco cavallo di Troia

 un utente Y vuole accedere al contenuto di un file a cui non hai permesso di accedere. 

 questo utente crea una procedura general-parpose che risulta apparentemente utile e al suo interno nasconde il codice necessario a copiare il contenuto del file che vuole leggere in un file in cui lui ha il permesso di leggere. 
 _(oppure anche qualsiasi colice malevalo che vuole che un utente di maggiori permessi esegua)_

 Un utente con permessi maggiori di quelli dell'utente Y, osserva la procedura general purpose e decide di utilizzarla, eseguedo a sua insaputa anche il codice malevolo. 


![[AttaccoCavalloDiTroia.png]]