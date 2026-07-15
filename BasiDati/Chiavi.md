- **Superchiave**: 
  Insieme di attributi che permette di identifica univocamente un record _(Non esistono due record con la medesima superchiave)_. Alcuni attributi che compongono la superchiave possono essere Null.
	
- **Superchiave Minimale (Chiave)**: 
  Uno dei più piccoli insiemi di attributi che permette di identificare univocamente un record _(Non esistono due record con la medesima superchiave)_.
  L'insieme degli attributi soddisfano il vincolo UNIQUE
  Gli attributi possono essere null
	- **Attributo Primo**:
	  Appartiene ad una **Superchiave minimale**

- **Primary Key**:
  Una Chiave che viene scelta per identificare un record in modo univoco
  `NOT NULL`, `UNIQUE`

	Tutte le altre **chiavi** che non sono PK vengono chiamate:
	**Chiavi Candidate**
	_(Sostanzialmente tutte gli attributi UNIQUE)_

