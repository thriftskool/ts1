delete from "public"."users_manage";
insert into "public"."users_manage" ("int_glcode","fk_university","var_emailid","var_password","var_conf_password","chr_delete","dt_createdate","dt_modifydate","var_adminuser","var_ipaddress","chr_publish","chr_spam","chr_buzz","fk_user_id","chr_verify","device_id","var_username") 
  values (39,27,'testby@caltech.edu','112086094093091118006010010','','N','8/6/2015','8/6/2015','Administrator','127.0.0.1','Y','N','N',null,'N','test','user1') ;
insert into "public"."users_manage" ("int_glcode","fk_university","var_emailid","var_password","var_conf_password","chr_delete","dt_createdate","dt_modifydate","var_adminuser","var_ipaddress","chr_publish","chr_spam","chr_buzz","fk_user_id","chr_verify","device_id","var_username") 
  values (40,27,'user2@caltech.edu','112086094093091118006010010','','N','8/6/2015','8/6/2015','Administrator','127.0.0.1','Y','N','N',null,'N','test','user2') ;
