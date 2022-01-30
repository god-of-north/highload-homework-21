create table test5(i int);
create table test6(i int);
insert into test5 values (generate_series(1,1000000));
insert into test6 values (generate_series(1,1000000));
insert into test5 values (generate_series(2,1000000));
insert into test6 values (generate_series(2,1000000));
insert into test5 values (generate_series(3,1000000));
insert into test6 values (generate_series(3,1000000));
