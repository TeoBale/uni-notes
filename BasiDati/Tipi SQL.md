
## Tipi di attributi in un database SQL

### 🔢 Tipi Numerici

#### Interi
- **`TINYINT`** — Intero molto piccolo (0–255 signed, -128–127 unsigned)
- **`SMALLINT`** — Intero piccolo (-32.768 / +32.767)
- **`MEDIUMINT`** — Intero medio (MySQL)
- ==**`INT` / `INTEGER`** — Intero standard (-2 miliardi / +2 miliardi)==
- ==**`BIGINT`** — Intero grande==
- ==**`SERIAL`** — Intero auto-incrementale (PostgreSQL)==
- **`SMALLSERIAL`**, **`BIGSERIAL`** — Come sopra ma con SMALLINT/BIGINT (PostgreSQL)

#### Decimali / Virgola mobile
- ==**`DECIMAL(p, s)` / `NUMERIC(p, s)`** — Numero a precisione fissa (p = cifre totali, s = decimali)==
- ==**`FLOAT(p)`** — Virgola mobile a precisione singola==
- ==**`DOUBLE` / `REAL`** — Virgola mobile a precisione doppia==
- **`MONEY`** — Valuta (PostgreSQL, SQL Server)

---

### 📝 Tipi Testuali / Stringhe

- ==**`CHAR(n)`** — Stringa a lunghezza fissa (1–255 caratteri)==
- ==**`VARCHAR(n)`** — Stringa a lunghezza variabile (fino a n caratteri)==
- ==**`TEXT`** — Testo di lunghezza illimitata==
- **`TINYTEXT`** — Testo molto piccolo (MySQL, max 255 byte)
- **`MEDIUMTEXT`** — Testo medio (MySQL, max 16 MB)
- **`LONGTEXT`** — Testo grande (MySQL, max 4 GB)
- **`CHARACTER VARYING(n)`** — Sinonimo di VARCHAR (SQL standard)

---

### ⏰ Tipi Temporali / Data e Ora

- ==**`DATE`** — Data (AAAA-MM-GG)==
- ==**`TIME`** — Orario (HH:MM:SS)==
- **`TIME WITH TIME ZONE`** — Orario con fuso orario
- ==**`DATETIME`** — Data + ora==
- ==**`TIMESTAMP`** — Timestamp UNIX (data + ora)==
- **`TIMESTAMP WITH TIME ZONE`** — Timestamp con fuso orario
- ==**`INTERVAL`** — Intervallo di tempo (PostgreSQL)==
- ==**`YEAR`** — Solo anno (MySQL)==

---

### 🧬 Tipi Binari

- **`BINARY(n)`** — Dati binari a lunghezza fissa
- **`VARBINARY(n)`** — Dati binari a lunghezza variabile
- **`BLOB`** — Binary Large Object (dati binari grandi)
- **`TINYBLOB`**, **`MEDIUMBLOB`**, **`LONGBLOB`** — Varianti di BLOB (MySQL)
- **`BYTEA`** — Dati binari (PostgreSQL)

---

### 🎯 Tipi Booleani e Speciali

- ==**`BOOLEAN` / `BOOL`** — Vero/Falso (TRUE, FALSE, NULL)==
- ==**`BIT(n)`** — Campo di bit (1–64 bit)==
- **`ENUM(val1, val2, ...)`** — Enumerazione (scegli uno tra valori predefiniti) — MySQL, PostgreSQL
- ==**`SET(val1, val2, ...)`** — Insieme di valori predefiniti (zero o più) — MySQL==

---

### 🧩 Tipi Strutturati / Avanzati (PostgreSQL)

- **`UUID`** — Identificatore univoco universale
- **`JSON`** — Dati JSON (testo validato)
- **`JSONB`** — JSON binario indicizzabile (PostgreSQL)
- **`XML`** — Dati XML
- **`ARRAY`** — Array di un tipo (`INTEGER[]`, `TEXT[]`, …)
- **`HSTORE`** — Coppie chiave-valore
- **`CIDR`**, **`INET`**, **`MACADDR`** — Indirizzi di rete (IP, MAC)
- **`GEOMETRY`**, **`GEOGRAPHY`** — Dati geospaziali (PostGIS)
- **`POINT`**, **`LINE`**, **`POLYGON`** — Tipi geometrici
- **`TSVECTOR`**, **`TSQUERY`** — Ricerca full-text
- **`RANGE`** — Range di valori (`int4range`, `daterange`, …)
- **`COMPOSITE`** — Tipo definito dall'utente (combinazione di più attributi)
- **`ENUM`** — Tipo enumerato personalizzato
- **`DOMAIN`** — Tipo basato su un tipo esistente con vincoli aggiuntivi

---

### 🗄️ Riepilogo per DBMS

| `Categoria`   | `MySQL / MariaDB`   | `PostgreSQL` | `SQL Server`             | `SQLite`        |
| ----------- | ----------------- | ---------- | ---------------------- | ------------- |
| Intero      | INT               | INTEGER    | INT                    | INTEGER       |
| Decimale    | DECIMAL           | NUMERIC    | DECIMAL                | REAL          |
| Stringa     | VARCHAR           | VARCHAR    | VARCHAR/NVARCHAR       | TEXT          |
| Testo lungo | TEXT/LONGTEXT     | TEXT       | VARCHAR(MAX)           | TEXT          |
| Binario     | BLOB              | BYTEA      | VARBINARY(MAX)         | BLOB          |
| Data        | DATE              | DATE       | DATE                   | TEXT/INTEGER  |
| Ora         | DATETIME          | TIMESTAMP  | DATETIME2              | TEXT/INTEGER  |
| Booleano    | TINYINT(1) / BOOL | BOOLEAN    | BIT                    | INTEGER (0/1) |
| JSON        | JSON              | JSON/JSONB | NVARCHAR(MAX) + ISJSON | TEXT          |
