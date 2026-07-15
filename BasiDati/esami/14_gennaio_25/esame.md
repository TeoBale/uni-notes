# Esame scritto di Basi di Dati - 14 gennaio 2025

## Schema relazionale `registry`

```sql
CREATE TABLE person (
    id integer PRIMARY KEY,
    name varchar(100) NOT NULL,
    birth_date date,
    father integer,
    mother integer
);

ALTER TABLE person ADD CONSTRAINT father_fk
FOREIGN KEY (father) REFERENCES person(id);

ALTER TABLE person ADD CONSTRAINT mother_fk
FOREIGN KEY (mother) REFERENCES person(id);

CREATE TABLE document (
    serial_n varchar(20) PRIMARY KEY,
    doc_type varchar(20) NOT NULL,
    released_by varchar(100),
    release_date date NOT NULL,
    expiry_date date NOT NULL,
    doc_owner integer NOT NULL REFERENCES person(id),
    CHECK (doc_type IN ('carta id', 'patente', 'cod. fiscale'))
);

CREATE TABLE certificate (
    id integer PRIMARY KEY,
    description varchar(100) NOT NULL
);

CREATE TABLE certificate_request (
    r_date date NOT NULL,
    person integer NOT NULL REFERENCES person(id),
    certificate integer NOT NULL REFERENCES certificate(id),
    PRIMARY KEY (r_date, person, certificate)
);
```

## Esercizio 1 (fino a 6 punti)

Si definisca lo schema ER non ristrutturato più adatto a rappresentare lo schema `registry` a livello concettuale.

## Esercizio 2 (fino a 3 punti per interrogazione)

Si svolgano le seguenti interrogazioni considerando lo schema relazionale `registry`:

1. **SQL:** si restituiscano le coppie di nomi di persone che sono padre-figlio.
2. **SQL:** per ogni persona, si restituisca il numero di documenti in corso di validità (cioè non scaduti). Si includano nel risultato anche le persone che non hanno documenti in corso di validità, che compariranno con conteggio pari a zero.
3. **SQL:** si restituisca la persona (o persone) che ha richiesto il maggior numero di certificati diversi.
4. **ALGEBRA:** si restituiscano le persone che non hanno documenti in corso di validità.
5. **ALGEBRA:** individuare le persone che hanno richiesto tutti i diversi certificati disponibili.

## Esercizio 3 (fino a 3 punti)

Si illustrino le caratteristiche delle politiche di *need-to-know* e *maximized sharing* per il controllo degli accessi, mettendone in evidenza le peculiarità e le differenze.

## Esercizio 4 (fino a 4 punti)

Si definiscano le proprietà di decomposizione senza perdita e conservazione delle dipendenze nella normalizzazione di schemi di relazione.

## Esercizio 5 (fino a 3 punti)

Si consideri la seguente istanza della relazione `document` e si riportino tutte le violazioni osservabili da questa tabella rispetto alla definizione DDL.

|    | serial_n | doc_type | released_by | release_date | expiry_date | doc_owner |
|---:|---|---|---|---|---|---:|
| R1 | AC222FA | carta id. | Comune di Milano | 2022-10-01 | 2020-10-01 | 56 |
| R2 | 3255222 | patente | Motorizzazione di Milano | 2023-08-10 | 2024-08-10 | 5B |
| R3 | AD352GH |  | Comune di Milano | 2025-02-01 | 2025-03-01 | 34 |
| R4 | ED383BB | carta id. |  | 2021-04-01 | 2025-04-01 | 2131 |
| R5 | FJGKJ47 | CF | Agenzia Entrate | 2020-01-01 | 2030-01-01 | 34 |

