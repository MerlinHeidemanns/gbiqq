library("devtools")
library("gbiqq")
#install_github("datastorm-open/DependenciesGraphs")
library("DependenciesGraphs")

# List all functions
gbiqq.funs <- lsf.str("package:gbiqq")

# Graph function dependencies
all.dep <- envirDependencies("package:gbiqq")
plot(all.dep, block = T)

# List "used" funcs indices
poss_used_funcs <- sort(unique(c(all.dep$fromto$from,all.dep$fromto$to)))

# Identify possible functions to depreciate
poss_unused_funcs <- all.dep$Nomfun[!(1:81 %in% poss_used_funcs),2]
