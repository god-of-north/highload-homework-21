create table test3(i int);
create table test4(i int);
insert into test3 values (generate_series(1,1000000));
insert into test4 values (generate_series(1,1000000));
insert into test3 values (generate_series(2,1000000));
insert into test4 values (generate_series(2,1000000));
insert into test3 values (generate_series(3,1000000));
insert into test4 values (generate_series(3,1000000));
