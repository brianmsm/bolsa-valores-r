# ===== comprar_acciones() =====
# Permite al jugador comprar acciones si tiene fondos

comprar_acciones <- function(estado) {
  cat("\n=== 📈 COMPRA DE ACCIONES ===\n")
  
  # Mostrar empresas disponibles
  print(estado$datos_empresas[, c("ID", "Nombre", "Sector", "PrecioInicial", "AccionesDisponibles")])
  
  id <- entrada_id_valida("🔢 Ingresa el ID de la empresa que deseas comprar: ", estado$datos_empresas$ID)
  
  empresa <- estado$datos_empresas[estado$datos_empresas$ID == id, ]
  
  if (nrow(empresa) == 0) {
    cat("❌ Empresa no encontrada.\n")
    return(estado)
  }
  
  cantidad <- as.integer(readline(prompt = paste("📦 ¿Cuántas acciones deseas comprar de", empresa$Nombre, "? ")))
  
  if (is.na(cantidad) || cantidad <= 0) {
    cat("❌ Cantidad inválida.\n")
    return(estado)
  }
  
  if (cantidad > empresa$AccionesDisponibles) {
    cat("❌ No hay suficientes acciones disponibles.\n")
    return(estado)
  }
  
  costo_total <- cantidad * empresa$PrecioInicial
  
  if (costo_total > estado$capital) {
    cat("❌ No tienes suficiente capital para esta compra.\n")
    return(estado)
  }
  
  # Actualizar cartera
  estado$capital <- estado$capital - costo_total
  estado$datos_empresas$AccionesDisponibles[estado$datos_empresas$ID == id] <- 
    estado$datos_empresas$AccionesDisponibles[estado$datos_empresas$ID == id] - cantidad
  
  if (empresa$ID %in% estado$cartera$ID) {
    idx <- which(estado$cartera$ID == empresa$ID)  
    estado$cartera$Cantidad[idx] <- estado$cartera$Cantidad[idx] + cantidad
    estado$cartera$PrecioCompra[idx] <- 
      (estado$cartera$PrecioCompra[idx] + empresa$PrecioInicial) / 2  # Promedio simple
  } else {
    estado$cartera <- rbind(
      estado$cartera,
      data.frame(
        ID = empresa$ID,
        Empresa = empresa$Nombre,
        Cantidad = cantidad,
        PrecioCompra = empresa$PrecioInicial,
        stringsAsFactors = FALSE
      )
    )
  }
  
  cat("✅ Compra realizada. Has comprado", cantidad, "acciones de", empresa$Nombre, "\n")
  return(estado)
}
