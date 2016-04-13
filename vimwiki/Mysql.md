# Mysql Notes

- add mysql user
```
create user 'user'@'host' identified by 'password_here';

```

- change user's password
```
set password for 'user'@'host' = password('password_here');

```

- show all users for a database
```
select * from mysql.user;

```

- grant privileges for database to user
```
grant select, insert, update, delete on database_name.* to 'user'@'host';
flush privileges;

```

- show grants on database
```
show grants for 'user'@'host';

```

- grant permissions to user
```
grant permission on database.table to 'user'@'host';

```

- how to do a mysqd dump without stressing the server
```
mysqldump --single-transaction --quick --lock-tables=false

```

- import mysql database with pregress
```
pv database.sql | mysql -u name -p db_name < database.sql

```


