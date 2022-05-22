deployment: {
    // Lista de orígenes desde los que obtener los ficheros de configuración
    sources: {
        [string]: {
            git?: string
            tag?: string
            path?: string
            files: [...string]
        }
    }
    subservice: string // Nombre del subservicio (Fiware-Servicepath)
    // Diccionario para variables genéricas
    variables: {
        [string]: int
    }
}
