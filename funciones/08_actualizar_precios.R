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
  
  cat("\n📊 Cambios en el mercado:\n")
  for (i in idx_empresas) {
    precio_anterior <- estado$datos_empresas$PrecioActual[i]
    nuevo_precio <- round(precio_anterior * (1 + impacto), 2)
    nuevo_precio <- max(nuevo_precio, 1)
    
    estado$datos_empresas$PrecioActual[i] <- nuevo_precio
    
    cambio <- nuevo_precio - precio_anterior
    emoji <- if (cambio > 0) "📈" else if (cambio < 0) "📉" else "➖"
    cat(emoji, estado$datos_empresas$Nombre[i], ": de", precio_anterior, "→", nuevo_precio, "\n")
  }
  
  return(estado)
}
