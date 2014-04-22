run_analysis <- function() {        

      trainset <- createDataset("train")     
      testset <-  createDataset("test")  

      alldata <- rbind(trainset,testset)

      tidydtset <- aggregate(alldata[,c(3:81)],by=list(Subject=alldata$Subject,Activity=alldata$Activity),mean)
      tidydtset <- tidydtset[order(tidydtset$Subject,tidydtset$Activity),]

      movs <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

      for (i in 1:6) {          
         replace<-tidydtset$Activity %in% c(i)
         tidydtset$Activity[replace]<- movs[i]
     }
     write.table(tidydtset, file = "tidydtset.txt", row.names = FALSE)
}


