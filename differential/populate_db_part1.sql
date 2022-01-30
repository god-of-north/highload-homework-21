create table test1(i int);
create table test2(i int);
insert into test1 values (generate_series(1,100000));
insert into test2 values (generate_series(1,100000));
insert into test1 values (generate_series(2,100000));
insert into test2 values (generate_series(2,100000));
insert into test1 values (generate_series(3,100000));
insert into test2 values (generate_series(3,100000));
