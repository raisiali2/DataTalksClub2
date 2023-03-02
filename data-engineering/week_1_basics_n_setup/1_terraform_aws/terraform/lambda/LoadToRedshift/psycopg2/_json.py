"""Implementation of the JSON adaptation objects
This module exists to avoid a circular import problem: pyscopg2.extras depends
on psycopg2.extension, so I can't create the default JSON typecasters in
extensions importing register_json from extras.
"""