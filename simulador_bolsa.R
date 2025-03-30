##############################################################
 # Proyecto: Simulador de Bolsa de Valores
 # Autor: Brian Norman Peña-Calero
 # Universidad Complutense de Madrid
 # Curso: Programación Avanzada en R
 # Descripción: Juego interactivo por consola para invertir
 #             en acciones ficticias según noticias económicas
 ##############################################################



##############################################################
 # 00_UTILS.R 
 ##############################################################

 # ===== entrada_id_valida() =====
# Verificar que se está ingresando una opción válida

entrada_id_valida <- function(prompt, ids_validos) {
  repeat {
    entrada <- readline(prompt)
    
    if (entrada == "0") {
      cat("🔙 Operación cancelada. Volviendo al menú.\n")
      return(0)
    }
    
    if (grepl("^[0-9]+$", entrada)) {
      id <- as.integer(entrada)
      if (id %in% ids_validos) {
        return(id)
      }
    }
    
    cat("❌ ID no válido. Elige uno de los siguientes:", paste(ids_validos, collapse = ", "), "\n")
    cat("💡 Ingresa 0 para cancelar y volver al menú.\n")
  }
}

# ===== cartera_con_valor_actual() =====
# Devuelve la cartera con columna PrecioActual unida desde datos_empresas

cartera_con_valor_actual <- function(estado) {
  cartera_extendida <- merge(
    estado$cartera,
    estado$datos_empresas[, c("ID", "PrecioActual")],
    by = "ID"
  )
  cartera_extendida <- cartera_extendida[, c("ID", "Empresa", "Cantidad", "PrecioCompra", "PrecioActual")]
  return(cartera_extendida)
} 


##############################################################
 # 01_CARGAR_DATOS.R 
 ##############################################################

 # ===== cargar_datos() =====
# Lee las bases de datos necesarias para el simulador

cargar_datos <- function(path_noticias = "noticias_bolsa.csv") {
  url_respaldo <- "https://raw.githubusercontent.com/brianmsm/bolsa-valores-r/main/noticias_bolsa.csv"

  if (!file.exists(path_noticias)) {
    warning("⚠️  Archivo de noticias no encontrado localmente. Intentando descargar desde internet...")

    tryCatch({
      download.file(url_respaldo, destfile = path_noticias, quiet = TRUE)
      cat("✅ Archivo de noticias descargado correctamente.\n")
    }, error = function(e) {
      stop("❌ No se pudo descargar el archivo de noticias desde GitHub. Verifica tu conexión.")
    })
  }
  
  # Dado que solo se puede cargar un archivo, los datos de empresa 
  # se ingresan de forman manual.
  # path_empresas = "datos_empresas.csv" # Esto se quitó de argumento
                                         # de la función
  # if (!file.exists(path_empresas)) {
  #   stop("No se encontró el archivo de empresas: ", path_empresas)
  # }

  # Leer datos
  noticias <- read.csv(path_noticias, stringsAsFactors = FALSE, encoding = "UTF-8")
  
  # empresas <- read.csv(path_empresas, stringsAsFactors = FALSE, encoding = "UTF-8")

  empresas <- data.frame(
    ID = 1:5,
    Nombre = c("TechNova", "FarmaSalud", "GeoMiner", "Renova", "VoltEner"),
    Sector = c("Tecnología", "Farmacéutica", "Minería", "Renovables", "Energía"),
    PrecioInicial = c(150, 90, 60, 110, 100),
    AccionesDisponibles = c(20, 25, 30, 22, 24),
    stringsAsFactors = FALSE
  )

  # Validaciones mínimas
  if (!all(c("ID", "Area", "Noticia", "Impacto") %in% names(noticias))) {
    stop("El archivo de noticias no contiene las columnas esperadas.")
  }

  if (!all(c("ID", "Nombre", "Sector", "PrecioInicial", "AccionesDisponibles") %in% names(empresas))) {
    stop("El archivo de empresas no contiene las columnas esperadas.")
  }

  return(list(noticias = noticias, empresas = empresas))
} 


##############################################################
 # 02_INICIALIZAR_JUEGO.R 
 ##############################################################

 # ===== inicializar_juego() =====
# Inicializa el estado del juego con opción de mensajes

inicializar_juego <- function(capital_inicial = 2000) {
  datos <- cargar_datos()
  
  # Añadir columna de PrecioActual
  datos$empresas$PrecioActual <- datos$empresas$PrecioInicial
  
  estado <- list(
    dia = 1,
    capital = capital_inicial,
    cartera = data.frame(
      ID = integer(),
      Empresa = character(),
      Cantidad = integer(),
      PrecioCompra = numeric(),
      stringsAsFactors = FALSE
    ),
    historial_noticias = character(),
    datos_empresas = datos$empresas,
    noticias = datos$noticias
  )
 
  return(estado)
} 


##############################################################
 # 03_MOSTRAR_MENU.R 
 ##############################################################

 # ===== mostrar_menu() =====
