
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