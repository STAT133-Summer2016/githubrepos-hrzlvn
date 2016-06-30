#' Find the distance between two points on the Earth's surface
#' 
#' Specify the location of the points by latitude and longitude.  The calculation is done
#' under the assumption that the Earth is a sphere of radius 6371 km, using the Haversine formula. The 
#' distance calculated is a great-circle distance on a sphere.  This will be accurate within 10s of miles for 
#' points in distant parts of the Earth.  For points that are nearby (say, in the same city) the accuracy is much better, meters.
#' )
#' 
#' @param lat1 Latitude of the first point
#' @param lon1 Longitude of the first point
#' @param lat2 Latitude of the first point
#' @param lon2 Longitude of the first point
#' @param Radius The radius of the sphere.  Whatever are the units of \code{Radius} will be units of the distance. Default: 6371 km, the radius of the Earth.
#' 
#' @return a single number giving the distance.  The units in which the distance is expressed is the same as \code{Radius}.
#' 
#' @examples 
#' # Macalester College to Amherst College
#' haversine(44.9392, -93.1680, 42.3708, -72.5169)
#' 

haversine <- function(lat1, lon1, lat2, lon2, Radius=6371){ # in km
  lat1 <- pi*lat1/180; lat2 <- pi*lat2/180; 
  lon1 <- pi*lon1/180; lon2 <- pi*lon2/180;
  dlon <- lon2 - lon1 
  dlat <- lat2 - lat1 
  a <- (sin(dlat/2))^2 + cos(lat1) * cos(lat2) * (sin(dlon/2))^2 
  c <- 2 * atan2( sqrt(a), sqrt(1-a) ) 
  Radius * c 
}