# Imprime el menú principal con opciones del simulador

mostrar_menu <- function() {
  cat("\n")
  cat("======================================\n")
  cat("   🎮 SIMULADOR DE BOLSA DE VALORES\n")
  cat("======================================\n")
  cat("Elige una opción:\n")
  cat("1️⃣  Comprar acciones\n")
  cat("2️⃣  Vender acciones\n")
  cat("3️⃣  Mantener inversión\n")
  cat("4️⃣  Mostrar estado actual 💰\n")
  cat("5️⃣  Finalizar juego ❌\n")
  cat("======================================\n")
} 


##############################################################
 # 04_PROCESAR_DECISION.R 
 ##############################################################

 # ===== procesar_decision() =====
# Lee y valida la entrada del jugador (opciones del menú)

procesar_decision <- function() {
  opciones_validas <- 1:5
  
  repeat {
    opcion <- readline(prompt = "Selecciona una opción (1-5): ")
    
    # Validar si es número y está dentro del rango
    if (grepl("^[1-5]$", opcion)) {
      return(as.integer(opcion))
    } else {
      cat("❌ Entrada inválida. Por favor elige un número entre 1 y 5.\n")
    }
  }
} 


##############################################################
 # 05_COMPRAR_ACCIONES.R 
 ##############################################################

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


##############################################################
 # 06_VENDER_ACCIONES.R 
 ##############################################################

 # ===== vender_acciones() =====
# Permite al jugador vender acciones que posee

vender_acciones <- function(estado) {
  cat("💵 Capital disponible:", estado$capital, "euros\n\n")
  cat("\n=== 💸 VENTA DE ACCIONES ===\n")

  if (nrow(estado$cartera) == 0) {
    cat("⚠️  No tienes acciones para vender.\n")
    return(estado)
  }
  
  cartera_extendida <- cartera_con_valor_actual(estado)
  print(cartera_extendida, row.names = FALSE)
  
  id <- entrada_id_valida("🔢 Ingresa el ID de la empresa que deseas vender (0 para cancelar): ", estado$cartera$ID)

  if (id == 0) {
    return(estado)
  }
  
  idx_cartera <- which(estado$cartera$ID == id)
  nombre <- estado$cartera$Empresa[idx_cartera]
  cantidad_poseida <- estado$cartera$Cantidad[idx_cartera]
  
  repeat {
    cantidad <- as.integer(readline(prompt = paste("📦 ¿Cuántas acciones deseas vender de", nombre, "? (0 para cancelar): ")))
    
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
    
    if (cantidad > cantidad_poseida) {
      cat("❌ No tienes tantas acciones para vender.\n")
      next
    }
    
    # Obtener precio actual
    precio_actual <- estado$datos_empresas$PrecioActual[estado$datos_empresas$ID == id]
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
} 


##############################################################
 # 07_GENERAR_NOTICIA.R 
 ##############################################################

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


##############################################################
 # 08_ACTUALIZAR_PRECIOS.R 
 ##############################################################

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
  
  # Aplicar cambio aleatorio leve a otras empresas
  otros_idx <- setdiff(seq_len(nrow(estado$datos_empresas)), idx_empresas)
  
  if (length(otros_idx) > 0) {
    cat("\n🌐 Variaciones generales del mercado:\n")
    for (i in otros_idx) {
      ruido <- runif(1, -0.02, 0.02)  # ±2%
      precio_anterior <- estado$datos_empresas$PrecioActual[i]
      nuevo_precio <- round(precio_anterior * (1 + ruido), 2)
      nuevo_precio <- max(nuevo_precio, 1)
      
      estado$datos_empresas$PrecioActual[i] <- nuevo_precio
      
      emoji <- if (nuevo_precio > precio_anterior) "↗️" else if (nuevo_precio < precio_anterior) "↘️" else "➖"
      cat(emoji, estado$datos_empresas$Nombre[i], ": de", precio_anterior, "→", nuevo_precio, "\n")
    }
  }

  return(estado)
} 


##############################################################
 # 09_MOSTRAR_ESTADO_ACTUAL.R 
 ##############################################################

 # ===== mostrar_estado_actual() =====
# Muestra el estado financiero actual del jugador

mostrar_estado_actual <- function(estado) {
  cat("\n=== 💰 ESTADO ACTUAL ===\n")
  cat("📆 Día:", estado$dia, "\n")
  cat("💵 Capital disponible:", estado$capital, "euros\n")
  
  cat("\n📦 Cartera de acciones:\n")
  if (nrow(estado$cartera) == 0) {
    cat("No tienes acciones en tu cartera.\n")
  } else {
    cartera_extendida <- cartera_con_valor_actual(estado)
    print(cartera_extendida, row.names = FALSE)
  }

  cat("\n🏢 Empresas en el mercado:\n")
  print(estado$datos_empresas[, c("ID", "Nombre", "Sector", "PrecioInicial", "PrecioActual", "AccionesDisponibles")], row.names = FALSE)
} 


