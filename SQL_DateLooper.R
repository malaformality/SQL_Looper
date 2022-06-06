

# 6/21/2019
# Date Looper - (From Turnover Calculator @ COB)


library(RODBC)
library(tidyverse)
library(lubridate)
dbhandle <- odbcDriverConnect('driver={SQL Server};server=fakeserver;database=fakedatabase;trusted_connection=true')

empcount <- data.frame(date=as.Date(character()),
                       emps=as.numeric())

for (y in 2017:2021){
  for (m in 1:12) {
    loopdate <- mdy(paste(m,1,y, sep = "/"))
    loopemps <- sqlQuery(dbhandle, 
                         paste0("select count(distinct d.empid) emps
                                from fakedetailstable d
                                WHERE fakedate = '",loopdate,"')
                                AND d.importantdetail = 1"))
    
    loopemps <- cbind(loopemps, loopdate)
    empcount <- rbind(empcount, loopemps)
  }
}


