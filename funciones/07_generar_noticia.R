# ===== generar_noticia() =====
# Selecciona una noticia aleatoria no repetida

generar_noticia <- function(estado) {
  # Noticias disponibles aún no usadas
  usadas <- estado$historial_noticias
  noticias_disponibles <- estado$noticias[!(estado$noticias$ID %in% usadas), ]
  
  if (nrow(noticias_disponibles) == 0) {
    cat("⚠️  No quedan noticias nuevas.\n")
    return(NULL)
  }
  
  # Elegir aleatoriamente una noticia
  seleccion <- noticias_disponibles[sample(nrow(noticias_disponibles), 1), ]
  
  # Registrar en historial
  estado$historial_noticias <- c(estado$historial_noticias, seleccion$ID)
  
  cat("\n🗞️  NOTICIA DEL DÍA:\n")
  cat("📰", seleccion$Noticia, "\n")
  
  return(list(estado = estado, noticia = seleccion))
}
