# Esame di Basi di Dati - 22 luglio 2025

Prof. Montanelli - 90 minuti - Tema A

## Istruzioni

- Si usi il tema d'esame per appunti e il foglio protocollo per le risposte definitive (riportare il nominativo e la matricola anche sul foglio protocollo).
- Riportare sul foglio protocollo il riferimento all'esercizio che si sta svolgendo.
- Non usare matite e colori diversi da blu/nero.
- Consegnare sia il tema d'esame sia il foglio protocollo.
- Il compito è **insufficiente** se non si totalizzano gli 8 punti del primo esercizio. In questo caso il docente può non procedere con la correzione dei restanti esercizi.

Tutti gli esercizi fanno riferimento al seguente schema relazionale denominato `festival`.

## Schema relazionale `festival`

```sql
CREATE TABLE film (
    fid INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    director VARCHAR(255),
    country VARCHAR(100),
    duration_min INT
        CHECK (duration_min > 0),
    release_year INT
);

CREATE TABLE artist (
    aid INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(100)
        CHECK (role IN ('Actor', 'Director', 'Editor', 'Composer', 'Writer')),
    nationality VARCHAR(100),
    birth_year INT
);

CREATE TABLE screening (
    sid INT PRIMARY KEY,
    fid INT REFERENCES film(fid)
        ON DELETE CASCADE,
    venue VARCHAR(255),
    date DATE,
    is_premiere BOOLEAN
);

CREATE TABLE award (
    fid INT REFERENCES film(fid),
    aid INT REFERENCES artist(aid)
        ON DELETE CASCADE,
    category VARCHAR(100),
    year INT,
    PRIMARY KEY (fid, category)
);
```

### Istanze delle relazioni

**`film` (R)**

| fid | title | ... |
|---:|---|---|
| 101 | Il Padrino | ... |
| 102 | Trainspotting | ... |
| 103 | Il padrino parte II | ... |

**`award` (S)**

| fid | aid | category | year |
|---:|---:|---|---:|
| 101 | 101 | Best actor | 1973 |
| 103 | 103 | Best director | 1975 |
| 103 | 103 | Best movie | 1975 |

**`artist` (T)**

| aid | name | ... |
|---:|---|---|
| 101 | Marlon Brando | ... |
| 102 | Al Pacino | ... |
| 103 | Francis Ford Coppola | ... |

## Esercizio 1 (8 punti)

A. Si elenchino le chiavi esterne che non possono essere nulle nelle relazioni di `Festival`.

B. Si consideri lo schema ER a fianco. Se la gerarchia è esclusiva, possiamo affermare che $\forall x \in A \ldots$ (si completi l'affermazione).

Lo schema mostra la generalizzazione di `A` nei sottotipi `B` e `C`.

C. Quante voci possiede l'indice primario di un file con 20.000 record e `bfr = 10`?

D. Si definisca il concetto di attributo primo.

E. Mostrare la relazione risultato della seguente query SQL considerando le istanze delle tabelle R e S nella pagina precedente:

```sql
SELECT r.*
FROM film r LEFT JOIN award s
    ON r.fid = s.fid AND title <> 'Il Padrino';
```

F. Si descrivano gli effetti del seguente comando SQL sulle tabelle `film` (R) e `award` (S) riportate nella pagina precedente:

```sql
DELETE FROM film WHERE fid = 101;
```

## Esercizio 2 (fino a 15 punti)

Si svolgano le seguenti interrogazioni considerando lo schema relazionale `Festival`.

1. **[SQL]** Restituire i film con il maggior numero di premi (`award`).
2. **[SQL]** Trovare le coppie di artisti che hanno vinto il medesimo premio in anni consecutivi con film diversi.
3. **[SQL]** Trovare gli artisti che hanno vinto premi in ogni categoria presente nella tabella `award`.
4. **[SQL]** Restituire il titolo dei film con proiezioni (`screening`) in più di 3 `venue` diverse.
5. **[ALG]** Restituire i film che non hanno proiezioni premiere, ottimizzando l'espressione.

## Esercizio 3 (fino a 6 punti)

Si mostri lo schema ER corrispondente al seguente schema relazionale, dove le chiavi primarie sono rappresentate in grassetto e sottolineate, le chiavi esterne sono in corsivo e l'asterisco denota gli attributi potenzialmente nulli. Si minimizzino gli schemi di entità dove possibile.

- E1(**A11**, A12)
- E2(**A21**, **A22**, *A23*) - FK: (A23 $\rightarrow$ A11)
- E3(**A31**, *A32*) - FK: (A32 $\rightarrow$ A11)
- E4(**A41**, A42, *A43\**, *A44\**) - FK: ((A43, A44) $\rightarrow$ (A21, A22))
- E5(**A51**, **A52**, **A53**) - FK: (A51 $\rightarrow$ A11); ((A52, A53) $\rightarrow$ (A21, A22))

## Esercizio 4 (fino a 3 punti)

Si descriva l'attacco del cavallo di Troia nell'ambito della protezione dei dati di un database.

