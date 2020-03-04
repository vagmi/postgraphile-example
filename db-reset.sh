dropdb -h db -U postgres reviews && createdb -h db -U postgres reviews
psql -h db -U postgres reviews -f 000-common-utils.sql && \
psql -h db -U postgres reviews -f 001-schema.sql && \
psql -h db -U postgres reviews -f 002-auth-system.sql
