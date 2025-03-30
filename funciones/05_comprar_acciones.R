# ===== comprar_acciones() =====
# Permite al jugador comprar acciones si tiene fondos

comprar_acciones <- function(estado) {
  cat("💵 Capital disponible:", estado$capital, "euros\n\n")
  cat("\n=== 📈 COMPRA DE ACCIONES ===\n")
  
  # Mostrar empresas disponibles
  print(estado$datos_empresas[, c("ID", "Nombre", "Sector", "PrecioInicial", "PrecioActual", "AccionesDisponibles")])
  
  id <- entrada_id_valida("🔢 Ingresa el ID de la empresa que deseas comprar (0 para cancelar): ", estado$datos_empresas$ID)

  if (id == 0) {
    return(estado)
  }

  empresa <- estado$datos_empresas[estado$datos_empresas$ID == id, ]
  
  repeat {
    cantidad <- as.integer(readline(prompt = paste("📦 ¿Cuántas acciones deseas comprar de", empresa$Nombre, "? (0 para cancelar): ")))
    
    if (is.na(cantidad)) {
      cat("❌ Entrada inválida.\n")
      next
    }
    
    if (cantidad == 0) {
      cat("🔙 Operación cancelada. Volviendo al menú.\n")
      return(estado)
    }
    
    if (cantidad <= 0) {
      cat("❌ Cantidad inválida.\n")
      next
    }
    
    if (cantidad > empresa$AccionesDisponibles) {
      cat("❌ No hay suficientes acciones disponibles.\n")
      next
    }
    
    costo_total <- cantidad * empresa$PrecioActual
    
    if (costo_total > estado$capital) {
      cat("❌ No tienes suficiente capital para esta compra.\n")
      next
    }
    
    # Si todo está bien, se ejecuta la compra:
    estado$capital <- estado$capital - costo_total
    estado$datos_empresas$AccionesDisponibles[estado$datos_empresas$ID == id] <- 
      estado$datos_empresas$AccionesDisponibles[estado$datos_empresas$ID == id] - cantidad
    
    if (empresa$ID %in% estado$cartera$ID) {
      idx <- which(estado$cartera$ID == empresa$ID)  
      estado$cartera$Cantidad[idx] <- estado$cartera$Cantidad[idx] + cantidad
      estado$cartera$PrecioCompra[idx] <- 
        (estado$cartera$PrecioCompra[idx] + empresa$PrecioActual) / 2
    } else {
      estado$cartera <- rbind(
        estado$cartera,
        data.frame(
          ID = empresa$ID,
          Empresa = empresa$Nombre,
          Cantidad = cantidad,
          PrecioCompra = empresa$PrecioActual,
          stringsAsFactors = FALSE
        )
      )
    }
    
    cat("✅ Compra realizada. Has comprado", cantidad, "acciones de", empresa$Nombre, "\n")
    return(estado)
  }
}
