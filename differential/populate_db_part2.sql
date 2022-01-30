create table test3(i int);
create table test4(i int);
insert into test3 values (generate_series(1,100000));
insert into test4 values (generate_series(1,100000));
insert into test3 values (generate_series(2,100000));
insert into test4 values (generate_series(2,100000));
insert into test3 values (generate_series(3,100000));
insert into test4 values (generate_series(3,100000));
