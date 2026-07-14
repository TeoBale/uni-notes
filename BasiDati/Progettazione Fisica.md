## DBMS e SO

Il DBMS memorizza dei dati sulla memoria secondaria in modo persistente
**Cluster**:  Area di memoria secondaria assegnata al DBMS

Ogni DBMS gestisce in modo proprietario la struttura dei file e dei cluster

I dati in memoria secondaria sono organizzati in **Blocchi** di dimensione fissa

**Buffer**: Allocazione dei dati gestiti dal DBMS sulla memoria centrale
Il buffer gestisce autonomamente la lettura/scrittura dei dati sulla memoria secondaria _(primitiva **Flush**)_, le applicazioni possono richiedere la scrittura sincrona in modo forzato se necessario _(primitiva **Force**)_.

**Buffer** diviso in **Pagine** composte da $x$ **Blocchi**.

---
## Fattore di Blocco

Fattore di blocco $bfr$: numero di record contenti in un blocco
$B$ è la dimensione del blocco, $R$ è la dimensione media del record

$$
bfr = \lfloor\frac{B}{R}\rfloor
$$

Se i record avessero tutti la stessa dimensione in byte si tratta di **record a lunghezza fissa**, altrimenti di **record a lunghezza variabile**.

---
## Strutture Primarie

La disposizione dei record dipende dalla **struttura primaria**

Le strutture primarie possono essere divise in 3 tipologia in base al metodo di accesso ai dati:
- **Sequenziale** _(ordinato o non)_
- **Calcolato** _(hash)_
- **Albero**

### Strutture ad accesso sequenziale

 blocchi logicamente consecutivi
a struttura non ordinata 

heap
sequanza indotta dall0ordine di inserimento , inserimento efficiente ricerca lineare inefficiente ma milgiorabile con altre strutture
cancellazioni logiche con periodiche ristrutturazioni

array
possibile sono con record di lunghezza fissa
file occupa n blocchi
ogni blocco assume una delle m posizioni dellarray
indice determina la posizione della tupla nel file
inserimento e ricerca efficienti ???

sequenziale ordinata clustered
odinamento fisico dei dati nel file coerente con l'ordinamento di un campo detto chiave
operazioni efficienti sia per ricerca puntuale che selezione su intervallo
richiede l0uso di indici per ricerche efficienti (i.e, dicotomiche)???

inserimenti e cancellazioni possono
essere costose
avvenire su file di overflow
richiedere periodiche ristrutturazioni

#### Pseudochiavi (Campo di ordinamento)

- Il campo di ordinamento di una struttura ordinata può essere costituito da uno o più attributi della relazione

- L’ordinamento avviene sul primo attributo, quindi sui successivi a parità di valore sul primo attributo (e successivamente sui precedenti)

- Il campo di ordinamento della struttura NON è necessariamente la chiave primaria della relazione

### Struttura ad accesso calcolato (hash)

- La posizione di un record nel file dipende dal valore assunto da un campo chiave

- Si utilizza una **funzione hash** $h$ per trasformare il valore del campo chiave $k$ in un indice di posizione nel file (e.g., $h(k) = k \text{ mod } N$, dove $N$ è la numerosità delle posizioni a disposizione)

- La soluzione è applicabile solo con record a lunghezza fissa

- Ricerca puntuale efficiente, ricerca per intervallo non efficiente

- Richiede strategie di gestione delle collisioni (_catene di overflow_)

### Alberi (indici)

- L’organizzazione ad albero può essere impiegata sia per realizzare strutture primarie _(strutture contenenti i dati)_ sia strutture secondarie _(strutture ausiliarie mirate a favorire l’accesso ai dati memorizzati in altre strutture)_

In genere, gli indici possono essere **densi**, ovvero contenere una voce per ogni valore della pseudochiave, oppure **sparsi**, ovvero contenere voci solo per alcuni dei valori della pseudochiave

Quindi distinguiamo:
#### Indici Primari
Un indice primario:
- contiene i dati della relazione _(record)_
-  garantisce accesso ai dati in base alla pseudochiave usata come campo di ordinamento dei record e ne determina la posizione
Ciascuna voce dell’indice ha la forma `< k, p >` dove `k` è il valore dellapseudochiave e `p` è un puntatore a un’area di memoria.
Il puntatore `p` può fare riferimento all’inizio del blocco dove il record con chiave `k` è memorizzato, oppure può tenere conto dell’offset all’interno del blocco.

![[IndicePrimario.png]]

Il numero delle voci dell’indice primario è uguale al numero di blocchi che costituiscono il file

Indici Primari sono sempre **Sparsi**

#### Indici Secondari
Un ulteriore struttura di accesso a un file per il quale ci sia già un indice primario

I record contenuti nei blocchi referenziati da un indice secondario non devono per forza essere ordinati rispetto al campo di indicizzazione secondaria

il campo di indicizzazione secondaria non deve essere per forza una chiave

Gli indici secondari sono sempre **indici densi**.

![[Pasted image 20260711143330.png]]


#### Indici secondari su campi non chiave

3 modi per avere valori duplicati sul valore assunto dall'campo di indicizzazione secondaria:

1. Più voci con $k$ uguale
2. Voci di lunghezza variabile (varia la quantitò di puntatori $p$)
3. Voci a lunghezza fissa con $p$ che punta ad un ulteriore livello contenente diversi puntatori ai record

![[Pasted image 20260711145452.png]]

### Alberi di ricerca

Un albero di ricerca di ordine _q_ è un albero tale per cui ogni nodo contiene al massimo _q − 1_ valori di ricerca e i _q_ puntatori sono definiti come segue:
![[Pasted image 20260711145714.png]]

La caratteristica più importante nella gestione di un albero di ricerca è **mantenerne il** **bilanciamento** in modo che:
- i nodi siano distribuiti uniformemente e la profondità dell’albero sia minimizzata
- rendere uniforme la velocità di ricerca in modo che il tempo medio per trovare una qualsiasi chiave sia lo stesso

### Considerazioni

- Un file può avere un solo indice primario (che determina la posizione dei record nei blocchi di memoria secondaria)

- Un file organizzato con accesso sequenziale non ordinato può essere affiancato da un indice secondario per favorire le ricerche puntuali sulla pseudochiave (soluzione sempre prevista in ogni DBMS)

- Un file organizzato con accesso hash o sequenziale ordinato NON può avere un indice primario

- Un file può avere numerosi indici secondariConsiderazioni

- Gli indici sono file di piccole dimensioni

- Le ricerche sui file di indice sono efficienti (occupano poche pagine e possono essere interamente caricati nel buffer)

- Essendo ordinati, gli indici rendono efficienti sia le ricerche puntuali sia le ricerche per intervallo

- Gli indici hanno tempi di accesso logaritmico in funzione del numero di blocchi occupatiConsiderazioni

- Quasi tutti i DBMS creano un indice per gli attributi della chiave primaria e delle chiavi (attributi con vincolo UNIQUE). Questo agevola la verifica del vincolo di univocità

- Alcuni sistemi adottano la dicitura _indice primario_ per denotare un indice definito sugli attributi della chiave primaria di una relazione. Questa terminologia differisce da quella dottata in queste slide dove un indice primario indica il campo usato per ordinare il contenuto del file