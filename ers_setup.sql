create table if not exists Employee (
	employee_id 		serial primary key,
	employee_name		varchar(50) unique not null,
	employee_password	varchar(50) not null,
	employee_position	varchar(30),
	employee_salary		integer,
	management			boolean
)

create table if not exists Reimbursement (
	reimbursement_id		serial primary key,
	employee_id				integer references Employee,
	expense_type			varchar(50),
	amount					integer,
	approved				boolean
)

drop table Reimbursement;

create or replace function add_employee(name_input Employee.employee_name%type, password_input Employee.employee_password%type, position_input Employee.employee_position%type, salary_input Employee.employee_salary%type, management_input Employee.management%type)
returns integer
language plpgsql
as $$
declare 
	id integer;
begin 
	insert into Employee (employee_name, employee_password, employee_position, employee_salary, management) 
	values (name_input, password_input, position_input, salary_input, management_input);
	select last_value from employee_employee_id_seq into id;
	return id;
end
$$



create or replace function add_reimbursement(employee_id_input Employee.employee_id%type, expense_type_input Reimbursement.expense_type%type, amount_input Reimbursement.amount%type)
returns integer
language plpgsql
as $$
declare 
	id integer;
begin 
	insert into Reimbursement (employee_id, expense_type, amount) 
	values (employee_id_input,  expense_type_input, amount_input);
	select last_value from reimbursement_reimbursement_id_seq into id;
	return id;
end
$$


select add_reimbursement(3, 'Books', 10000);

select * from Employee;

select * from Employee where employee_name = 'Alice' and employee_password = 'p4ssw3rd';

select add_employee('Bertrand', 'p4ssw3rd', 'Clerk', 4000000, false);

select * from Reimbursement;
