# Esame di Basi di Dati - 10 giugno 2025

90 minuti - Tema C

> Il margine sinistro e la parte inferiore della prima pagina non sono inclusi nella fotografia. La trascrizione segnala i campi e i valori tagliati, senza completarli arbitrariamente.

## Istruzioni leggibili

- Si usi il tema d'esame per appunti e il foglio protocollo per le risposte definitive (riportare il nominativo e la matricola anche sul foglio protocollo).
- Riportare sul foglio protocollo il riferimento all'esercizio che si sta svolgendo.
- Non usare matite e colori diversi da blu/nero.
- Consegnare sia il tema d'esame sia il foglio protocollo.
- Il compito è **insufficiente** se non si totalizzano gli 8 punti del primo esercizio. In questo caso il docente può non procedere con la correzione dei restanti esercizi.

Tutti gli esercizi fanno riferimento al seguente schema relazionale denominato `eCommerce`.

## Schema relazionale `eCommerce`

```sql
CREATE TABLE client (
    cid integer PRIMARY KEY,
    name varchar NOT NULL,
    email varchar UNIQUE NOT NULL,
    nome_attributo_non_leggibile date
);

CREATE TABLE order (
    oid integer PRIMARY KEY,
    cid integer NOT NULL
        REFERENCES client(cid)
        ON UPDATE CASCADE,
    o_date date NOT NULL,
    status varchar,
    CHECK (status IN (
        '[primo valore non leggibile]',
        'travelling',
        'delivered',
        'canceled'
    ))
);

CREATE TABLE product (
    pid integer PRIMARY KEY,
    name varchar NOT NULL,
    price numeric(6,2) NOT NULL,
    category varchar
);

CREATE TABLE order_detail (
    oid integer,
    pid integer,
    quantity integer,
    PRIMARY KEY (oid, pid),
    FOREIGN KEY (oid)
        REFERENCES order(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (pid)
        REFERENCES product(id)
        ON UPDATE CASCADE
);
```

### Istanze delle relazioni

La fotografia taglia le prime colonne delle tabelle `order` e `product`. Sono riportati i dati leggibili.

**`order` (R), colonne visibili**

| o_date (parzialmente visibile) | status |
|---|---|
| ...-05-20 | travelling |
| ...-06-01 | delivered |
| ...-05-22 | canceled |
| ...-06-04 | travelling |

**`product`, colonna visibile**

| category |
|---|
| informatics |
| equipment |
| devices |

**`order_detail` (S)**

| oid | pid | qty |
|---:|---:|---:|
| 101 | 1 | 4 |
| 101 | 2 | 3 |
| 101 | 3 | 6 |
| 102 | 3 | 4 |
| 102 | 1 | 1 |
| 103 | 2 | 9 |
| 103 | 3 | 1 |
| 104 | 1 | 2 |
| 104 | 2 | 6 |
| 104 | 3 | 2 |

## Esercizio 1 (8 punti)

A. Quale proprietà differenzia la nozione di superchiave e chiave?

B. Quale comando SQL permette di terminare con successo la transazione corrente?

C. Quelle basate su hashing sono strutture primarie o secondarie?

D. Quale politica di controllo dell'accesso permette ad ogni utente l'accesso solo ai dati strettamente necessari per eseguire le proprie attività?

E. Con riferimento alle istanze della pagina precedente, mostrare la relazione risultante dalla seguente query SQL:

```sql
SELECT r.*, s.oid
FROM order_detail s RIGHT JOIN order r
    ON r.oid = s.oid AND quantity > 5
WHERE s.pid IS NULL;
```

F. Scrivere l'espressione di algebra relazionale che restituisce il codice degli ordini che contengono laptop.

## Esercizio 2 (fino a 15 punti)

Si svolgano le seguenti interrogazioni considerando lo schema relazionale `eCommerce`.

1. **[SQL]** Restituire i clienti che non hanno ordini in spedizione (`status = 'shipped'`).
2. **[SQL]** Restituire la spesa complessiva di ogni cliente. Restituire i clienti con spesa zero (clienti senza ordini). Restituire il nome del cliente nel risultato e ordinare per spesa decrescente.
3. **[SQL]** Restituire la categoria con il maggior numero di prodotti.
4. **[SQL]** Restituire i clienti che hanno comprato la stessa quantità di uno specifico prodotto in due ordini diversi.
5. **[ALG]** Restituire il nome del cliente con l'ordine in consegna (`status = 'travelling'`) più recente (`order.o_date` più alto).

## Esercizio 3 (fino a 5 punti)

Si definisca lo schema relazionale per il seguente schema concettuale. Si minimizzino gli schemi di relazione dove possibile. Si usi la sottolineatura continua per le chiavi primarie, la sottolineatura tratteggiata per le chiavi esterne, l'asterisco per gli attributi potenzialmente nulli.

![Schema concettuale dell'esercizio 3](photo_5967586831790883824_y.jpg)

> Nel diagramma sono visibili le entità `E1`, `E2`, `E3`, `E4` e le relazioni `R1`, `R2`, `R3`, `R4`. Le cardinalità e alcuni nomi degli attributi non sono distinguibili con sufficiente certezza nella fotografia; per questo viene conservata qui anche l'immagine sorgente.

## Esercizio 4 (fino a 3 punti)

Si consideri la relazione:

$$
R(A, B, C, D, E, F, G, H)
$$

dove valgono le seguenti dipendenze funzionali:

- $d_1: A \rightarrow B, C, D$
- $d_2: C \rightarrow D$
- $d_3: F \rightarrow G, H$
- $d_4: A, F \rightarrow E$

Si fornisca una decomposizione sulla base delle dipendenze date, specificando le chiavi di ciascuna relazione e la forma normale raggiunta con la decomposizione.
