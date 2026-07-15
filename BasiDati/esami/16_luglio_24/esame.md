# Esame di Basi di Dati - 16 luglio 2024

90 minuti

> Alcune parti della prima pagina sono oscurate o poco leggibili nella fotografia. I punti non ricostruibili con certezza sono segnalati esplicitamente.

## Istruzioni leggibili

- Si usi il tema d'esame per appunti e il foglio protocollo per consegnare.
- Riportare sul foglio protocollo il riferimento all'esercizio che si sta svolgendo.
- Non usare matite e colori diversi da blu/nero.
- Consegnare sia il tema d'esame sia il foglio protocollo.
- Per valutazioni inferiori a 10 punti si applicherà il salto d'appello.

Tutti gli esercizi fanno riferimento allo schema relazionale `flight`.

## Schema relazionale `flight`

```sql
CREATE TABLE city (
    name varchar PRIMARY KEY,
    country varchar
);

CREATE TABLE airport (
    name varchar NOT NULL,
    num_airstrips integer NOT NULL,
    city varchar NOT NULL REFERENCES city(name),
    PRIMARY KEY (name, city)
);

CREATE TABLE aircraft (
    id integer PRIMARY KEY,
    model varchar NOT NULL,
    seats integer NOT NULL,
    /* attributo booleano non leggibile nella fotografia */
    brand varchar NOT NULL
        CHECK (brand IN ('BOEING', 'AIRBUS'))
);

CREATE TABLE flight (
    code char(6) PRIMARY KEY,
    air_company varchar NOT NULL,
    departure_airport_name varchar NOT NULL,
    departure_airport_city varchar NOT NULL,
    departure_datetime datetime NOT NULL,
    arrival_airport_name varchar NOT NULL,
    arrival_airport_city varchar NOT NULL,
    arrival_datetime datetime NOT NULL,
    aircraft integer REFERENCES aircraft(id),
    FOREIGN KEY (departure_airport_name, departure_airport_city)
        REFERENCES airport(name, city),
    FOREIGN KEY (arrival_airport_name, arrival_airport_city)
        REFERENCES airport(name, city),
    UNIQUE (
        air_company,
        departure_airport_name,
        departure_airport_city,
        departure_datetime
    )
);

CREATE TABLE client (
    id integer PRIMARY KEY,
    name varchar NOT NULL
);

CREATE TABLE passenger (
    client integer NOT NULL REFERENCES client(id),
    flight char(6) NOT NULL REFERENCES flight(code),
    price numeric(7,2) NOT NULL,
    seat char(4) NOT NULL,
    PRIMARY KEY (client, flight)
);
```

## Esercizio 1 (fino a 6 punti)

Si definisca lo schema ER non ristrutturato più adatto a rappresentare lo schema `flight` a livello concettuale.

## Esercizio 2 (fino a 3 punti per interrogazione)

Si svolgano le seguenti interrogazioni considerando lo schema relazionale `flight`:

1. **SQL:** si restituiscano gli aeroporti da cui partono più voli di quanti ne atterrano.
2. **SQL:** si restituisca il velivolo (`aircraft`) con il maggior numero di voli.
3. **SQL:** si restituiscano le coppie di nomi dei passeggeri che hanno volato sul medesimo volo.
4. **SQL:** si restituiscano i voli (`flight.code`) con più dell'80% dei posti occupati.
5. **ALGEBRA:** individuare il codice dei clienti che non sono mai partiti dall'aeroporto di Milano Linate.

## Esercizio 3 (fino a 3 punti)

Si descriva il problema di **dirty read** nella concorrenza delle basi di dati e come prevenirlo.

## Esercizio 4 (fino a 4 punti)

Si mostri il grafo delle autorizzazioni corrispondente alle seguenti istruzioni (il numero all'inizio della riga è il tempo di esecuzione del comando; il nome è l'utente esecutore):

```sql
-- 10, Jannik
GRANT SELECT, INSERT ON R TO Jannik WITH GRANT OPTION;

-- 20, Jannik
GRANT SELECT, INSERT ON R TO Carlos WITH GRANT OPTION;

-- 25, Jannik
GRANT SELECT, INSERT ON R TO Novak WITH GRANT OPTION;

-- 30, Novak
GRANT SELECT ON R TO Carlos;

-- 30, Novak
GRANT INSERT ON R TO Alexander;

-- 30, Novak
GRANT SELECT, INSERT ON R TO Hubert WITH GRANT OPTION;

-- 40, Hubert
GRANT SELECT, INSERT ON R TO Alexander;

-- 45, Carlos
GRANT SELECT, INSERT ON R TO Hubert WITH GRANT OPTION;
```

Si mostri il grafo a seguito della seguente istruzione:

```sql
-- 50, Jannik
REVOKE ALL ON R FROM Novak CASCADE;
```

## Esercizio 5 (fino a 3 punti)

Si risponda alle seguenti domande:

- Si fornisca un esempio di superchiave non minimale della relazione `flight`.
- Si stabilisca la forma normale della relazione `aircraft`, sapendo che sussistono le dipendenze funzionali $model \rightarrow seats$ e $model \rightarrow brand$.
- I valori dell'attributo `flight.aircraft` si aggiornano automaticamente e coerentemente in seguito agli aggiornamenti all'attributo `aircraft.id`? Di quale vincolo del modello relazionale si tratta?

