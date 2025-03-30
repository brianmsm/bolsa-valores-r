# ===== vender_acciones() =====
# Permite al jugador vender acciones que posee

vender_acciones <- function(estado) {
  cat("\n=== 💸 VENTA DE ACCIONES ===\n")
  
  if (nrow(estado$cartera) == 0) {
    cat("⚠️  No tienes acciones para vender.\n")
    return(estado)
  }
  
  print(estado$cartera)
  
  id <- entrada_id_valida("🔢 Ingresa el ID de la empresa que deseas vender: ", estado$cartera$ID)
  
  if (!(id %in% estado$cartera$ID)) {
    cat("❌ No tienes acciones de esa empresa.\n")
    return(estado)
  }
  
  idx_cartera <- which(estado$cartera$ID == id)
  nombre <- estado$cartera$Empresa[idx_cartera]
  cantidad_poseida <- estado$cartera$Cantidad[idx_cartera]
  
  cantidad <- as.integer(readline(prompt = paste("📦 ¿Cuántas acciones deseas vender de", nombre, "? ")))
  
  if (is.na(cantidad) || cantidad <= 0) {
    cat("❌ Cantidad inválida.\n")
    return(estado)
  }
  
  if (cantidad > cantidad_poseida) {
    cat("❌ No tienes tantas acciones para vender.\n")
    return(estado)
  }
  
  # Obtener precio actual
  precio_actual <- estado$datos_empresas$PrecioInicial[estado$datos_empresas$Nombre == nombre]
  ganancia <- cantidad * precio_actual
  
  # Actualizar capital
  estado$capital <- estado$capital + ganancia
  
  # Actualizar cartera
  estado$cartera$Cantidad[idx_cartera] <- estado$cartera$Cantidad[idx_cartera] - cantidad
  
  if (estado$cartera$Cantidad[idx_cartera] == 0) {
    estado$cartera <- estado$cartera[-idx_cartera, ]
  }
  
  # Actualizar acciones disponibles en mercado
  estado$datos_empresas$AccionesDisponibles[estado$datos_empresas$ID == id] <- 
    estado$datos_empresas$AccionesDisponibles[estado$datos_empresas$ID == id] + cantidad
  
  cat("✅ Has vendido", cantidad, "acciones de", nombre, "por", ganancia, "euros.\n")
  return(estado)
}
