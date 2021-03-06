## Can now be deployed with R 4.0
library('rsconnect')
setwd(here::here("inst", "shinycsv"))
load('.deploy_info.Rdata')
rsconnect::setAccountInfo(name=deploy_info$name, token=deploy_info$token,
    secret=deploy_info$secret)
deployApp(appFiles = c('ui.R', 'server.R'),
    appName = 'shinycsv', account = deploy_info$name)

deployApp(appFiles = c('ui.R', 'server.R', 'DESCRIPTION'),
    appName = 'shinycsv-showcase', account = deploy_info$name)
