import db_connector/db_sqlite, strutils

const db_path = "/var/www/html/data.sqlite"

let db = open(db_path, "", "", "") # Can't insert into DB? check file permissions.

type DbString* = string

proc query*(query_str: static[string], args: varargs[string, `$`]): bool {.discardable.} =
  db.tryExec(sql(query_str), args)

proc fquery*(query_str: static[string], args: varargs[string, `$`]): bool {.discardable.} =
  db.exec(sql(query_str), args)

proc insert*(query_str: static[string], args: varargs[string, `$`]): bool =
  db.execAffectedRows(sql(query_str), args) == 1

proc update*(query_str: string, args: varargs[string, `$`]): bool =
  db.execAffectedRows(sql(query_str), args) == 1

proc select_col*(query_str: static[string], args: varargs[string, `$`]): DbString =
  db.getValue(sql(query_str), args)

proc select_row*(query_str: static[string], args: varargs[string, `$`]): seq[DbString] =
  db.getRow(sql(query_str), args)

iterator iterate_rows*(query_str: static[string], args: varargs[string, `$`]): seq[DbString] =
  for row in db.fastRows(sql(query_str), args):
    yield row

converter toBool*(ds: DbString): bool = ds == "1"
converter toInt*(ds: DbString): int = parseInt(ds)
converter toFloat*(ds: DbString): float = parseFloat(ds)

when isMainModule:

  fquery("""
  CREATE TABLE IF NOT EXISTS accounts (
    email VARCHAR(128) PRIMARY KEY NOT NULL,
    password VARCHAR(128) NOT NULL,
    verified BOOL NOT NULL DEFAULT false,
    max_characters INT NOT NULL DEFAULT 3,
    created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
  ) WITHOUT ROWID;""")
  
  #state: state INT64 NOT NULL DEFAULT random(),
  fquery("""
  CREATE TABLE IF NOT EXISTS characters (
    name VARCHAR(64) PRIMARY KEY NOT NULL,
    email VARCHAR(128) NOT NULL,
    created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOL NOT NULL DEFAULT false,
    last_action TIMESTAMP,
    x INT, y INT, z INT DEFAULT 0, inside BOOL DEFAULT false,
    ap FLOAT NOT NULL DEFAULT 100.0,
    hunger INT NOT NULL DEFAULT 10,
    hp INT NOT NULL DEFAULT 50, max_hp INT NOT NULL DEFAULT 50,
      FOREIGN KEY (email) REFERENCES accounts (email)
        ON DELETE CASCADE ON UPDATE CASCADE
  ) WITHOUT ROWID;""")

  fquery("""
  CREATE TABLE IF NOT EXISTS world (
    x INT NOT NULL, y INT NOT NULL, z INT NOT NULL,
    region VARCHAR(24) NOT NULL,
    terrain VARCHAR(24) NOT NULL,
    feature VARCHAR(24),
    PRIMARY KEY (x,y,z)
  ) WITHOUT ROWID;""")

  fquery("""
  CREATE TABLE IF NOT EXISTS creatures (
    x INT NOT NULL, y INT NOT NULL, z INT NOT NULL,
    kind VARCHAR(24) NOT NULL,
    hp INT NOT NULL, max_hp INT NOT NULL,
    hunger INT NOT NULL
  );""")

  fquery("""
  CREATE TABLE IF NOT EXISTS inventory (
    owner VARCHAR(64) NOT NULL,
    item VARCHAR(24) NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (owner) REFERENCES characters (name)
      ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (owner, item)
  );""")

  fquery("""
  CREATE TABLE IF NOT EXISTS storage (
    id INT NOT NULL,
    item VARCHAR(24) NOT NULL,
    amount INT NOT NULL,
    temporary BOOL NOT NULL DEFAULT false,
    drop_date DATETIME,
    PRIMARY KEY (id, item)
  ) WITHOUT ROWID;""")

  fquery("""
  CREATE TABLE IF NOT EXISTS constructs (
    x INT NOT NULL, y INT NOT NULL, z INT NOT NULL,
    kind VARCHAR(24) NOT NULL,
    hp INT NOT NULL, max_hp INT NOT NULL,
    moveable BOOL NOT NULL,
    storage_id INT,
    FOREIGN KEY (storage_id) REFERENCES storage (id)
      ON DELETE SET NULL
  );""")

  fquery("""
  INSERT INTO world (
    x,y,z,
    region,
    terrain
  ) VALUES
  (0,0,0, "test", "plains"), (1,0,0, "test", "plains"), (2,0,0, "test", "forest"), (3,0,0, "test", "forest"),
  (0,1,0, "test", "plains"), (1,1,0, "test", "plains"), (2,1,0, "test", "forest"), (3,1,0, "test", "forest"),
  (0,2,0, "test", "plains"), (1,2,0, "test", "plains"), (2,2,0, "test", "forest"), (3,2,0, "test", "plains"),
  (0,3,0, "test", "plains"), (1,3,0, "test", "plains"), (2,3,0, "test", "plains"), (3,3,0, "test", "plains");
  """)

  when defined(debug):
    import os
    template showtbl(table_name: string): void =
      var row_id: int
      for row in iterate_rows("SELECT * FROM ?", table_name):
        echo row_id, row
        inc row_id
      if row_id == 0:
        echo "[Empty table]"
    if paramCount() > 0:
      showtbl(paramStr(1))
  