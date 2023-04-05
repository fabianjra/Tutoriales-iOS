import UIKit


let paths = Bundle.main.paths(forResourcesOfType: "txt", inDirectory: nil)

let fileHandle = FileHandle(forReadingAtPath: paths[0])

//*************************************************
// OBTENER BYTES DE UN ARCHIVO TXT
//*************************************************

Task {
    for try await line in fileHandle!.bytes {
        debugPrint("byte linea: \(line)")
    }
}

//*************************************************
// OBTENER DATOS DE UN ARCHIVO TXT
//*************************************************

Task {
    let url = URL(fileURLWithPath: paths[0])
    
    for try await line in url.lines {
        debugPrint("linea: \(line)")
    }
}

//*************************************************
// OBTENER BYTES DE UNA PAGINA WEB
//*************************************************

let url = URL(string: "https://www.google.com")!

Task {
    let (bytes, _) = try await URLSession.shared.bytes(from: url)
    
    for try await byte in bytes {
        debugPrint("byte: \(byte)")
    }
}

//*************************************************
// NOTIFICATIONS CENTER:
//*************************************************

//ejemplo de como se puede obtener datos de notificacion de forma asincrona, con sequence.

Task {
    let center = NotificationCenter.default
    
    let _ = await center.notifications(named: UIApplication.didEnterBackgroundNotification).first {
        
        guard let key = ($0.userInfo?["key"]) as? String else {
            return false
        }
        
        return key == "someValue"
    }
}
