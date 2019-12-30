//
//  DateFormatter+EMT.swift
//  CoreEMT
//
//  Created by Adolfo Vera Blasco on 18/10/2019.
//  Copyright © 2019 desappstre {eStudio}. All rights reserved.
//

import Foundation

extension DateFormatter
{
    /**
        Formato específico usado por el API de la
        EMT de Madrid.

        Un ejemplo del tipo de formato de fecha que nos podemos 
        encontrar es el que se muestra a continuación

        ```
        2019-06-21T11:48:27.8800000
        ```

        Como curiosidad hacer notar que la última parte de 
        la fecha hacer referencia al **número de milisegundos
        en el día**

        Más información acerca del formato de fechas en
        la página oficial del [Consorcio Unicode](http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns)
        
    */
    public static let emtFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.A"

        return formatter
    }()

    /**
        Formato usado en la operación de información general
        sobre las líneas de autobús.

        Es un formato corto de fecha donde sólo se emplead el 
        día, mes y año-

        ```
        {
            "startDate" : "24/09/2008",
            "endDate" : "16/09/2009"
        }        
        ```
    */
    public static let emtShortFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"

        return formatter
    }()

    /**
        Formato de fecha empleado en la operación de incidencias
        en las líneas de autobús.

        Este formato aparece en los campos `rssAfectaDesde` y
        `rssAfectaHasta`.

        Un ejemplo de fecha que podemos encontrar en el 
        documento sería:

        ```
        20/10/2019 11:30:00
        ```
    */
    public static let incidentFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"

        return formatter
    }()

    /**
        Formato de fecha empleado en la operación de incidencias
        en las líneas de autobús.

        Este formato aparece en los campos `pubDate` y cumple con
        la especificación para feeds.

        Un ejemplo de fecha que podemos encontrar en el 
        documento sería:

        ```
        Sun, 20 Oct 2019 01:05:34 GMT
        ```
    */
    public static let feedFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"

        return formatter
    }()

    /**
        Formato de fecha que se emplea en la operación 
        de **detalle para una línea de autobús**.

        Se espera una fecha con formato `YYYYMMdd`, como
        por ejemplo:

        ```
        20191107
        ```
    */
    internal static let todayReferenceDate: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMdd"

        return formatter.string(from: Date())
    }()
}