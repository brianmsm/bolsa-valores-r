# ===== actualizar_precios() =====
# Modifica precios según la noticia seleccionada

actualizar_precios <- function(estado, noticia) {
  area_afectada <- noticia$Area
  impacto <- noticia$Impacto / 100  # Convertimos a porcentaje decimal
  
  idx_empresas <- which(estado$datos_empresas$Sector == area_afectada)
  
  if (length(idx_empresas) == 0) {
    cat("ℹ️  Ninguna empresa fue afectada por esta noticia.\n")
    return(estado)
  }
  
  for (i in idx_empresas) {
    precio_original <- estado$datos_empresas$PrecioInicial[i]
    nuevo_precio <- round(precio_original * (1 + impacto), 2)
    estado$datos_empresas$PrecioInicial[i] <- max(nuevo_precio, 1)  # Precio mínimo: 1 euro
  }
  
  cat("📊 Precios actualizados en el sector", area_afectada, "\n")
  return(estado)
}