##############################################################
 # 10_MANTENER.R 
 ##############################################################

 # ===== mantener() =====
# El jugador decide no realizar ninguna acción

mantener <- function(estado) {
  cat("\n⏸️ Has decidido mantener tus inversiones sin cambios por hoy.\n")
  return(estado)
} 


##############################################################
 # 11_FINALIZAR_JUEGO.R 
 ##############################################################

 # ===== finalizar_juego() =====
# Muestra el resumen final del jugador

finalizar_juego <- function(estado) {
  cat("\n========= 🧾 RESUMEN FINAL =========\n")
  
  cat("💵 Capital final:", estado$capital, "euros\n")
  
  valor_acciones <- 0
  if (nrow(estado$cartera) > 0) {
    cartera_valorizada <- cartera_con_valor_actual(estado)
    cartera_valorizada$ValorActual <- cartera_valorizada$Cantidad * cartera_valorizada$PrecioActual
    valor_acciones <- sum(cartera_valorizada$ValorActual)
    
    cat("\n📦 Valor actual de tus acciones:", valor_acciones, "euros\n")
  } else {
    cat("\n📦 No tienes acciones en tu cartera.\n")
  }
  
  patrimonio <- estado$capital + valor_acciones
  cat("💰 Patrimonio total:", patrimonio, "euros\n")
  
  if (patrimonio > 2000) {
    cat("\n=========================================\n")
    cat("🏆  ¡VICTORIA!\n")
    cat("🎉 ¡Felicidades! Terminaste con ganancias.\n")
    cat("=========================================\n")
  } else if (patrimonio < 2000) {
    cat("\n=========================================\n")
    cat("📉  PÉRDIDAS\n")
    cat("😬 Terminaste con pérdidas. ¡Sigue practicando!\n")
    cat("=========================================\n")
  } else {
    cat("\n=========================================\n")
    cat("😐  NEUTRO\n")
    cat("Terminaste igual que empezaste.\n")
    cat("=========================================\n")
  }
  
  return(invisible(estado))
} 


##############################################################
 # 12_JUGAR_BOLSA.R 
 ##############################################################

 # ===== jugar_bolsa() =====
# Lógica principal del juego

jugar_bolsa <- function() {
  estado <- inicializar_juego()

  cat("🎮 Bienvenido al Simulador de Bolsa\n")
  cat("💰 Capital inicial:", estado$capital, "euros\n")
  cat("📈 Turnos: 20 días\n")
  cat("📦 Acciones disponibles:", nrow(estado$datos_empresas), "empresas\n\n")
  
  cat("📌 Instrucciones:\n")
  cat("- Cada día recibirás una noticia económica.\n")
  cat("- Basándote en ella, deberás decidir si comprar, vender o mantener tus inversiones.\n")
  cat("- Pero ¡cuidado! Los efectos reales de la noticia se verán **después** de que tomes tu decisión.\n")
  cat("- Tu objetivo es terminar con un patrimonio mayor a tu capital inicial.\n\n")
  cat("¡Buena suerte, inversionista! 💼📊\n")
  
  repeat {
    cat("\n=====================================\n")
    cat("📆 Día", estado$dia, "de 20\n")
    cat("💵 Capital disponible:", estado$capital, "euros\n")

    # Día 1: sin noticia, sin impacto
    if (estado$dia > 1) {
      d <- generar_noticia(estado)
      if (!is.null(d)) {
        estado <- d$estado
        attr(estado, "noticia_actual") <- d$noticia  # guardamos para aplicar impacto luego
      }
    }
    
    mostrar_menu()
    opcion <- procesar_decision()
    
    # Pasándolo con switch para no anidar múltiples if_else
    # Aunque igual hay que hacer algunas precisiones más abajo
    accion <- switch(opcion,
      comprar_acciones,
      vender_acciones,
      mantener,
      mostrar_estado_actual,
      "salir"
    )
    
    if (is.character(accion) && accion == "salir") {
      cat("🚪 Has decidido salir del juego.\n")
      break
    } else if (identical(accion, mostrar_estado_actual)) {
      accion(estado)
      next
    } else {
      estado <- accion(estado)
      
      # Ahora sí, mostrar impacto del mercado tras la acción
      if (!is.null(attr(estado, "noticia_actual"))) {
        noticia <- attr(estado, "noticia_actual")
        estado <- actualizar_precios(estado, noticia)
        attr(estado, "noticia_actual") <- NULL  # limpiar
      }
      
      estado$dia <- estado$dia + 1
    }
    
    # Fin automático al día 20
    if (estado$dia > 20) {
      cat("\n⏳ Has llegado al final de los 20 días.\n")
      break
    }
  }
  
  finalizar_juego(estado)
} 


##############################################################
 # EJECUCIÓN DEL JUEGO AL EJECUTAR EL SCRIPT
 ##############################################################

 jugar_bolsa()
