#' @title Charger la couche cartographique adaptée à vos données
#' @name loadMap
#' @description Charger la couche cartographique adaptée à vos données en indiquant l'année du code officiel géographique (COG) ainsi que le niveau géographique (communal ou supra-communal) souhaités
#' @param destfile indique le "path" où sera enregistrée la couche cartographique téléchargée (4 fichiers shp,shx,prj et dbf). Par défaut vaut tempfile() (répertoire temporaire)
#' @param COG indique l'année de COG de la table communale considérée. (exemple 2017). Années possibles : de 2015 à 2017. Par défaut, vaut annee_ref.
#' @param nivsupra est une chaîne de caractères qui indique le nom du niveau supra-communale souhaité. Plus précisément :
#' - "DEP" : départements
#' - "REG" : régions
#' - "EPCI" : EPCI au 01/01/20XX
#' - "ARR" : arrondissements au 01/01/20XX
#' - "CV" : cantons-villes au 01/01/20XX
#' - "ZE2010" : zones d'emploi 2010
#' - "UU2010" : unités urbaines 2010
#' - "AU2010" : aires urbaines 2010
#' - "BV2012" : bassins de vie 2012
#' @param donnees_insee vaut TRUE si les données manipulées sont produites par l'Insee. En effet, quelques rares modifications communales (la défusion des communes Loisey et Culey au 1er janvier 2014 par exemple) ont été prises en compte dans les bases de données communales de l'Insee plus tard que la date officielle.
#' @details
#' La fonction renvoie une couche cartographique de type "sf"
#'
#' Le code officiel géographique le plus récent du package est actuellement celui au 01/01/2017. \cr
#'
#' Les millésimes des COG qui peuvent être utilisés sont à ce stade les suivants : 2015, 2016 et 2017. \cr
#' @references
#' \itemize{
#' \item{\href{http://professionnels.ign.fr/adminexpress}{couches cartographiques Admin-Express (IGN)}}
#' \item{\href{http://professionnels.ign.fr/geofla}{couches cartographiques GEOFLA (IGN)}}}
#' @export
#' @examples
#' ## Exemple 1
#' ## Do not run (downloads files to your tempdir())
#' # reg_sf <- loadMap(COG=2016,nivsupra="REG")
#' # par(mar=c(0,0,0,0))
#' # plot(sf::st_geometry(reg_sf))
#' @encoding UTF-8


loadMap <- function(destfile=tempdir(),COG=annee_ref,nivsupra,donnees_insee=F){
    shpOrigin="IGN"
    string_insee <- ifelse(donnees_insee & COG==2015 & nivsupra=="COM","_insee","")
    url <- paste0("https://raw.githubusercontent.com/antuki/CARTElette/master/couches_carto/",shpOrigin,"/COG",COG,"/")
    download.file(paste0(url,nivsupra,"_",COG,string_insee,"_CARTElette.dbf"),destfile = paste0(destfile,"/",nivsupra,"_",COG,"_CARTElette.dbf"),method="auto",mode="wb")
    download.file(paste0(url,nivsupra,"_",COG,string_insee,"_CARTElette.prj"),destfile = paste0(destfile,"/",nivsupra,"_",COG,"_CARTElette.prj"),method="auto",mode="wb")
    download.file(paste0(url,nivsupra,"_",COG,string_insee,"_CARTElette.shp"),destfile = paste0(destfile,"/",nivsupra,"_",COG,"_CARTElette.shp"),method="auto",mode="wb")
    download.file(paste0(url,nivsupra,"_",COG,string_insee,"_CARTElette.shx"),destfile = paste0(destfile,"/",nivsupra,"_",COG,"_CARTElette.shx"),method="auto",mode="wb")
    sf::st_read(dsn=paste0(destfile,"/",nivsupra,"_",COG,"_CARTElette.shp"),stringsAsFactors = F)
  }

