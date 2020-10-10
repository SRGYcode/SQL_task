--SQL task
--Given tables:
--01. tasks (id, name, status, project_id)
--02. projects (id, name)
--Technical requirements


-- get all statuses, not repeating, alphabetically ordered
select distinct status
  from tasks
  order by status asc;

--get the count of all tasks in each project, order by tasks count descending
select project_id, count (id) as 'cnt'
  from tasks 
  group by project_id
  order by count (id) desc;

--get the count of all tasks in each project, order by projects names
select t2.name, count (t1.id) as 'cnt'
  from tasks as t1
  join projects as t2 on t1.project_id = t2.id
  group by t2.name
  order by t2.name asc;

-- get the tasks for all projects having the name beginning with "N" letter
select t1.*
  from tasks as t1
  join projects as t2 on t1.project_id = t2.id
  where t2.name like 'N%';

-- get the list of all projects containing the 'a' letter in the middle of
-- the name, and show the tasks count near each project. Mention
-- that there can exist projects without tasks and tasks with
-- project_id = NULL
select t1.name, count(t2.id) as 'cnt'
  from projects as t1
  join tasks as t2 on t1.id = t2.project_id
  group by t1.name
  having t1.name like '%a%';

-- get the list of tasks with duplicate names. Order alphabetically
select name, count(id) as 'cnt'
  from tasks
  group by name
  having count(id) > 1
  order by name asc;

-- get list of tasks having several exact matches of both name and
-- status, from the project 'Garage'. Order by matches count
select t1.name, t1.status, count(t1.id) as 'cnt'
  from tasks as t1
  join projects as t2 on t1.project_id = t2.id
  where t2.name = 'Garage'
  group by t1.name, t1.status
  having count(t1.id) > 1
  order by count(t1.id) desc;

-- get the list of project names having more than 10 tasks 
-- in status 'completed'. Order by project_id
select t2.project_id, t1.name, count(t2.id) as 'cnt'
  from projects as t1
  join tasks as t2 on t1.id = t2.project_id
  where t2.status = 'completed'
  group by t1.name
  having count(t2.id) > 10
  order by t2.project_id;