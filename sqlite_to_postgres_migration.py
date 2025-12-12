from sqlalchemy import create_engine, MetaData, inspect
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy import TIMESTAMP
import time
from sqlalchemy import text

# Database URLs
sqlite_url = "sqlite:///patients_health.db"
pg_url = "postgresql+psycopg2://postgres:sangita@localhost:5432/patients_health"

# Tables to migrate
TABLES_TO_MIGRATE = [
    "Patients",
    "Doctors",
    "Medical_History",
    "Appointments",
    "Lab_Results",
    "Analytics"
    
]

# Engines
sqlite_engine = create_engine(sqlite_url)
pg_engine = create_engine(pg_url)

# Inspectors
sqlite_inspector = inspect(sqlite_engine)
pg_inspector = inspect(pg_engine)


def migrate():
    sqlite_meta = MetaData()
    sqlite_meta.reflect(bind=sqlite_engine, only=TABLES_TO_MIGRATE)

    from sqlalchemy.types import DateTime

    for table_name in TABLES_TO_MIGRATE:
        table = sqlite_meta.tables[table_name]

        # Fix DateTime → TIMESTAMP
        for col in table.columns:
            if isinstance(col.type, DateTime):
                col.type = TIMESTAMP()

        table.create(bind=pg_engine, checkfirst=True)

        with sqlite_engine.connect() as s_conn, pg_engine.connect() as p_conn:
            rows = s_conn.execute(table.select()).mappings().all()
            if rows:
                p_conn.execute(table.insert(), rows)
                p_conn.commit()
                print(f"Migrated {len(rows)} rows from {table_name}")
            else:
                print(f"No data found in {table_name}")



def validate_table(table_name):
    print(f"\nValidating table: {table_name}")

    sqlite_exists = table_name in sqlite_inspector.get_table_names()
    pg_exists = table_name in pg_inspector.get_table_names()

    print("Table exists in SQLite:", sqlite_exists)
    print("Table exists in PostgreSQL:", pg_exists)

    if not sqlite_exists or not pg_exists:
        print(" Table missing. Validation failed.")
        return

    sqlite_cols = [c["name"] for c in sqlite_inspector.get_columns(table_name)]
    pg_cols = [c["name"] for c in pg_inspector.get_columns(table_name)]

    print("Columns match:", sqlite_cols == pg_cols)

    with sqlite_engine.connect() as s_conn, pg_engine.connect() as p_conn:
        s_count = s_conn.execute(
            text(f'SELECT COUNT(*) FROM "{table_name}"')
        ).scalar()

        p_count = p_conn.execute(
            text(f'SELECT COUNT(*) FROM "{table_name}"')
        ).scalar()

    print("SQLite row count:", s_count)
    print("PostgreSQL row count:", p_count)
    print("Row count match:", s_count == p_count)

    if sqlite_cols == pg_cols and s_count == p_count:
        print(" Schema validation PASSED")
    else:
        print(" Schema validation FAILED")



if __name__ == "__main__":
    start_time = time.time()

    try:
        migrate()
    except SQLAlchemyError as e:
        print("Migration error:", e)

    end_time = time.time()
    print(f"\nMigration completed in {end_time - start_time:.2f} seconds")

    # Validate schemas
    for table in TABLES_TO_MIGRATE:
        validate_table(table)
