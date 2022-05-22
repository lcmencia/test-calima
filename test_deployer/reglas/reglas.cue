import "list"

// Referencias a los objetos meta, deployment, environment
// y subscriptions definidos en el directorio /schema

meta: _
environment: _
deployment: _
subscriptions: _

// Regla 1: Generar una copia de las suscripciones,
// omitiendo los "metaatributos" (atributos que contienen
// referencias a otros objetos)

#metaAttribs: ["description", "notification", "http", "httpCustom", "url", "headers"]

let data_subscriptions = subscriptions
result: subscriptions: {for label, sub in data_subscriptions {
    (label): {
        // Guardamos una referencia a la subscripcion original
        // en el atributo #originalSubscription
        #originalSubscription: sub

        // Copia de todos los atributos de la subscripcion
        // que no son metaatributos
        for key, val in sub
        if !list.Contains(#metaAttribs, key) {
            (key): val
        }

        // Copia de todos los atributos de la notificacion
        // que no son metaatributos
        notification: {
            for key, val in sub.notification
            if !list.Contains(#metaAttribs, key) {
                (key): val
            }
        }

        // Copia de todos los atributos de notification.http
        // que no son metaatributos
        if sub.notification.http != _|_ {
            notification: http: {
                for key, val in sub.notification.http
                if !list.Contains(#metaAttribs, key) {
                    (key): val
                }
            }
        }

        // Copia de todos los atributos de notification.httpCustom
        // que no son metaatributos
        if sub.notification.httpCustom != _|_ {
            notification: httpCustom: {
                for key, val in sub.notification.httpCustom
                if !list.Contains(#metaAttribs, key) {
                    (key): val
                }
            }
        }
    }
}}

// Regla número 2: Construir la descripción de las subscripciones
// generadas, a partir de los datos de la vertical, la URL y el nombre

result: subscriptions: [label=string]: self={
    
    #endpoint: string
    
    let _originalNotification = self.#originalSubscription.notification
    if _originalNotification.http != _|_ {
        #endpoint: _originalNotification.http.url
    }
    if _originalNotification.httpCustom != _|_ {
        #endpoint: _originalNotification.httpCustom.url
    }

    // TODO: Modificar la cadena de texto para sustituir los valores
    // de las variables indicadas, de forma que el resultado coincida
    // con los valores vistos en el fichero resultado/result.json
    description: "DEPLOYER:[meta.name]:[meta.version]:[#endpoint]:[label]"
}

// Regla número 3: Reemplazar los valores de las URL de la notificacion
// usando la lista de endpoints del environment.

result: subscriptions: [string]: self={

    let _originalNotification = self.#originalSubscription.notification
    notification: http?: url: environment.notificationEndpoints[_originalNotification.http.url]
    // TODO: Reemplazar la URL por el valor correspondiente de environment.notificationEndpoints
    notification: httpCustom?: url: "[valor del notificationEndpoint correspondiente]"
}

// Regla número 4: Reemplazar los valores de las cabeceras http
// del atributo httpCustom.headers de la notificación.
result: subscriptions: [string]: self={

    let _originalNotification = self.#originalSubscription.notification
    notification: httpCustom?: headers: {
        for key, val in _originalNotification.httpCustom.headers {
            // TODO: añadir un atributo por cada (key),
            // reemplazando el valor del atributo por el correspondiente valor
            // de deployment.customHeaders, de forma que el resultado coincida
            // con los valores vistos en el fichero resultado/result.json
            ...
        }
    }
}
