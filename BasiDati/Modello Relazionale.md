
Il modello relazionale è basato sulla nozione di relazione matematica

>**Relazione**:
>sottoinsieme del **prodotto cartesiano** fra due o più insiemi di dati detti **domini**

 il modello relazionale definisce anche un insieme di vincoli sui dati. 
  per l'interrogazione di una base di dati relazionale, vi è associato un linguaggio denominato algebra relazionale.

- **Tabella** -> Rappresentazione di una relazione
- **Base dati** -> Collezione di tabelle
- **Ennupla, Record, Istanza** -> Rappresenta una corrispondenza tra valori
- **Attributo** -> Nome distinto associato ad una colonna
	Ad ogni attributo corrisponde un insieme di possibili valori detto Dominio
	- **Dominio**: collezione di valori atomici

Gli attributi necessitano di Nomi associati per non dipendere dal loro ordinamento
I record sono sempre diversi tra loro _(orientamento ai valori, indipendente dal posizionamento)_

#BasiDatiTeoria

---

Il dominio di una relazione tra due attributi $A$ e $B$ è sempre il prodotto cartesiano dei domini degli attributi $D_A \text{ x } D_B$.

- **Grado di una relazione**: # di attributi che la compongono
- **Cardinalità di una relazione**: # di record che la costituiscono

Una relazione $R$ può essere definita posizionalmente con i domini $D_x$ degli attributi
$$
R(D_1, D_2)
$$
Oppure esse definita assegnando dei nomi algi attributi
$$
R(A_1, A_2)
$$
Un record $r$ di $R$ viene definito come:
$$ (d_ 1, d_2, ..., d_n) $$

$$
\forall d_i \text{ si ha che } d_i \in D_i \text{ con } i \in [1, n]
$$

$r[A_k]$ denota il valore del record $t$ sull'attributo $A_k$ 

Lo **schema** di una base di dati $BD$ è l'insieme delle relazioni che la compongono:
$$
BD = \{ R_1, R_2, ..., R_m \}
$$
con $R$ in $BD$ definita come:
$$
R(A_1, A_2, ..., A_n )
$$

## Vincoli del modello relazionale

1. **valori mancanti (null values)**
	- è possibile definire un vincolo che impedisce la memorizzazione di valori nulli sugli attributi indicati (NOT NULL) 
	Semantica:
	- Valore ignoto ma esiste
	- Valore non esistente
	- Indistinguibilità tra i due
Vincoli di integrità di una relazione $R$ sono i vincoli che devono essere soddisfatti da un record $r$ per appartenere alla relazione $R$.
2. **vincoli di dominio**
3. **vincoli di ennupla** 
4. **vincoli di superchiave (vincolo di univocità)**
	Data la relazione $R(A)$ dove $A$ è l'insieme degli attributi su cui è definita $R$ $X, X ⊆ A$ è superchiave SK di $R$ se ogni coppia di record distinti $t_1, t_2$ è i valori degli attributi di $X$ sono diversi:
		$$
		t_1[X]≠t_2[X] \quad \forall t_1, t_2 
		$$

	una **chiave** K è una **superchiave minimale**: una superchiave SK è chiave K quando non posso eliminare alcun attributo da SK senza perdere la proprietà di identificazione univoca 

	$X, X ⊆ A$ è chiave di $R(A)$ se $∄ Y \subset X \text{ tale che } t_1[Y]≠t_2[Y] \quad \forall t_1, t_2$
	
	in SQL il vincolo di chiave si esprime con la keyword `UNIQUE`


5. **Vincolo di entity integrity**
	Non è possibile avere valori nulli sull'identificatore di una relazione.
	
	La **chiave primaria** PK di una relazione è una chiave che supporta il vincolo di entity integrity 
	
	In SQL `PRIMARY KEY`, assume i vincoli `NOT NULL` e `UNIQUE `
	
6. **Vincoli integrità referenziale**

	Una chiave esterna di una relazione $R_2(C,D)$ con $C$ PK e $D$ FK verso $A$ della relazione $R_1(A, B)$ con $A$ chiave _(superchiave minimale)_
	$$
	R2(D) \rightarrow R1(A)
	$$
	- I valori assunti dalla FK devono essere presenti fra i valori che costituiscono l'attributo referenziato
	- La FK deve avere lo stesso dominio dell'attributo referenziato
	- l'attributo referenziato da una FK deve essere una chiave nella relazione referenziata 

	In SQL: 
	```sql
	FOREIGN KEY (D) REFERENCES R1(A)
	-- Oppure
	D REFERENCES R1(A) 
	```

Gli eventi di modifica (UPDATE) della chiave R1.A o cancellazione (DELETE) sui dati di $R_1$ richiede la verifica dell'integrità referenziale sulle chiavi esterne che referenziano $R_1$.

# Note sull'algebra relazionale

E' possibile che ci siano record di una relazione partecipante al join che non figurano nel risultato del join (batman nel caso dell'esempio). I record di questo tipo sono detti dangling. 