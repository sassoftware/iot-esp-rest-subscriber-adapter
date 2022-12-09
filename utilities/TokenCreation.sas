filename resp   temp;
filename hdrin  temp;
filename hdrout temp;

data _null_;
     file hdrin;
     put "accept:application/json";
     put "content-type:application/x-www-form-urlencoded";
run;

proc http method="post"
          url='https://<sasserver>/SASLogon/oauth/token'
          headerin=hdrin
          out=resp 
          headerout=hdrout
          in='grant_type=password&username=<userid>&password=<password>'
          webusername="espid"
          webpassword="espid_secret"
          auth_basic
          verbose;
run;

filename resp_map temp;
libname resp json map=resp_map automap=create;

data _null_;
      set resp.root;
      call symput('client_token', access_token);
run;

%put &client_token;
