/* 
	using for the whole exercising 
	login:	mysql -h localhost -u root -p
*/

show databases;		--show the all databases

create database imooc;		--create databases;

drop database imooc;		-- delete databases

show engines;		--show 数据库存储引擎
show columns from customers;	-- equal describe customers
show status; 	--show the status of service
show create database imooc; 	--show how to create the database of imooc 
show create table customers; 	--show how to create the table of customers
show grants;	--show the security permissions
show errrors;
show warnings;


create table customers		-- create table
(
	cust_id int not null auto_increment,
	cust_name char(50) not null,
	cust_address char(50) null,
	cust_city char(50) not null default "China",
	cust_email char(220) null,
	primary key(cust_id)
)engine=Innodb;

describe customers;		--查看表结构

drop table customers;		--delete this table

/* retrieve data */
select * from customers;
select customers.cust_id,customers.cust_name from imooc.customers; --can use limited name

select * from customers limit 5; 	--return to the first five lines, begin from the zero
select * from customers limit 5 5;	--the first number 5 is start position,the secend number 5 is retrieve number
select * from customers order by cust_name desc,cust_city;	--desc(descend),default->asc(ascending)

select * from customers where cust_id betweem 2 and 5;	--: = equal ==,<> equal !=,< equal <,....,between ? and ? equal ? < result <?, what's more : and equal &&, or equal ||, not equal !, in...
select * from customers where cust_id not in (4,5);

select * from customers where cust_name like '%jake%';	-- % matching any number's word
select * from customers where cust_name  like '_jake';	-- _ jsut matching one word
select * from customers where cust_name regexp 'jake\\.' -- regexp matching

/* 一些MySQL自带函数总结 */
select Concat(cust_id,'(',cust_name,')') as newword from customers; --Concat:拼接函数,as：使用别名
/* 
	Lower() 将字符串转换为小写
	LTrim() 去掉左边的空格
	RTrim() 去掉右边的空格
	Upper() 将字符串转换为大写
	CurDate() 返回当前日期
	CurTime() 返回当前时间
	Now() 返回当前日期和时间
	Abs() 取绝对值
	Rand() 返回一个随机数
	......
	其他见ps71
*/

/*  
	AVG()	某列平均值
	COUNT()	某列行数
	MAX()	某列最大值
	MIN()	某列最小值
	SUM()	某列之和
*/

/* 分组汇总或者过滤 */
select cust_id,Count(*) as num from customers group by cust_city;	--通过group by指定 Count 如何进行分组过滤
select cust_id,Count(*) as num from customers where cust_name like '%haoge%' group by cust_city having num>0 order by cust_id; 	--一个比较全的select

/* use subquery */
select cust_id, cust_name from customers where cust_id in (select cust_id from customers were cust_id > 10);
select cust_name, cust_city (select Count(*) from customers where orders.cust_id = customers.cust_id) as orders from customers; 

/* ------ insert data ------ */
insert into customers
	values(3,"qiangzi","uestc","chengdu","442323@qq.com");

insert into customers(cust_id,cust_name,cust_city)
	values(4,null,null),(5,"jake","shanghai");

insert into customers(cust_id,cust_city) select cust_id,cust_city from otercustomers;

/* ----- update data ---- */
update customers set cust_city="shenzhen",cust_email="12121@qq.com" where cust_id = 1001;

/* ----- delete data ----- */
delete from customers where cust_id = 1001;

/* ----- views :equal a table ,just virtual ----- */
create view productcustomers as 
	select cust_id,cust_email from customers where cust_id>3;
show create view productcustomers;	-- show the creation of productcustomers
drop view productcustomers;	-- delete view productcustomers

/* 使用存储过程,可结合多条语句，以免出错，已编译，更快*/
-- 客户端更改分隔符 delimiter // <=> delimiter ;

drop procedure if exists `proc_add`;	--其中`` 而不是 '',要么不加上去，要么就用``
delimiter ;;
create definer=`root`@`localhost` procedure `proc_add`(IN a int, IN b int, OUT sum int)
	begin
		#Routine body goes here...
		declare c int;
		if a is null then set a = 0;
		end if;

		if b is null then set b = 0;
		end if;

		set sum = a+b;
	end;;
delimiter ;
-- 测试
set @b = 5;
call proc_add(2,@b,@s);
select @s as sum;

/* 控制过程里面用到的语法见:
	-> http://blog.csdn.net/horace20/article/details/7056151
*/









