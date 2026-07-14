# Storia
- **Evoluzione dei bisogni (Ieri vs. Oggi):**
    
    - Negli **anni '60/'70**, con risorse limitate e pochi dati, la struttura rigida e i vincoli dei database relazionali erano un vantaggio per evitare inconsistenze.
        
    - **Oggi**, con dispositivi diffusi, rete pervasiva e volumi di dati illimitati, la rigidità del modello relazionale è spesso un ostacolo (es. nella raccolta dati web). Servono modelli flessibili e i vincoli tradizionali (come le chiavi esterne) risultano talvolta non necessari o impraticabili.
        
- **Il tramonto del "One size fits all" (Una sola taglia va bene per tutto):**
    
    - Per 25 anni i DBMS tradizionali (nati per dati aziendali) sono stati adattati a qualsiasi applicazione.
        
    - Secondo una celebre tesi del 2005 (Stonebraker e Cetintemel), questo approccio non è più valido: il mercato si sta frammentando in motori di database indipendenti e specializzati per esigenze diverse.
        
- **Origine dei database NoSQL:**
    
    - Il termine nasce nel 1998 con Carlo Strozzi per un DB open-source senza interfaccia SQL.
        
    - Nel 2009 Eric Evans riutilizza il termine (oggi inteso come _"Not Only SQL"_) per definire una nuova generazione di database caratterizzati dall'essere **non relazionali, distribuiti, open source, orizzontalmente scalabili** e non vincolati alle proprietà ACID classiche.

---
# Main features

**Horizontal scalability**
- **NoSQL DBs** sono progettai per scalare orizzontalmente, o meglio che il sistema può espandersi durante il suo funzionamento aggiungendo più nodi di storage al aumentare dei dati

#### **Availability, Replication**
- NoSQL DBs hanno un particolare rapporto tra numero di copie (per migliorare le prestazioni in lettura) e tempi e complessità della scrittura (aumentano all'aumentare delle copie)

#### **Eventual consistency**
- NoSQL DBs forma più "rilassata" di consistenza chiamata _eventual consistency_

	Esempio di eventual consistency
	- User A watches the weather report and learns that it's going to rain
		(the report is a reliable source of information)
	-  User A tells User B that the weather is going to rain
	-  User C tells User D that the weather is going to be sunny
	-  User B tells User C that the weather is going to rain
	-  User C tells User D that the weather is going to rain

#### **Horizontal fragmentation**
- NoSQL data file possono avere diversi milioni di record essendo che i record vengono divisi in diverse partizioni _(data sharding, distribuiti orizzontalmente)_
- Più copie di una partizione permettono un improvement nelle performance di lettura _(load balancing)_

#### **Schema is not required**
- I dati descrivono se stessi, può esserci uno schema ma rimane opzionale
- I constrain sui dati devono essere implementati nell'applicativo, non sono di competenza del "DBMS"

---
# Classification of NoSQL databases
- _Key-Value stores_ (e.g., DynamoDB, Cassandra, Berkeley DB Redis)
- _Document-based systems_ (e.g., MongoDB, CouchDB)
- _Column-family systems_ (e.g., Google BigTable, Amazon's SimpleDB)
- _Graph-oriented systems_ (e.g., Neo4j, Sones, InfinityGraph)

## Document-based systems
 Basati su concetto di collezione e documento. 
 - **Documento**
	- è un oggetto dati la cui struttura rimane flessibile.
	- Un documento descriver la sua stessa struttura.
	- I documenti organizzano i dati in una struttura gerarchica, un documento può contenere al suo interno altri sotto-elementi, che a loro volta possono contenerne altri, e così via. 
	- Questi elementi sono inter-relati, ovvero collegati tra loro logicamente all'interno dello stesso documento.
 - **Collezione**
	is a schema-free group of similar documents

---
# MongoDB
Composto da **database** che contengono diverse **collections**. 
Una collezione composta da **documenti**. 
Ogni **documento** è composto da diversi **fields**.

- collection $\rightarrow$ table    
- document $\rightarrow$ record
- field $\rightarrow$ attributo

è possibile indicizzare le collezioni per migliorare le performance di ricerca e sort.

Gli indici in Mongo funzionano come la loro controparte nei database relazionali.

### Serializzazione dei dati
Sia i dati che le operazioni, in MongoDB, vengono serializzati in formato BSON (binary JSON).

La sintassi è **Case Sensitive** 

## Identificatori
Ogni documento ha un ID che rappresenta la primary key del documento all'interno della collezione.
Se non specificato viene generato automaticamente


## References
In MongoDB ci sono due modi diversi per rappresentare le relazioni tra documenti. 

- **Normalized Way**
	 un field all'interno del documento contiene l'id del documento referenziato, un po' come succede nei database relazionali _FK_

- **Denormalized Way**
	 un field all'interno del documento contiene l'intero documento referenziato. _(data embedding, migliora le prestazioni in lettura a discapito della dimensione dei dati)_

## Aggregation pipeline
La Aggregation pipeline è un sistema per aggregare dati, basato sul concetto di pipeline di elaborazione. I documenti attraversano una sequenza di fasi, ognuna delle quali li trasforma, fino a produrre un risultato aggregato.

- L'elaborazione è divisa in passaggi
- Ogni passaggio trasforma i documenti e produce un output _( ogni documento in input non deve per forza produrre un documento in output,  il numero di documenti in input può essere diverso dal numero di documenti in output. )_
-   l'ordine di esecuzione dei passaggi corrisponde all'ordine in cui i passaggi vengono definiti. 
- l'output di ciascun passaggio viene usato come l'input del passaggio successivo.




