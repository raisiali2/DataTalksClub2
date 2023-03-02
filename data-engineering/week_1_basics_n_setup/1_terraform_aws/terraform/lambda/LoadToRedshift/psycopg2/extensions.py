"""psycopg extensions to the DBAPI-2.0
This module holds all the extensions to the DBAPI-2.0 provided by psycopg.
- `connection` -- the new-type inheritable connection class
- `cursor` -- the new-type inheritable cursor class
- `lobject` -- the new-type inheritable large object class
- `adapt()` -- exposes the PEP-246_ compatible adapting mechanism used
  by psycopg to adapt Python types to PostgreSQL ones
.. _PEP-246: https://www.python.org/dev/peps/pep-0246/
"""