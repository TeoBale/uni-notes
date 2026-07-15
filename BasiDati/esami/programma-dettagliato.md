# Basi di Dati - Programma Dettagliato del Corso

## Modulo di Basi di Dati

- **Introduzione alle basi di dati**: Informazioni e dati, Basi di dati e sistemi di gestione di basi di dati (DBMS).
- **Modelli dei dati**: Concetti di schema e istanza, livelli di astrazione nei DBMS, indipendenza dei dati.
- **Linguaggi e utenti** delle basi di dati.
- **Il Modello Relazionale**:
    - Relazioni e tabelle, schema e istanza di una relazione.
    - Caratteristiche delle relazioni, informazione incompleta e valori nulli.
    - Chiavi e vincoli di integrità.
    - **Algebra Relazionale**: definizioni, operatori, equivalenza di espressioni e trasformazioni.
- **Il Linguaggio SQL**:
    - **DDL (Data Definition Language)**: Definizione di schemi, tabelle, domini; rappresentazione di vincoli; modifica e cancellazione dello schema.
    - **DML (Data Manipulation Language)**: Query semplici, operatori aggregati, raggruppamenti (`GROUP BY`), operazioni insiemistiche, query nidificate.
    - **Modifica dei dati**: `INSERT`, `DELETE`, `UPDATE`.
    - **Vincoli e Trigger**: Asserzioni, vincoli di integrità generici, trigger (definizione e uso - cenni).
    - **Viste**: Definizione, uso, problemi di aggiornabilità (cenni).
- **Il Modello Entità-Relazione (ER)**:
    - Costrutti di base (entità, relazioni, attributi).
    - Gerarchie di generalizzazione e identificatori.
    - Vincoli di integrità e documentazione di schemi ER.
- **Progettazione di Basi di Dati**:
    - Metodologie di progettazione: analisi dei requisiti.
    - **Progettazione Concettuale**: strategie top-down, bottom-up e mixed; qualità dello schema.
    - **Progettazione Logica**: modellazione del carico, ristrutturazione dello schema, regole di traduzione da ER a schema relazionale.
    - **Progettazione Fisica**: concetto di indice e criteri di definizione (cenni).
- **Normalizzazione**:
    - Dipendenze funzionali.
    - Forme normali: 1NF, 2NF, 3NF, Boyce-Codd NF (BCNF).
    - Decomposizione: senza perdita e conservazione delle dipendenze.
- **Sicurezza**:
    - Protezione dei dati, autenticazione, controllo degli accessi.
    - Politiche discrezionali (DAC) e mandatorie (MAC).
    - Modello di autorizzazione SystemR, revoca ricorsiva.
- **Transazioni**: Concetto di transazione, proprietà ACID.
- **Modelli NoSQL**:
    - Differenze con i sistemi relazionali, tipologie di sistemi NoSQL.
    - **MongoDB**: Sistemi document-based, modello dei dati, query e aggregazioni.

## Modulo di Laboratorio

- **DBMS e Architettura**: Tipologie e architettura client/server.
- **PostgreSQL**:
    - Installazione e configurazione, architettura.
    - Controllo degli accessi e firewall.
    - Dump di schemi e comandi da terminale/interfaccia web.
    - Creazione di database, utenti e tabelle.
    - Chiavi e vincoli di integrità referenziale.
- **Embedded SQL e PL/pgSQL**:
    - Sviluppo di applicazioni SQL, concetto di cursore.
    - **PL/pgSQL**: Struttura, variabili e tipi, query SQL in programmi PL/pgSQL.
    - Controllo di flusso: `IF`, `LOOP`, `WHILE`, `FOR`.
    - Cursori e Trigger in PL/pgSQL.
- **Esercitazioni**:
    - Progettazione concettuale e logica.
    - Funzioni e trigger in PL/pgSQL.
