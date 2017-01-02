import Kitura
import KituraNet
import Foundation

let bot = QiitaSlackBot(withConfig: ConfigLoader.config())

DispatchQueue.global().async {
    
    let router = Router()
    
    router.post("/send") { request, response, next in
        bot.fetchTodayItems()
        _ = response.send(status: .OK)
        next()
    }
    
    Kitura.addHTTPServer(onPort: 8090, with: router)
    
    Kitura.run()
}

RunLoop.main.run()
