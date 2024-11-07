CREATE TABLE jobs(
  id bigint primary key generated always as identity,
  user_id uuid,
  type_id int,
  title varchar(200) not null,
  upload_date date default current_date,
  deadline_date date not null,
  dsc text not null,
  total_applicant int default 0,
  foreign key (user_id) references auth.users(id),
  foreign key (type_id) references job_types(id)
);
create table job_types(
  id int primary key generated always as identity,
  type_name varchar(100) not null
);

insert into jobs(title, user_id, deadline_date, dsc)
values
('web devloper', 'cff43359-8158-4855-9345-50cee9dd15d2', '2021-12-30', 'i need a programmer'),
('web devloper', 'cff43359-8158-4855-9345-50cee9dd15d2', '2021-12-30', 'i need a programmer'),
('web devloper', '497a28cf-c41c-483c-922b-eae87f3025bd', '2021-12-30', 'i need a programmer');

create view get_job_list as
select A.id, C.type_name, A.title, A.dsc, B.raw_user_meta_data->'name' as user_name, B.raw_user_meta_data->'image_url' as user_image_url
from (jobs as A join auth.users as B on A.user_id = B.id) join job_types as C on A.type_id = C.id;