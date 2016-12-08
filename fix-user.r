strsplit(as.vector(users$friends[2]),',')

users<-read.csv("yelp_academic_dataset_user.csv")
elite_users<-select(users,user_id,elite)
elite_users<-mutate(elite_users,is_elite = as.vector.factor(elite_users$elite)!="[]")
filt_elite_users<-filter(elite_users,is_elite)

users<-stream_in(file("yelp_academic_dataset_user.json"),simplifyVector=F)
is.vector(unlist(users[[4]]))
