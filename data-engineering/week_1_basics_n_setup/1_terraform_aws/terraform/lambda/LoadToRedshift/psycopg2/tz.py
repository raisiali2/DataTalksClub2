"""tzinfo implementations for psycopg2
This module holds two different tzinfo implementations that can be used as
the 'tzinfo' argument to datetime constructors, directly passed to psycopg
functions or used to set the .tzinfo_factory attribute in cursors.
"""