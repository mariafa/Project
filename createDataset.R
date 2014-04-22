createDataset <- function(directory) {    
      ## 'directory' is a character vector of length 1 indicating
      ## the location of the files (train/test)   

      #load mean and std labels 
      feats <- read.table("features.txt")
      cols <-grep("mean",feats$V2)                    #puts cols mean into vector
      cols <- append(cols, grep("std",feats$V2))      #adds cols std  
      cols<-sort(cols)

      #load 561-feature vector 
      
      if (directory == "test")
             file <- "_test.txt"
      else
             file <- "_train.txt"

      path<-getwd()
      directory<-paste(path,directory,sep="/")

      filename<-paste("X",file,sep="")
      filename<-paste(directory,filename,sep="/")
      data<-read.table(filename)

      data<-data[,cols]

      #load subjects

      filename<-paste("subject",file,sep="")
      filename<-paste(directory,filename,sep="/")
      subj<-read.table(filename)

      #load activities

      filename<-paste("y",file,sep="")
      filename<-paste(directory,filename,sep="/")
      activ<-read.table(filename)

      alldata <- data.frame(subj, activ, data) 
     
      #labels columns with activity names

      feats <-  feats[feats$V1 %in% cols,]   
      colnames <-  feats$V2
      namecols <- as.character(colnames)
      str(namecols)
      namecols <- append (c("Subject","Activity"),namecols) 

      colnames(alldata) <- namecols

      return(alldata)
}
